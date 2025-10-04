import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:space_tour/pages/home_screen.dart';
import 'package:space_tour/pages/profile_screen.dart';
import 'package:space_tour/pages/tours_screen.dart';

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
            ProfileScreen(),
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
      // bottomNavigationBar: GNav(
      //   rippleColor: Colors.grey[300]!,
      //   hoverColor: Colors.grey[100]!,
      //   gap: 8,
      //   activeColor: Colors.black,
      //   iconSize: 35,
      //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //   duration: Duration(milliseconds: 400),
      //   tabBackgroundColor: Colors.grey[100]!,
      //   color: Colors.black,
      //   tabs: [
      //     GButton(icon: Icons.home_rounded),
      //     GButton(icon: Icons.flight_takeoff_rounded),
      //     GButton(icon: Icons.favorite_rounded),
      //     GButton(icon: Icons.person),
      //   ],
      // ),
    );
  }
}
