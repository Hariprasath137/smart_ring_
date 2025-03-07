import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_ring/widgets/card/heart_pie_chart.dart';
import 'package:smart_ring/widgets/slider_card/heart_rate_slider_card.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key});

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  DateTime _selectedDate = DateTime.now();
  bool _isMonitoring = false; // Toggle button state
  bool _showFullText = false; // Toggle for description text

  void _changeDay(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: _selectedDate,
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 22),
        ),
        title: const Text(
          "Heart Rate",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    _changeDay(-1);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: _pickDate,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat("yyyy-MM-dd").format(_selectedDate),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.calendar_today, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    _changeDay(1);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row: Title + Switch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Heart Rate Detection",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14, // Reduced font size
                        ),
                      ),
                      Switch(
                        value: _isMonitoring,
                        onChanged: (value) {
                          setState(() {
                            _isMonitoring = value;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Description text with expand icon at the end
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AnimatedCrossFade(
                          firstChild: const Text(
                            "Start continuous heart rate measurement, monitor it every 30 minutes...",
                            style: TextStyle(color: Colors.white70),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          secondChild: const Text(
                            "Start continuous heart rate measurement, monitor it every 30 minutes, automatically monitor heart rate, and provide you with more accurate data while considering power consumption.",
                            style: TextStyle(color: Colors.white70),
                          ),
                          crossFadeState:
                              _showFullText
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _showFullText ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            _showFullText = !_showFullText;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 4),
          const HeartRateSliderCard(),

          const SizedBox(height: 4),
          Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "--",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 4),
                      Text("Average", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "|",
                        style: TextStyle(color: Colors.white24, fontSize: 30),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "--",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 4),
                      Text("Minimum", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "|",
                        style: TextStyle(color: Colors.white24, fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "--",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 4),
                      Text("Maximum", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/data_details');
            },
            child: Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Data Details",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Real-time heart rate",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.redAccent),
                              Text("--", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          SizedBox(width: 25),
                          Text(
                            "bpm",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Colors
                                  .grey[850], // Slightly different grey for contrast
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16.0,
                            ), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                          ), // Padding for better height
                        ),
                        child: const Text(
                          "Click to Start Measurement",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            height: 120,
            child: Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Last 7 times trends",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/data_details');
                              },
                              child: Row(
                                children: [
                                  const Text(
                                    "More",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Divider(color: Colors.white24, thickness: 1),
                    const SizedBox(height: 15),
                    Center(
                      child: Text(
                        "No Data Yet",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const HeartPieChart(),
        ],
      ),
    );
  }
}
