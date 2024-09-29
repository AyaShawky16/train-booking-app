import 'package:flutter/material.dart';


class SearchTicketScreen extends StatefulWidget {
  const SearchTicketScreen({super.key});

  @override
  _SearchTicketScreenState createState() => _SearchTicketScreenState();
}

class _SearchTicketScreenState extends State<SearchTicketScreen> {
  DateTime selectedDate = DateTime.now();
  String departureCity = '';
  String arrivalCity = '';
  bool isOneWay = true; // Allow switching between One Way and Round Trip
  String selectedClass = 'Business';
  int adults = 2;
  int children = 0;

  List<Trip> trips = [
    Trip(name: 'Pensitanian Train', departure: 'NYC', arrival: 'PNV', price: 30.35),
    Trip(name: 'Lesidian Express', departure: 'NYC', arrival: 'PNV', price: 29.40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Search Ticket'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Empty Menu'),
                    content: const Text('This is an empty menu for now.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Departure and Arrival input fields
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => setState(() => departureCity = value),
                      decoration: const InputDecoration(
                        labelText: 'Departure City',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                        hintText: 'NYC',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      onChanged: (value) => setState(() => arrivalCity = value),
                      decoration: const InputDecoration(
                        labelText: 'Arrival City',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                        hintText: 'PNV',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Trip options: One way, Class, Number of passengers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isOneWay = !isOneWay),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                          color: isOneWay ? Colors.teal : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            isOneWay ? 'One Way' : 'Round Trip',
                            style: TextStyle(
                              color: isOneWay ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedClass,
                      items: const [
                        DropdownMenuItem(value: 'Business', child: Text('Business')),
                        DropdownMenuItem(value: 'Economy', child: Text('Economy')),
                      ],
                      onChanged: (value) => setState(() => selectedClass = value!),
                      decoration: const InputDecoration(
                        labelText: 'Class',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Add logic to handle passengers selection
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text('Adults: $adults'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Date selection buttons (Updated to full month scrollable)
              _buildDateScroller(),
              const SizedBox(height: 16.0),

              // List of available trips
              ...trips.map((trip) => _buildTripCard(trip)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  // Date scroller function
  Widget _buildDateScroller() {
    return SizedBox(
      height: 60.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30, // Number of days in the month
        itemBuilder: (context, index) {
          DateTime day = DateTime(selectedDate.year, selectedDate.month, index + 1);
          bool isSelected = selectedDate.day == day.day;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = day;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    _getDayName(day),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to get the day name
  String _getDayName(DateTime day) {
    List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[day.weekday - 1];
  }

  // Custom card design
  Widget _buildTripCard(Trip trip) {
    return ClipPath(
      clipper: CardClipper(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.train),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    trip.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Departure: ${trip.departure}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${trip.price}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Arrival: ${trip.arrival}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.access_time),
                const Text('1h 15m'),
              ],
            ),
            const SizedBox(height: 8.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('08:30 AM', style: TextStyle(fontSize: 14.0)),
                Icon(Icons.calendar_today),
                Text('24 Feb 2023', style: TextStyle(fontSize: 14.0)),
                SizedBox(width: 8.0),
                Icon(Icons.calendar_today),
                Text('10:00 AM', style: TextStyle(fontSize: 14.0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom clipper for the card design
class CardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width - 30, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 30.0);
    path.quadraticBezierTo(size.width, 0.0, size.width - 30, 0.0);
    path.lineTo(0.0, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// Model class for the trip
class Trip {
  final String name;
  final String departure;
  final String arrival;
  final double price;

  Trip({
    required this.name,
    required this.departure,
    required this.arrival,
    required this.price,
  });
}


