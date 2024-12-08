import 'package:flutter/material.dart';

class BookingForm extends StatelessWidget {
  final String title;
  final int price;

  const BookingForm({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Book $title'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Price: \$${price.toString()}"),
          const TextField(
            decoration: InputDecoration(labelText: 'Enter Duration'),
          ),
          const TextField(
            decoration: InputDecoration(labelText: 'Additional Requests'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Handle booking logic
          },
          child: const Text('Confirm Booking'),
        ),
      ],
    );
  }
}