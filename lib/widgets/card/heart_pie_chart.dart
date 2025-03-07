import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HeartPieChart extends StatefulWidget {
  const HeartPieChart({super.key});

  @override
  State<HeartPieChart> createState() => _HeartPieChartState();
}

class _HeartPieChartState extends State<HeartPieChart> {
  final List<Map<String, dynamic>> data = [
    {"color": Colors.red, "minutes": 0, "name": "Limit"},
    {"color": Colors.blue, "minutes": 0, "name": "Anaerobic Endurance"},
    {"color": Colors.green, "minutes": 0, "name": "Aerobic Endurance"},
    {"color": Colors.orange, "minutes": 0, "name": "Fat Burning"},
    {"color": Colors.purple, "minutes": 0, "name": "Warm Up"},
  ];

  double get totalMinutes =>
      data.fold(0, (sum, item) => sum + (item["minutes"] as int));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Pie Chart (Left Side)
                        SizedBox(
                          width: 120,
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections:
                                  totalMinutes == 0
                                      ? [
                                        PieChartSectionData(
                                          color: Colors.grey[400],
                                          value: 1,
                                          radius: 20, // Increased radius
                                          showTitle: false,
                                        ),
                                      ]
                                      : data.map((item) {
                                        return PieChartSectionData(
                                          color: item["color"],
                                          value:
                                              (item["minutes"] as int)
                                                  .toDouble(),
                                          radius: 20, // Ensure visibility
                                          showTitle: false,
                                        );
                                      }).toList(),
                              sectionsSpace: 0,
                              centerSpaceRadius: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 22),
                        // Legend with aligned values
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children:
                              data.map((item) {
                                double textHeight =
                                    20; // Change this value to test
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Pointer (Same Height as Name)
                                      SizedBox(
                                        width: 8,
                                        height: 40, // Matches name height
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: item["color"],
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Name with Custom Height
                                      SizedBox(
                                        width: 140,
                                        height: 15, // Same height as pointer
                                        child: Text(
                                          item["name"],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Minutes (Fixed Alignment)
                                      SizedBox(
                                        width: 40,
                                        height:
                                            textHeight, // Same height for alignment
                                        child: Text(
                                          "${item["minutes"]} min",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Note",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.info, color: Colors.blue, size: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
