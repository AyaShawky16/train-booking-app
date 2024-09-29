import 'package:flutter/material.dart';
import 'package:trainbookingticket2/screens/profile.dart';
import 'explore.dart';
import 'home.dart';
import 'my_tickets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of pages for each bottom navigation item
  final List<Widget> _pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const MyTicketScreen(tickets: [],),
    const ProfileScreen(),
  ];

  // Function to handle onTap event
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped, // Call the onTap handler
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num),
            label: 'My Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
      ),
    );
  }
}
