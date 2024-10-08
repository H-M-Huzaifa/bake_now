import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:bake_now/UI/Screens/favourites_screen/fav_screen.dart';
import 'package:bake_now/UI/Screens/home_screen/home_screen.dart';
import 'package:bake_now/UI/Screens/order_history_screen/order_history.dart';
import 'package:bake_now/UI/Screens/user_profile_screen/user_profile.dart';
import 'package:bake_now/Utilities/colors.dart';
import 'package:bake_now/Utilities/colors.dart';
import 'package:bake_now/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class bottom_nav_bar extends StatefulWidget {
  const bottom_nav_bar({super.key});

  @override
  State<bottom_nav_bar> createState() => _bottom_nav_barState();
}

class _bottom_nav_barState extends State<bottom_nav_bar> {
  List<Widget> Screens = [
    home_screen(),
    favourite_screen(),
    OrderHistory(),
    user_profile(),
  ];

  int selectedstate = 0;

  List<TabItem> items = [
    TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    TabItem(
      icon: Icons.favorite_border,
      title: 'Favourite',
    ),

    TabItem(
      icon: Icons.history,
      title: 'History',
    ),
    TabItem(
      icon: Icons.account_box,
      title: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedstate, children: Screens),
      bottomNavigationBar: BottomBarInspiredOutside(
        items: items,
        backgroundColor: myColors.primary_color,
        color: myColors.text_primary,
        colorSelected: Colors.white,
        indexSelected: selectedstate,
        onTap: (index) => setState(() {
          selectedstate = index;
        }),
        chipStyle: const ChipStyle(
          color: Colors.red,
          background: myColors.secondary_color,
          convexBridge: false,
          notchSmoothness: NotchSmoothness.sharpEdge,
        ),
        itemStyle: ItemStyle.circle,
        isAnimated: true,
        animated: true,
      ),
    );
  }
}
