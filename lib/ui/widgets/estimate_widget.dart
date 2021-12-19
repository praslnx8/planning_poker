import 'package:flutter/material.dart';
import 'package:planning_poker/models/estimate.dart';

class EstimateWidget extends StatelessWidget {
  final Estimate estimate;
  final bool isFacilitator;
  final Function startEstimate;
  final Function sendPokerValue;
  final Function reveal;

  const EstimateWidget(
      {required this.estimate,
      required this.isFacilitator,
      required this.startEstimate,
      required this.sendPokerValue,
      required this.reveal});

  @override
  Widget build(BuildContext context) {
    if (isFacilitator) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center, children: [_getPokerValueWidgets(), _getActionButton()]);
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center, children: [_getPokerValueWidgets(), _getPokerCards()]);
    }
  }

  Widget _getActionButton() {
    if (estimate.isRevealed) {
      return ElevatedButton(onPressed: () => startEstimate(), child: Text('Start Estimate'));
    } else {
      return ElevatedButton(onPressed: () => reveal(), child: Text('Reveal'));
    }
  }

  Widget _getPokerCards() {
    final List<Widget> widgets = [1, 2, 3, 5, 8]
        .map((e) => Card(
                child: TextButton(
              child: Text('$e'),
              onPressed: () => sendPokerValue(e),
            )))
        .toList();

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }

  Widget _getPokerValueWidgets() {
    final List<Widget> widgets = estimate.getPokerValues().map((e) {
      final pokerValue = estimate.isRevealed ? '$e' : 'X';
      return Card(child: Text(pokerValue));
    }).toList();

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }
}
