import 'package:flutter/material.dart';
import '../api_service.dart';
import 'car_rental_ticket.dart';
import 'bus_ticket.dart';
import 'cinema_ticket.dart';
import 'event_ticket.dart';
import 'airline_ticket.dart';
import 'tour_ticket.dart';

class HomeScreen extends StatefulWidget {
  final ApiService apiService;

  const HomeScreen({super.key, required this.apiService});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _dataFutures;

  @override
  void initState() {
    super.initState();
    _dataFutures = Future.wait([
      widget.apiService.fetchCars(),
      widget.apiService.fetchBuses(),
      widget.apiService.fetchMovies(),
      widget.apiService.fetchEvents(),
      widget.apiService.fetchFlights(),
      widget.apiService.fetchTours(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments as int?;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F0C29), Color(0xFF302B63)],  // Matching with your intro theme
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            'Explore the World',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, size: 30, color: Colors.white),
              onPressed: () {
                if (userId != null) {
                  Navigator.pushNamed(context, '/profile', arguments: userId);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User ID is not available')),
                  );
                }
              },
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Color(0xFF00B4D8), width: 4), // Matching theme accent color
              insets: EdgeInsets.symmetric(horizontal: 16),
            ),
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            labelColor: Color(0xFF00B4D8),
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.car_rental), text: "Cars"),
              Tab(icon: Icon(Icons.bus_alert), text: "Buses"),
              Tab(icon: Icon(Icons.movie), text: "Movies"),
              Tab(icon: Icon(Icons.event), text: "Events"),
              Tab(icon: Icon(Icons.flight), text: "Flights"),
              Tab(icon: Icon(Icons.tour), text: "Tours"),
            ],
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: _dataFutures,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return _buildErrorScreen(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final carRentals = snapshot.data![0];
              final busTickets = snapshot.data![1];
              final cinemaTickets = snapshot.data![2];
              final eventTickets = snapshot.data![3];
              final airlineTickets = snapshot.data![4];
              final tourTickets = snapshot.data![5];

              return TabBarView(
                children: [
                  CarRentalScreen(apiService: widget.apiService),
                  //CarRentalScreen(apiService: widget.apiService, carRentals: carRentals),
                  BusTicketScreen(apiService: widget.apiService),
                  CinemaTicketScreen(apiService: widget.apiService, cinemaTickets: cinemaTickets),
                  EventPlanningScreen(apiService: widget.apiService, eventTickets: eventTickets),
                  AirlineTicketScreen(apiService: widget.apiService, airlineTickets: airlineTickets),
                  TourPlanningScreen(apiService: widget.apiService, tourTickets: tourTickets),
                ],
              );
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildTabContent(String title, List<dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F0C29), Color(0xFF302B63)],  // Matching with intro theme
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F0C29), Color(0xFF302B63)],  // Matching with intro theme
                  ),
                ),
                child: const Icon(Icons.directions_car, color: Colors.white),
              ),
              title: Text(
                item['name'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                item['description'],
                style: const TextStyle(color: Colors.black54),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600),
              onTap: () {
                // Handle navigation
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorScreen(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.redAccent),
          const SizedBox(height: 16),
          Text(
            'Error: $errorMessage',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _dataFutures = Future.wait([
                  widget.apiService.fetchCars(),
                  widget.apiService.fetchBuses(),
                  widget.apiService.fetchMovies(),
                  widget.apiService.fetchEvents(),
                  widget.apiService.fetchFlights(),
                  widget.apiService.fetchTours(),
                ]);
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B4D8),  // Matching with the theme accent
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
