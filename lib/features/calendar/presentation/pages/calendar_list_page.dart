import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';

class CalendarListPage extends StatelessWidget {
  const CalendarListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendars'),
      ),
      body: Container(
        color: kcSuccess300,
      ),
      // ListView.builder(itemBuilder: (context, index) => ListTile(
      //   title: ,
      // ),),
    );
  }
}
