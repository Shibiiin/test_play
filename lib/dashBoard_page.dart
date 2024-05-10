import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:untitled/second_page.dart';
import 'package:untitled/todo.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key});

  final DateTime date = DateTime.now();
  final DateFormat dateFormat = DateFormat('dd-MMM-yyyy HH:mm'); // Date format

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text(
          'Upgrader',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text("User Name : ", style: TextStyle(color: Colors.white)),
                      const Text("Xavier John ", style: TextStyle(color: Colors.white)),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        dateFormat.format(date), // Display formatted date
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Company Name : ABC", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                   const SizedBox(height: 40,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset("assets/images/pendingLoan.png"))
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Image
          const Icon(
            Icons.abc,
            size: 90,
          ),
          const SizedBox(height: 10),
          // Text
          const Text(
            "Hello Mr.User Name",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 60),
          // Two Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Get.to(TodoList());
                },
                child: const Text(
                  "Todo Page",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Get.to(SecondPage());
                  // Add functionality for the second button
                },
                child: const Text(
                  "Site Page",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
