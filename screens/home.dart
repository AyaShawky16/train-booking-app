import 'package:flutter/material.dart';

import 'find_ticket.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'), // Replace with actual image
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi, Jonathan', style: TextStyle(color: Colors.black)),
                Text(
                  'Let\'s take a vacation',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Where are you going right now?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Card for trip information
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Departure', style: TextStyle(color: Colors.grey)),
                              Text('NYC', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('New York Station', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Icon(Icons.swap_horiz, color: Colors.blue),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Arrival', style: TextStyle(color: Colors.grey)),
                              Text('VIT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('Vietnam Station', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text('Date of departure', style: TextStyle(color: Colors.grey)),
                          const Spacer(),
                          const Text('Round-trip', style: TextStyle(color: Colors.grey)),
                          Switch(
                            value: false,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text('Mon, 10 Sep 2023', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 8),
                          const Text('Total passenger: '),
                          const Text('1'),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FindTicketScreen()),
                        );},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Find Ticket' , style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // News section
              const Text(
                'Hot News',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // News card
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  NewsCard(
                    title: '2 Central American migrants found dead in Mexico after trying to board a train.',
                    time: '12h',
                    imageUrl: 'assets/images.jpg',
                  ),
                  NewsCard(
                    title: 'Train strikes: Full list of dates and lines affected as rail and Tube action announced.',
                    time: '14h',
                    imageUrl: 'assets/images (1).jpg',
                  ),
                  NewsCard(
                    title: 'New train strike announced in Europe causing delays and cancellations of several routes.',
                    time: '5h',
                    imageUrl: 'assets/images (2).jpg',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class NewsCard extends StatelessWidget {
  final String title;
  final String time;
  final String imageUrl;

  const NewsCard({super.key, required this.title, required this.time, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




