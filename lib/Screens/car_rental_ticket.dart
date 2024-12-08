
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
import '../api_service.dart';
import 'package:shimmer/shimmer.dart';  // Ensure shimmer is installed

class CarRentalScreen extends StatefulWidget {
  final ApiService apiService;

  const CarRentalScreen({Key? key, required this.apiService}) : super(key: key);

  @override
  _CarRentalScreenState createState() => _CarRentalScreenState();
}

class _CarRentalScreenState extends State<CarRentalScreen> {
  List<Car> _filteredCars = [];
  List<Car> _allCars = [];
  String _searchQuery = '';
  String _selectedCarName = "All";
  double _selectedPrice = 500.0;
  List<dynamic> _bookings = [];
  DateTime? startDate;
  DateTime? endDate;
  Map<int, double> carPrices = {}; // Track price per car

  @override
  void initState() {
    super.initState();
    _fetchCars();
    _fetchBookings();
  }
  Future<DateTime?> _selectDate(BuildContext context, DateTime? initialDate) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  void _calculatePrice(Car car) {
    if (startDate != null && endDate != null) {
      final difference = endDate!.difference(startDate!).inDays;
      if (difference > 0) {
        setState(() {
          carPrices[car.id] = car.price * difference.toDouble(); // Store price per car
        });
      }
    }
  }
  void _fetchCars() async {
    try {
      final cars = await widget.apiService.fetchCars();
      setState(() {
        _allCars = cars;
        _filteredCars = _allCars;
      });
    } catch (error) {
      print('Error while fetching cars: $error');
    }
  }
  void _applyFilters() {
    // Filter by price
    List<Car> filteredCars = _allCars.where((car) => car.price <= _selectedPrice).toList();

    setState(() {
      _filteredCars = filteredCars;
    });
  }
  void _fetchBookings() async {
    final bookings = await widget.apiService.fetchCarBookings();
    setState(() {
      _bookings = bookings;
    });
  }

  void _searchCars(String query) {
    final results = _allCars.where((car) {
      final name = car.name.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredCars = results;
      _searchQuery = query;
    });
  }

