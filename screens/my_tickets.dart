import 'package:flutter/material.dart';


class Ticket {
  final String destination;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;

  const Ticket({
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
  });
}

class MyTicketApp extends StatelessWidget {
  final List<Ticket> tickets = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyTicketScreen(tickets: tickets),
    );
  }
}

class MyTicketScreen extends StatefulWidget {
  final List<Ticket> tickets;

  const MyTicketScreen({super.key, required this.tickets});

  @override
  State<MyTicketScreen> createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'All trips';

  List<Ticket> get filteredTickets {
    return widget.tickets.where((ticket) {
      final searchTerm = _searchController.text.toLowerCase();
      return ticket.destination.toLowerCase().contains(searchTerm) &&
          (selectedFilter == 'All trips' || ticket.destination == selectedFilter);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket App'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(hintText: 'search for tickets'),
            onChanged: (value) {
              setState(() {});
            },
          ),
          //  (DropdownButton)
          Expanded(
            child: ListView.builder(
              itemCount: filteredTickets.length,
              itemBuilder: (context, index) {
                final ticket = filteredTickets[index];
                return ListTile(
                  title: Text(ticket.destination),
                  subtitle: Text('${ticket.departureTime} - ${ticket.arrivalTime}'),
                  trailing: Text('${ticket.price} EGP'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}