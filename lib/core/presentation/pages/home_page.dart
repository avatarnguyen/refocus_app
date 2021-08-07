import 'package:flutter/material.dart';
import 'package:refocus_app/core/presentation/pages/today_page.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: const [
        CalendarPage(),
        TodayPage(),
      ],
    );
  }
}
