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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_getPokerCards(context), _getPokerValueWidgets(), _getActionButton()]);
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getPokerCards(context),
            _getPokerValueWidgets(),
          ]);
    }
  }

  Widget _getActionButton() {
    if (estimate.revealed) {
      return Padding(
          padding: EdgeInsets.all(12.0),
          child: ElevatedButton(onPressed: () => startEstimate(), child: Text('Start Estimate')));
    } else {
      return Padding(
          padding: EdgeInsets.all(12.0), child: ElevatedButton(onPressed: () => reveal(), child: Text('Reveal')));
    }
  }

  Widget _getPokerCards(BuildContext context) {
    final List<Widget> widgets = [1, 2, 3, 5, 8]
        .map((e) => Card(
            child: Padding(
                padding: EdgeInsets.all(4.0),
                child: TextButton(
                  child: Text('$e', style: Theme.of(context).textTheme.button),
                  onPressed: estimate.revealed ? () => {} : () => sendPokerValue(e),
                ))))
        .toList();

    return Padding(
        padding: EdgeInsets.all(12.0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: widgets));
  }

  Widget _getPokerValueWidgets() {
    final List<Widget> widgets = estimate.getPokerValues().map((e) {
      final pokerValue = estimate.revealed ? '$e' : 'X';
      return Card(child: Padding(padding: EdgeInsets.all(4.0), child: Text(pokerValue)));
    }).toList();

    return Padding(
        padding: EdgeInsets.all(12.0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: widgets));
  }
}
