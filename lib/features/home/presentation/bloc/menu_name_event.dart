import 'package:flutter/material.dart';

abstract class MenuNameEvent {}

class MenuNameSelected extends MenuNameEvent {
  final BuildContext context; // Context to be passed
  final String menuName; // Menu name to be passed

  MenuNameSelected({required this.context, required this.menuName});
}
