import 'package:flutter/material.dart';

enum TabsEnum {
  home(Icons.home),
  taskCalender(Icons.calendar_month);

  final IconData icon;
  const TabsEnum(this.icon);
}
