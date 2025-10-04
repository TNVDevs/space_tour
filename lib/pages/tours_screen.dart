import 'package:flutter/material.dart';
import 'package:space_tour/widgets/tour_card.dart';

class ToursScreen extends StatefulWidget {
  const ToursScreen({super.key});

  @override
  State<ToursScreen> createState() => _ToursScreenState();
}

class _ToursScreenState extends State<ToursScreen> {
  List<Map<String, dynamic>> americaTours = [
    {"tourName": "Tour of the United States – From Coast to Coast 🇺🇸"},
    {"tourName": "Tour of the Canada - The most northern Coast 🇨🇦"},
    {"tourName": "Tour of the Mexico - Tortilla State 🇲🇽"},
  ];

  List<Map<String, dynamic>> euroTours = [
    {"tourName": "Tour of Europe — Continental Journey 🇪🇺"},
    {"tourName": "Northern Lights Expedition — Scandinavia 🇸🇪"},
    {"tourName": "Mediterranean Coastline Adventure 🏖️"},
  ];

  List<Map<String, dynamic>> asiaTours = [
    {"tourName": "Eastern Asia Expedition — From Tokyo to Seoul 🇯🇵➡️🇰🇷"},
    {"tourName": "Himalayan Majesty — Nepal & Tibet 🇳🇵"},
    {
      "tourName":
          "South Asia Discovery — From India to the Maldives 🇮🇳➡️🇲🇻",
    },
  ];

  List<Map<String, dynamic>> discountTours = [
    {"tourName": "Tour of Europe – Continental Journey (25% OFF) 🏷"},
    {"tourName": "Eastern Asia Expedition – From Tokyo to Seoul (25% OFF) 🏷"},
    {
      "tourName":
          "South Asia Discovery – From India to the Maldives (25% OFF) 🏷",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Text(
            "North America & Coasts",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: americaTours.length,
            itemBuilder: (context, index) {
              final tour = americaTours[index];

              return TourCard(tourName: tour["tourName"]);
            },
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Euro Tour",
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
            itemCount: euroTours.length,
            itemBuilder: (context, index) {
              final tour = euroTours[index];

              return TourCard(tourName: tour["tourName"]);
            },
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            "Asian mystery",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: asiaTours.length,
            itemBuilder: (context, index) {
              final tour = asiaTours[index];

              return TourCard(tourName: tour["tourName"]);
            },
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Discounts 25%",
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
            itemCount: discountTours.length,
            itemBuilder: (context, index) {
              final tour = discountTours[index];

              return TourCard(tourName: tour["tourName"]);
            },
          ),
        ),
      ],
    );
  }
}
