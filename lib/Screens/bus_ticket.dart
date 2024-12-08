import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourapp2/api_service.dart';

class BusTicketScreen extends StatefulWidget {
  final ApiService apiService;
  const BusTicketScreen({Key? key, required this.apiService}) : super(key: key);

  @override
  _BusTicketScreenState createState() => _BusTicketScreenState();
}

class _BusTicketScreenState extends State<BusTicketScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  List<dynamic> buses = [];

  // Function to search buses
  void searchBuses() async {
    if (_fromController.text.isEmpty || _toController.text.isEmpty) return;

    try {
      final result = await widget.apiService.fetchBuses(
        //_fromController.text,
     //   _toController.text,
      );
      print('API Response: $result'); // Debugging print

      setState(() {
        buses = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching buses: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Function to book a ticket
  void bookTicket(dynamic bus) async {
    try {
      await widget.apiService.bookTicket(
        bus['busID'],
        1, // Assuming userID = 1 for this example
        'Regular', // Ticket type
        '2024-12-10', // Travel date
        1, // Number of passengers
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ticket booked for ${bus["busName"]}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to book ticket: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Buses'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text Fields for "From" and "To"
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fromController,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _toController,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Search Button
            ElevatedButton(
              onPressed: searchBuses,
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            // Bus List or Shimmer Loader
            Expanded(
              child: buses.isEmpty
                  ? _buildShimmerLoader()
                  : _buildBusList(),
            ),
          ],
        ),
      ),
    );
  }


  // Widget to display list of buses
  Widget _buildBusList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: buses.length,
      itemBuilder: (context, index) {
        final bus = buses[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(bus["busName"]),
            subtitle: Text(
                '${bus["departureLocation"]} -> ${bus["arrivalLocation"]}'),
            trailing: ElevatedButton(
              onPressed: () => bookTicket(bus),
              child: const Text('Book'),
            ),
          ),
        );
      },
    );
  }

  // Shimmer loading widget
  Widget _buildShimmerLoader() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }
}