import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Site Page",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: Text('No Data Found'),
      ),
    );
  }
}
