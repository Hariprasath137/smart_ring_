// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class SportRecordScreen extends StatefulWidget {
  const SportRecordScreen({super.key});

  @override
  _SportRecordScreenState createState() => _SportRecordScreenState();
}

class _SportRecordScreenState extends State<SportRecordScreen> {
  int _selectedIndex = 0; // Tracks selected option

  final List<String> _options = ["Day", "Week", "Month"];

  DateTime _selectedDate = DateTime(2025, 3, 9);

  @override
  void initState() {
    super.initState();
    _startClock();
  }

  void _startClock() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Sport Record", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[900], // Background color
                  borderRadius: BorderRadius.circular(50), // Oval shape
                ),
                padding: EdgeInsets.all(4), // Reduce padding to align properly
                child: ToggleButtons(
                  constraints: BoxConstraints.tightFor(
                    width: 130,
                    height: 60,
                  ), // Fixed size
                  borderRadius: BorderRadius.circular(
                    50,
                  ), // Match parent radius
                  // clipBehavior: Clip.hardEdge, // Ensures proper shape clipping
                  isSelected: List.generate(
                    3,
                    (index) => index == _selectedIndex,
                  ),
                  fillColor: Colors.lightBlue, // Active background color
                  selectedColor: Colors.white, // Active text color
                  color: Colors.grey.shade300, // Inactive text color
                  borderWidth: 0, // No border
                  onPressed: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children:
                      _options
                          .map(
                            (text) => Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ), // Balanced padding
                              child: Text(text, style: TextStyle(fontSize: 16)),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left, color: Colors.white),
                  onPressed: () => _changeDate(-1),
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(_selectedDate),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right, color: Colors.white),
                  onPressed: () => _changeDate(1),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "00:00:00",
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "0",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 100),
                    Text(
                      "0",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      "times",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 70),
                    Text(
                      "Kcal",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Text(
                  "Recent activities",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: Image.asset("assets/run.gif", width: 100, height: 100),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "No Data Yet",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class TimeNavigationBar extends StatefulWidget {
//   const TimeNavigationBar({super.key});

//   @override
//   _TimeNavigationBarState createState() => _TimeNavigationBarState();
// }

// class _TimeNavigationBarState extends State<TimeNavigationBar> {
//   int _selectedIndex = 0; // Tracks selected option

//   final List<String> _options = ["Day", "Week", "Month"];

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.teal.shade900, // Background color
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.all(4),
//         child: ToggleButtons(
//           borderRadius: BorderRadius.circular(8),
//           isSelected: List.generate(3, (index) => index == _selectedIndex),
//           fillColor: Colors.teal, // Active background color
//           selectedColor: Colors.white, // Active text color
//           color: Colors.grey.shade300, // Inactive text color
//           borderWidth: 0, // No border
//           onPressed: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           children:
//               _options
//                   .map(
//                     (text) => Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 10,
//                       ),
//                       child: Text(text, style: TextStyle(fontSize: 16)),
//                     ),
//                   )
//                   .toList(),
//         ),
//       ),
//     );
//   }
// }
