import 'package:flutter/material.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/widgets/app_bar.dart';

class ViewFloorMapScreen extends StatefulWidget {
  final int data;

  ViewFloorMapScreen({required this.data});

  @override
  _ViewFloorMapScreenState createState() => _ViewFloorMapScreenState();
}

class _ViewFloorMapScreenState extends State<ViewFloorMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        centerTitle: false,
        title: Text(
          'Floor Map View',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.apply(color: primary)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Image.network(
          'https://ifazility.com/optdesk/floorplanimages/wing/${widget.data}.jpg',
        ),
      ),
    );
  }
}
