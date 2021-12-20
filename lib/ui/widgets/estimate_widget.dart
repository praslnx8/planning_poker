import 'package:flutter/material.dart';
import 'package:planning_poker/models/estimate.dart';

class EstimateWidget extends StatelessWidget {
  final Estimate estimate;
  final bool isFacilitator;
  final int playerCount;
  final Function startEstimate;
  final Function sendPokerValue;
  final Function reveal;

  const EstimateWidget(
      {required this.estimate,
      required this.isFacilitator,
      required this.playerCount,
      required this.startEstimate,
      required this.sendPokerValue,
      required this.reveal});

  @override
  Widget build(BuildContext context) {
    if (isFacilitator) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Choose your estimates', style: Theme.of(context).textTheme.headline6),
            _getPokerCards(context),
            Padding(padding: EdgeInsets.all(24)),
            Text('Estimates', style: Theme.of(context).textTheme.headline6),
            _getPokerValueWidgets(context),
            _getActionButton(context)
          ]);
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Choose your estimates', style: Theme.of(context).textTheme.headline6),
            _getPokerCards(context),
            Text('Estimates', style: Theme.of(context).textTheme.headline6),
            _getPokerValueWidgets(context),
          ]);
    }
  }

  Widget _getActionButton(BuildContext context) {
    if (estimate.revealed) {
      return Padding(
          padding: EdgeInsets.all(12.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
              onPressed: () => startEstimate(),
              child: Text(
                'Start Another Estimate',
              )));
    } else {
      return Padding(
          padding: EdgeInsets.all(12.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
              onPressed: () => reveal(),
              child: Text(
                'Reveal',
              )));
    }
  }

  Widget _getPokerCards(BuildContext context) {
    final List<Widget> widgets = [1, 2, 3, 5, 8]
        .map((e) => Card(
            child: Padding(
                padding: EdgeInsets.all(4.0),
                child: TextButton(
                  child: Text('$e', style: Theme.of(context).textTheme.headline3),
                  onPressed: estimate.revealed ? null : () => sendPokerValue(e),
                ))))
        .toList();

    return Padding(
        padding: EdgeInsets.all(12.0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: widgets));
  }

  Widget _getPokerValueWidgets(BuildContext context) {
    final List<Widget> widgets = estimate.getPokerValues().map((e) {
      final pokerValue = estimate.revealed ? '$e' : 'X';
      return Card(
          color: Colors.white12,
          child: Padding(
              padding: EdgeInsets.all(12.0), child: Text(pokerValue, style: Theme.of(context).textTheme.headline4)));
    }).toList(growable: true);
    if (playerCount > estimate.getPokerValues().length) {
      for (int i = 0; i < (playerCount - estimate.getPokerValues().length); i++) {
        widgets.add(Card(
            child: Padding(
                padding: EdgeInsets.all(12.0), child: Text('?', style: Theme.of(context).textTheme.headline4))));
      }
    }

    return Padding(
        padding: EdgeInsets.all(12.0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: widgets));
  }
}
