
import 'package:flutter/material.dart';
import '../api_service.dart';
import 'package:shimmer/shimmer.dart';
class CinemaTicketScreen extends StatelessWidget {
  final ApiService apiService;
  final List<dynamic> cinemaTickets;

  const CinemaTicketScreen({
    Key? key,
    required this.apiService,
    required this.cinemaTickets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFC466B), Color(0xFF3F5EFB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Cinema Tickets',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: apiService.fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerLoader();
          } else if (snapshot.hasError) {
            return _buildErrorScreen('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _buildMovieList(snapshot.data!);
          } else {
            return const Center(
              child: Text(
                'No movies available',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildMovieList(List<dynamic> movies) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Card(
          elevation: 6,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: movie["poster"] != null
                ? Image.network(movie["poster"], width: 60, height: 60, fit: BoxFit.cover)
                : const Icon(Icons.movie, size: 60, color: Colors.grey),
            title: Text(
              movie["title"] ?? "Unknown Title",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              movie["time"] != null ? "Showtime: ${movie["time"]}" : "Showtime: Not Available",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFC466B),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Booked ticket for ${movie["title"] ?? "this movie"}'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color(0xFF3F5EFB),
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

  Widget _buildErrorScreen(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong.',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
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
              backgroundColor: const Color(0xFF3F5EFB),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {}, // Retry action here
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
