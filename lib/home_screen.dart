import 'package:flutter/material.dart';

import 'widgets/bottom_sheet_transition.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: width,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 70,
                  width: width,
                ),
                Container(
                  height: 400,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/wegz.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            const BottomSheetTransition(),
            
            ],
        ),
      ),
    );
  }
}
