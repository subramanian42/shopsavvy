import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen._();
  static Widget routeBuilder(BuildContext context, GoRouterState state) {
    return const HomeScreen._();
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1E2022),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 36,
              width: 36,
              margin: EdgeInsets.only(left: 14, top: 48, bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(Assets.profile),
                  ),
                  color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.only(left: 14, bottom: 20),
              child: Text(
                "Time to Cheers! Choose your beer...",
                style: TextStyle(
                  color: Color(0xffAFB2B5),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            // Container(width: 150, height: 298, child: ListItem()),
          ],
        ),
      ),
    );
  }
}
