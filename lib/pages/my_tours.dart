import 'package:flutter/material.dart';

class MyToursScreen extends StatefulWidget {
  const MyToursScreen({super.key});

  @override
  State<MyToursScreen> createState() => _MyToursScreenState();
}

class _MyToursScreenState extends State<MyToursScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "For you | Based on your favorites",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
