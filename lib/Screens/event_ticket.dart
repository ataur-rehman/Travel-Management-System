
import 'package:flutter/material.dart';
import '../api_service.dart'; // Import ApiService for API calls
import '../widgets/booking_form.dart'; // Custom booking form widget
import 'package:shimmer/shimmer.dart';
class EventPlanningScreen extends StatelessWidget {
  final ApiService apiService; // API Service instance
  final List<dynamic> eventTickets;

  const EventPlanningScreen({
    Key? key,
    required this.apiService,
    required this.eventTickets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Event Planning',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: apiService.fetchEvents(), // Fetch events from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading spinner
          } else if (snapshot.hasError) {
            return _buildErrorScreen(snapshot.error.toString()); // Display error message
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _buildEventList(snapshot.data!);
          } else {
            return const Center(
              child: Text(
                'No events available.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildEventList(List<dynamic> events) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          elevation: 6,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: _buildEventImage(event["image"]),
            title: Text(
              event["name"] ?? "Unnamed Event",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              "${event["duration"] ?? "Duration unknown"} • \$${event["price"] ?? "0.00"}",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E2DE2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // Open booking form dialog
                showDialog(
                  context: context,
                  builder: (_) => BookingForm(
                    title: event["name"] ?? "Unnamed Event",
                    price: event["price"] ?? 0.0,
                  ),
                );
              },
              child: const Text("Book"),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventImage(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty
        ? Image.network(
      imageUrl,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.event, size: 60, color: Colors.grey);
      },
    )
        : const Icon(Icons.event, size: 60, color: Colors.grey);
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
              backgroundColor: const Color(0xFF4A00E0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              // Retry logic
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
