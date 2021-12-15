import 'package:flutter/material.dart';
import 'package:planning_poker/models/system.dart';
import 'package:planning_poker/ui/landing.page.dart';

void main() {
  runApp(PlanningPokerApp(System()));
}

class PlanningPokerApp extends StatelessWidget {
  final System _system;

  PlanningPokerApp(this._system);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planning Poker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(system: this._system),
    );
  }
}
