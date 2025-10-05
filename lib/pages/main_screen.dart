import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:space_tour/pages/home_screen.dart';
import 'package:space_tour/pages/tours_screen.dart';
import 'package:space_tour/pages/vr_player.dart';

import 'my_tours.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            HomeScreen(),
            ToursScreen(),
            MyToursScreen(),
            VRPlayerScreen(videoId: "Kgb5efL2dng"),
          ],
        ),
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.black,
        onButtonPressed: (index) {
          setState(() {
            selectedIndex = index;
          });
          controller.animateToPage(
            selectedIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutQuad,
          );
        },
        iconSize: 30,
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(icon: Icons.dashboard_rounded, title: 'Explore'),
          BarItem(icon: Icons.rocket_launch_rounded, title: 'Tours'),
          BarItem(icon: Icons.favorite_rounded, title: 'My Tours'),
          BarItem(icon: Icons.camera_alt_rounded, title: 'VR Player'),
        ],
      ),
    );
  }
}
