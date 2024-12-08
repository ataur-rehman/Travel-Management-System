import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = "http://192.168.69.66:7000";
class ApiService {
  static const String baseUrl = "http://192.168.69.66:7000";

  /// Forget Password - Request Reset
  ///
  static Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forget_password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return {'success': true, 'message': responseBody['message']};
      } else {
        return {'success': false, 'message': 'Password reset request failed'};
      }
    } catch (error) {
      return {
        'success': false,
        'message': 'Failed to send reset request. Please try again.'
      };
    }
  }

  /// Forget Password - Update Password
  static Future<Map<String, dynamic>> updatePassword(String email,
      String newPassword, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword,
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Password updated successfully'};
      } else {
        return {'success': false, 'message': 'Failed to update password'};
      }
    } catch (error) {
      return {
        'success': false,
        'message': 'Error updating password. Please try again.'
      };
    }
  }

  /// Login API
  static Future<Map<String, dynamic>> login(String email,
      String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      // Log the response status and body for debugging
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Login successful
        final responseBody = jsonDecode(response.body);
        return {'success': true, 'message': responseBody['message']};
      } else {
        // Error in login
        return {'success': false, 'message': 'Login failed'};
      }
    } catch (error) {
      print('Error: $error');
      return {
        'success': false,
        'message': 'Failed to log in. Please try again.'
      };
    }
  }


  // Fetch Movies
  Future<List> fetchMovies() async {
    final url = Uri.parse('$baseUrl/movies');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching movies: $error');
    }
  }

  // Fetch Airline Tickets
  Future<List> fetchFlights() async {
    final url = Uri.parse('$baseUrl/airline_tickets');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to load airline tickets: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching airline tickets: $error');
    }
  }

  //

  // Fetch Bus Tickets
  Future<List> fetchBuses() async {
    final url = Uri.parse('$baseUrl/bus_tickets');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load bus tickets: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching bus tickets: $error');
    }
  }

  // Fetch Event Tickets
  Future<List> fetchEvents() async {
    final url = Uri.parse('$baseUrl/event_tickets');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load event tickets: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching event tickets: $error');
    }
  }

// Example ApiService method for sign-up
  static Future<Map<String, dynamic>> signUp(String userName, String email,
      String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.69.66:7000/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userName': userName,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': json.decode(response.body)['error']
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred. Please try again.'
      };
    }
  }


  // Fetch Tour Tickets
  Future<List> fetchTours() async {
    final url = Uri.parse('$baseUrl/tour_tickets');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load tour tickets: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching tour tickets: $error');
    }
  }

  /////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
  // Fetches list of cars from the API
  Future<List<Car>> fetchCars() async {
    const baseUrl = "http://192.168.69.66:7000";
    final response = await http.get(Uri.parse('$baseUrl/cars'));


    // Log the response status and body for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        // If the response is successful, try to decode the JSON
        List<dynamic> carListJson = json.decode(response.body);
        return carListJson.map((json) => Car.fromJson(json)).toList();
      } catch (e) {
        print('Error while parsing JSON: $e');
        throw Exception('Failed to parse cars data');
      }
    } else {
      print('Error: Failed to load cars. Status code: ${response.statusCode}');
      throw Exception('Failed to load cars');
    }
  }


  // Fetches car bookings from the API
  Future<List<Map<String, dynamic>>> fetchCarBookings() async {
    final response = await http.get(Uri.parse('$baseUrl/car_bookings'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the bookings
      List<dynamic> bookingsJson = json.decode(response.body);
      return List<Map<String, dynamic>>.from(bookingsJson);
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  // Assuming you are using this method to book a car
  Future<void> bookCar(int userID, int carID, DateTime startDate,
      DateTime endDate) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.69.66:7000/book_car'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userID': userID,
          'carID': carID,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        print('Car booked successfully');
      } else {
        print('Failed to book car: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  // Cancel a booking
  Future<bool> cancelBooking(int bookingID) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cancel_booking/$bookingID'),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to cancel booking');
      }
    } catch (e) {
      throw Exception('Error canceling booking: $e');
    }
  }


////////////////////////////////////////////////////////////////

  // Search buses by departure and arrival
  Future<List<dynamic>> searchBuses(String departure, String arrival) async {
    final response = await http.get(
      Uri.parse('$baseUrl/searchBuses?departure=$departure&arrival=$arrival'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to search buses');
    }
  }

  // Book a ticket
  Future<void> bookTicket(int busID, int userID, String ticketType,
      String travelDate, int no_Passengers) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookTicket'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'busID': busID,
        'userID': userID,
        'ticketType': ticketType,
        'travelDate': travelDate,
        'no_Passengers': no_Passengers,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to book ticket');
    }
  }
}

  class Car {
  final int id;
  final String name; // Map 'title' from database to 'name'
  final String imageLink; // Map 'link' from database to 'imageLink'
  final int price;
  final bool isAvailable;

  Car({
  required this.id,
  required this.name,
  required this.imageLink, // Store the relative asset path
  required this.price,
  required this.isAvailable,
  });

  // Factory constructor to create a Car object from JSON
  factory Car.fromJson(Map<String, dynamic> json) {
  String imageUrl = json['image_link'] ??
  'default_image_url'; // Get link or fallback

  // If it's a local asset, adjust the path
  if (imageUrl.startsWith('assets/')) {
  // Make sure the local asset is in the 'assets/images' folder
  imageUrl = 'assets/images/' + imageUrl
      .split('/')
      .last; // Assuming 'assets/images' folder
  }

  return Car(
  id: json['cars_id'],
  name: json['title'],
  imageLink: imageUrl,
  price: json['price'],
  isAvailable: json['available'] == 1,
  );
  }

  }

  class Booking {
  final int ticketID;
  final int userID;
  final int carID;
  final DateTime pickDate;
  final DateTime dropDate;
  final int price;

  Booking({
  required this.ticketID,
  required this.userID,
  required this.carID,
  required this.pickDate,
  required this.dropDate,
  required this.price,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
  return Booking(
  ticketID: json['ticketID'],
  userID: json['userID'],
  carID: json['carID'],
  pickDate: DateTime.parse(json['pickDate']),
  dropDate: DateTime.parse(json['dropDate']),
  price: json['price'],
  );
  }
  }

