import 'package:flutter/material.dart';
import 'package:trainbookingticket2/screens/search_ticket.dart';


class FindTicketScreen extends StatefulWidget {
  const FindTicketScreen({super.key});

  @override
  _FindTicketScreenState createState() => _FindTicketScreenState();
}

class _FindTicketScreenState extends State<FindTicketScreen> {
  bool isRoundTrip = false;
  DateTime departureDate = DateTime.now();
  DateTime returnDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
        children: [
        CircleAvatar(
        backgroundImage: AssetImage('assets/avatar.png'), // Replace with actual avatar
    ),
    SizedBox(width: 10),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('Hi, Jonathan', style: TextStyle(color: Colors.white)),
    Text('Let\'s take a vacation', style: TextStyle(color: Colors.grey, fontSize: 13)),
    ],
    ),
    ],
    ),
    actions: [
    IconButton(
    icon: const Icon(Icons.notifications_none, color: Colors.white),
    onPressed: () {},
    ),
    ],
    ),
    extendBodyBehindAppBar: true,
    body: SingleChildScrollView(
    child: Column(
    children: [
    // Top Background Section
    Stack(
    children: [
    Container(
    height: 200,
    decoration: const BoxDecoration(
    color: Colors.teal, // Use background image/color here
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
    child: Card(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
    ),
    child: const Padding(
    padding: EdgeInsets.all(16.0),
    child: Row(
    children: [
    Icon(Icons.health_and_safety, color: Colors.teal),
    SizedBox(width: 10),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('COVID-19 Guarantee', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Health protocol guarantee during pandemic for our member', style: TextStyle(color: Colors.grey)),
    ],
    ),
    ),
    Icon(Icons.arrow_forward, color: Colors.teal),
    ],
    ),
    ),
    ),
    ),
    ],
    ),
    const SizedBox(height: 20),
    // Travel Information Card
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Card(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    children: [
    // Toggle between One Way and Round-trip
    Row(
    children: [
    ChoiceChip(
    label: const Text('One Way'),
    selected: !isRoundTrip,
    onSelected: (bool selected) {
    setState(() {
    isRoundTrip = !selected;
    });
    },
    ),
    const SizedBox(width: 10),
    ChoiceChip(
    label: const Text('Round-trip'),
    selected: isRoundTrip,
    onSelected: (bool selected) {
    setState(() {
    isRoundTrip = selected;
    });
    },
    ),
    ],
    ),
    const SizedBox(height: 16),
    // From and To Stations
    const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('From', style: TextStyle(color: Colors.grey)),
    Text('New York City', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('NYC', style: TextStyle(color: Colors.grey)),
    ],
    ),
    Icon(Icons.swap_horiz, color: Colors.teal),
    Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    Text('To', style: TextStyle(color: Colors.grey)),
    Text('Pennsylvania', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('PNV', style: TextStyle(color: Colors.grey)),
    ],
    ),
    ],
    ),
    const SizedBox(height: 16),
    // Departure Date
    Row(
    children: [
    const Text('Date', style: TextStyle(color: Colors.grey)),
    const Spacer(),
    TextButton(
    onPressed: () async {
    final pickedDate = await _selectDate(context, departureDate);
    if (pickedDate != null && pickedDate != departureDate) {
    setState(() {
    departureDate = pickedDate;
    });
    }
    },
    child: Text(
    '${departureDate.day}, ${_monthToString(departureDate.month)} ${departureDate.year}',
    style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    ],
    ),
    const SizedBox(height: 8),
    // Return Date (if Round-trip is selected)
    if (isRoundTrip)
    Row(
    children: [
    const Text('Return?', style: TextStyle(color: Colors.grey)),
    const Spacer(),
    TextButton(
    onPressed: () async {
    final pickedDate = await _selectDate(context, returnDate);
    if (pickedDate != null && pickedDate != returnDate) {
    setState(() {
    returnDate = pickedDate;
    });
    }
    },
    child: Text(
    '${returnDate.day}, ${_monthToString(returnDate.month)} ${returnDate.year}',
    style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    ],
    ),
    const SizedBox(height: 16),
    // Search Ticket Button
    ElevatedButton(
    onPressed: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SearchTicketScreen()),
    );},
    style: ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 48),
    backgroundColor: Colors.teal,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ), // Set your desired button color
    ),
    child: const Text('Search Ticket' , style: TextStyle(color: Colors.white)),
    ),
    ],
    ),
    ),
    ),
    ),
    const SizedBox(height: 16),
    ],
    ),
    ),
    );
  }
}
// Helper method for date picker
Future<DateTime?> _selectDate(BuildContext context, DateTime initialDate) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
}

// Helper method to convert month to string
String _monthToString(int month) {
  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'
  ];
  return months[month - 1];
}
