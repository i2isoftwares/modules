import 'package:flutter/material.dart';

AppBar customAppBar(
  BuildContext context, {
  Widget? title,
  Widget? bottom,
  Color? backgroundColor,
  IconThemeData? iconTheme,
  bool? centerTitle,
  Widget? leading,
  List<Widget>? actions,
  bool noLeading = false,
}) {
  return AppBar(
    elevation: 0,
    // bottom: bottom ?? SizedBox(),
    backgroundColor: backgroundColor,
    iconTheme: iconTheme,
    leading: noLeading
        ? null
        : leading ??
            IconButton(
              icon: Image.asset(
                'assets/optdesk/back arrow-8.png',
                height: 22,
                width: 22,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 12,
            ),
    actions: actions,
    title: title,
    centerTitle: centerTitle,
  );
}