  // void _bookCar(BuildContext context, Car car) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         elevation: 16,
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(
  //                 'Book ${car.name}',
  //                 style: TextStyle(
  //                   fontSize: 22,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.deepPurple,
  //                 ),
  //               ),
  //               const SizedBox(height: 16),
  //               Image.asset(car.imageLink), // Car Image
  //               const SizedBox(height: 8),
  //               Text(
  //                 'Price: \$${car.price} per day',
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   color: Colors.black54,
  //                 ),
  //               ),
  //               const SizedBox(height: 16),
  //               ElevatedButton(
  //                 onPressed: () async {
  //                   final selectedDate = await _selectDate(context, startDate);
  //                   if (selectedDate != null) {
  //                     setState(() {
  //                       startDate = selectedDate;
  //                       _calculatePrice(car);  // Recalculate price
  //                     });
  //                   }
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.deepPurple,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //                 child: Text(
  //                   startDate != null
  //                       ? 'Start Date: ${DateFormat.yMMMd().format(startDate!)}'
  //                       : 'Select Start Date',
  //                 ),
  //               ),
  //               const SizedBox(height: 8),
  //               ElevatedButton(
  //                 onPressed: () async {
  //                   final selectedDate = await _selectDate(context, endDate);
  //                   if (selectedDate != null) {
  //                     setState(() {
  //                       endDate = selectedDate;
  //                       _calculatePrice(car);  // Recalculate price
  //                     });
  //                   }
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.deepPurple,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //                 child: Text(
  //                   endDate != null
  //                       ? 'End Date: ${DateFormat.yMMMd().format(endDate!)}'
  //                       : 'Select End Date',
  //                 ),
  //               ),
  //               const SizedBox(height: 16),
  //               if (carPrices[car.id] != null)
  //                 Text(
  //                   'Total Price: \$${carPrices[car.id]?.toStringAsFixed(2)}',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.deepPurple,
  //                   ),
  //                 ),
  //               const SizedBox(height: 16),
  //               ElevatedButton(
  //                 onPressed: startDate != null && endDate != null && carPrices[car.id] != null
  //                     ? () async {
  //                   final userID = 1; // Replace with actual user ID
  //                   await widget.apiService.bookCar(userID, car.id, startDate!, endDate!);
  //
  //                   setState(() {
  //                     _bookings.add({
  //                       'car': car,
  //                       'startDate': startDate.toString(),
  //                       'endDate': endDate.toString(),
  //                     });
  //                   });
  //
  //                   Navigator.pop(context);
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(content: Text('Booking successful!')),
  //                   );
  //                 }
  //                     : null,
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.green,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //                 child: const Text('Book Now'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  void _bookCar(BuildContext context, Car car) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(
              builder: (context, setDialogState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Book ${car.name}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Image.asset(car.imageLink, height: 120), // Car image
                    const SizedBox(height: 8),
                    Text(
                      'Price: \$${car.price} per day',
                      style: const TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    const SizedBox(height: 16),

                    // Start Date Picker
                    ElevatedButton(
                      onPressed: () async {
                        final selectedDate = await _selectDate(context, startDate);
                        if (selectedDate != null) {
                          setDialogState(() {
                            startDate = selectedDate;
                            _calculatePrice(car); // Update price
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        style: TextStyle(
                      color:Colors.white,
                      ),

                        startDate != null
                            ? 'Start Date: ${DateFormat.yMMMd().format(startDate!)}'
                            : 'Select Start Date',

                      ),
                    ),
                    const SizedBox(height: 8),

                    // End Date Picker
                    ElevatedButton(
                      onPressed: () async {
                        final selectedDate = await _selectDate(context, endDate);
                        if (selectedDate != null) {
                          setDialogState(() {
                            endDate = selectedDate;
                            _calculatePrice(car); // Update price
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        style: TextStyle(
                          color:Colors.white,
                        ),
                        endDate != null
                            ? 'End Date: ${DateFormat.yMMMd().format(endDate!)}'
                            : 'Select End Date',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Total Price
                    if (carPrices[car.id] != null)
                      Text(
                        'Total Price: \$${carPrices[car.id]?.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    const SizedBox(height: 16),

                    // Book Now Button
                    ElevatedButton(
                      onPressed: startDate != null &&
                          endDate != null &&
                          carPrices[car.id] != null
                          ? () async {
                        try {
                          final userID = 1; // Replace with actual user ID
                          await widget.apiService.bookCar(
                            userID,
                            car.id,
                            startDate!,
                            endDate!,
                          );

                          setState(() {
                            _bookings.add({
                              'car': car,
                              'startDate': startDate.toString(),
                              'endDate': endDate.toString(),
                            });
                          });

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Booking for ${car.name} successful!'),
                            ),
                          );
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to book car: ${error.toString()}'),
                            ),
                          );
                        }
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Book Now'),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Rentals'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 8,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: _searchCars,
                decoration: InputDecoration(
                  hintText: 'Search cars...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                value: _selectedCarName,
                onChanged: (value) {
                  setState(() {
                    _selectedCarName = value!;
                    _applyFilters();
                  });
                },
                items: ['All', 'Sedan', 'SUV', 'Truck']
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                isExpanded: true,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<double>(
                value: _selectedPrice,
                onChanged: (value) {
                  setState(() {
                    _selectedPrice = value!;
                    _applyFilters();
                  });
                },
                items: [500.0, 1000.0, 1500.0, 2000.0]
                    .map((price) => DropdownMenuItem(
                  value: price,
                  child: Text('\$${price.toString()}'),
                ))
                    .toList(),
                isExpanded: true,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: _filteredCars.length,
                itemBuilder: (context, index) {
                  final car = _filteredCars[index];
                  return GestureDetector(
                    onTap: () => _bookCar(context, car),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(car.imageLink),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              car.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$${car.price} / day',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
