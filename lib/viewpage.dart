import 'package:flutter/material.dart';

class Viewpage extends StatefulWidget {
  const Viewpage({super.key});

  @override
  State<Viewpage> createState() => _ViewpageState();
}

class _ViewpageState extends State<Viewpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Helo This is Heading", style: TextStyle(fontSize: 34)),
            Text("This is rhe main body"),
          ],
        ),
      ),
    );
  }
}
