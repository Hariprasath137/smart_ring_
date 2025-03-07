import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataDetails extends StatefulWidget {
  const DataDetails({super.key});

  @override
  State<DataDetails> createState() => _DataDetailsState();
}

class _DataDetailsState extends State<DataDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text(
          "Data Details",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            DateFormat("yyyy-MM-dd").format(DateTime.now()),
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 180),

          /// Image without extra space
          Flexible(
            fit: FlexFit.loose,
            child: Image.asset('assets/datadetails.png', fit: BoxFit.contain),
          ),

          /// No extra space between image and text
          Text(
            "No Data Yet",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
