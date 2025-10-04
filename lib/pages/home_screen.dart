import 'package:flutter/material.dart';
import 'package:space_tour/widgets/featuring_tour_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        SearchBar(
          // side: WidgetStatePropertyAll(
          //   BorderSide(color: Colors.white, width: 2),
          // ),
          leading: Icon(Icons.search_rounded, size: 25),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          hintText: "Search for a tour",
          hintStyle: WidgetStatePropertyAll(TextStyle(color: Colors.black)),
        ),
        SizedBox(height: 10),
        Text(
          "Featuring this week",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
        FeaturingTourCard(
          photoUrl:
              "https://upload.wikimedia.org/wikipedia/commons/7/7c/United_States_at_night.jpg",
          tourName: "Tour of the United States – From Coast to Coast",
          description:
              "🌎 Experience the USA from 400 km above Earth — live, in breathtaking 360°.",
          cost: 19.99,
        ),
        SizedBox(height: 10),
        Text(
          "Categories",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
