import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:recipe_chef/utils/app_colors.dart';

import 'widgets/nav_bar_widget.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe'),
      ),
      body: screens[visit],

      bottomNavigationBar: BottomBarCreative(
        items: items,
        backgroundColor: mainColor,
        color: green,
        colorSelected: black,
        indexSelected: visit,
        isFloating: true,
        highlightStyle:const HighlightStyle(sizeLarge: true, background:black, elevation: 3),
        onTap: (int index) => setState(() {
          visit = index;
          print(index);
        }),
      ),

    );
  }
}
