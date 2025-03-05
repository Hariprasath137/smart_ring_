import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key});

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
          icon: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: Text(
          "Activity Score",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your activity score is higher than the average score of your age group",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "75 points lower",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 250,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceEvenly,
                          maxY: 100,
                          barGroups: [
                            _buildBarGroup(0, "Me", 10, Colors.blue),
                            _buildBarGroup(1, "My Age Group", 75, Colors.grey),
                            _buildBarGroup(
                              2,
                              "Everyone",
                              70,
                              Colors.grey[700]!,
                            ),
                          ],
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (
                                  double value,
                                  TitleMeta meta,
                                ) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return const Text(
                                        "Me",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      );
                                    case 1:
                                      return const Text(
                                        "My age group",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      );
                                    case 2:
                                      return const Text(
                                        "Everyone",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      );
                                    default:
                                      return const Text("");
                                  }
                                },
                                reservedSize: 30,
                              ),
                            ),
                          ),
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipItem: (
                                group,
                                groupIndex,
                                rod,
                                rodIndex,
                              ) {
                                return BarTooltipItem(
                                  "${rod.toY.toInt()}",
                                  const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            touchCallback: (event, response) {},
                            handleBuiltInTouches: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What is the activity score?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 30),
                    const Text(
                      "Activity score ranges from 1-100 and is a comprehensive indicator of your activity level today.",
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      "The scores will vary for different age groups.",
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      "85-100 points: Excellent",
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      "75-84 points: Good",
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      "60-74 points: Moderate exercise",
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      "0-59 points: Less Excercise",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(
    int x,
    String label,
    double value,
    Color color,
  ) {
    return BarChartGroupData(
      x: x,
      barsSpace: 0,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 100,
          borderRadius: BorderRadius.zero,
          rodStackItems: [
            BarChartRodStackItem(
              0,
              value,
              color.withOpacity(0.8),
              BorderSide.none,
            ),
          ],
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: value,
            color: Colors.transparent,
          ),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }
}
