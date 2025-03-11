// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> cards = [
    {
      'title': 'Ring Status',
      'content': 'You have not bound the ring yet',
      'buttonText': 'Bind immediately',
      'icon': Icons.bluetooth_searching,
      'route': '/bind_ble',
      'isStable': true,
    },
    {
      'title': 'Activity',
      'subtitle': 'Please wear a smart ring to know your activities',
      'icon': Icons.directions_walk,
      'route': '/activity_screen',
      'image': 'assets/activity.jpeg',
    },
    {
      'title': 'Heart Rate',
      'subtitle': 'Please wear a smart ring to know your heart rate',
      'icon': Icons.favorite,
      'route': '/heart_rate_screen',
      'image': 'assets/heartrate.jpg',
    },
    {
      'title': 'Sleep',
      'subtitle': 'Please wear a smart ring to know your sleep status',
      'icon': Icons.bedtime,
      'route': '/sleep_screen',
      'image': 'assets/sleep.jpg',
    },
    {
      'title': 'Sport Record',
      'subtitle': 'Please wear a smart ring to know your exercise status',
      'icon': Icons.directions_run,
      'route': '/sport_screen',
      'image': 'assets/sport.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Health",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            _scaffoldkey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.ring_volume),
            color: Colors.white,
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black, // Set background color to black
        child: Column(
          children: [
            SizedBox(height: 40), // Small padding at the top
            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text('Profile', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.golf_course_sharp, color: Colors.white),
              title: Text(
                'Goal Setting',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/goal_settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.white),
              title: Text("About", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, cards[index]['route']);
              },
              child: Card(
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child:
                    cards[index]['title'] == 'Ring Status'
                        ? Container(
                          color: Colors.grey[800],
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cards[index]['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                cards[index]['content'],
                                style: TextStyle(color: Colors.white70),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    cards[index]['route'],
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text(
                                  cards[index]['buttonText'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                        : Stack(
                          children: [
                            Image.asset(
                              cards[index]['image'],
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cards[index]['title'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            cards[index]['icon'],
                                            size: 40,
                                            color: Colors.white70,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            cards[index]['subtitle'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
              ),
            );
          },
        ),
      ),
    );
  }
}
