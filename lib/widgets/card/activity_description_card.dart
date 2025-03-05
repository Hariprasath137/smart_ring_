import 'package:flutter/material.dart';

class ActivityDescription extends StatelessWidget {
  const ActivityDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: Text(
          "Activity Description",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total steps",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Text(
                  "Daily steps are an indicator of your daily physical activity.the optimal daily steps depend on your age,body type physical fitness level,and readliness to perform.You should ensure that you can reach a standard of more than 8,000 steps per day.If you exercise,you can reduce the number of steps appropriately.The more steps you take,the better.Too many steps may cause potential knee and ankle strain,so it is recommended that the number of steps should be controlled between 8,000 and 15,000",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),

                SizedBox(height: 30),
                Text(
                  "Total calories",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Text(
                  "Total calories is your total daily energy expenditure,including all the calories you burn during the day,whether active or resting,tracking your total calories and comparing it with your data history can help you adjust your calorie intake and maintain a healthy weight.",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Text(
                  "Although exercise will increase your daily calorie consumption,most of your total consumption comes from the calories consumed at rest,also known as your basal metabolic rate(BMR) The device will start calculating your total burn in the early morning to record your estimated BMR.The calculation continues until the end of the day,and all the calories you consume during daily activities are added to the total.",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
