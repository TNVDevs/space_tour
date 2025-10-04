import 'package:flutter/material.dart';

class ToursScreen extends StatefulWidget {
  const ToursScreen({super.key});

  @override
  State<ToursScreen> createState() => _ToursScreenState();
}

class _ToursScreenState extends State<ToursScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Text("Your flights", style: TextStyle(color: Colors.white))],
    );
  }
}
