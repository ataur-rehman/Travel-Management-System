import 'package:flutter/material.dart';
import '../api_service.dart'; // Import ApiService for API calls

class AirlineTicketScreen extends StatelessWidget {
  final ApiService apiService; // API Service instance
  final List<dynamic> airlineTickets;

  const AirlineTicketScreen({
    Key? key,
    required this.apiService,
    required this.airlineTickets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Available Flights',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: apiService.fetchFlights(), // Fetch flights from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return _buildErrorScreen(snapshot.error.toString());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _buildFlightList(snapshot.data!);
          } else {
            return const Center(
              child: Text(
                'No flights available.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFlightList(List<dynamic> flights) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: flights.length,
      itemBuilder: (context, index) {
        final flight = flights[index];
        return Card(
          elevation: 6,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: const Icon(
              Icons.flight_takeoff,
              size: 40,
              color: Colors.blue,
            ),
            title: Text(
              flight["flightName"] ?? "Unknown Flight",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              "Route: ${flight["route"] ?? "Not available"}\nClass: ${flight["class"] ?? "Unknown"}",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            trailing: SizedBox(
              width: 100, // Constrain the width of the trailing widget
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2193b0),
                      minimumSize: const Size(80, 40), // Fixed button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Booked flight: ${flight["flightName"] ?? "Unknown"}'),
                        ),
                      );
                    },
                    child: const Text(
                      "Book",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorScreen(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Something went wrong!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2193b0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              // Add retry logic
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
