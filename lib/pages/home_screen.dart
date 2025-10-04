import 'package:flutter/material.dart';
import 'package:space_tour/widgets/category_card.dart';
import 'package:space_tour/widgets/featuring_tour_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> categories = [
    {"categoryName": "Education", "icon": Icons.school_rounded},
    {"categoryName": "Live Now", "icon": Icons.live_tv_rounded},
    {"categoryName": "Upcoming", "icon": Icons.newspaper_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        SearchBar(
          leading: Icon(Icons.search_rounded, size: 25),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          hintText: "Search",
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
        SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return CategoryCard(
                categoryName: category['categoryName'],
                icon: category['icon'],
              );
            },
          ),
        ),
      ],
    );
  }
}
