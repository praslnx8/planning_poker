import 'package:flutter/material.dart';
import 'package:planning_poker/models/estimate.dart';

class EstimateWidget extends StatefulWidget {
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
  _EstimateWidgetState createState() => _EstimateWidgetState();
}

class _EstimateWidgetState extends State<EstimateWidget> {
  final _estimateDescFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isFacilitator) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(24)),
            Column(
              children: [
                _getEstimateTextWidget(context),
                _getPokerValueWidgets(context),
                _getActionButton(context),
              ],
            ),
            Column(
              children: [
                Text('Choose your estimates', style: Theme.of(context).textTheme.headline6),
                _getPokerCards(context),
              ],
            ),
            Padding(padding: EdgeInsets.all(24)),
          ]);
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(24)),
            Column(
              children: [
                _getEstimateTextWidget(context),
                _getPokerValueWidgets(context),
              ],
            ),
            Column(
              children: [
                Text('Choose your estimates', style: Theme.of(context).textTheme.headline6),
                _getPokerCards(context),
              ],
            ),
            Padding(padding: EdgeInsets.all(24)),
          ]);
    }
  }

  Widget _getActionButton(BuildContext context) {
    if (widget.estimate.revealed) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 240,
              child: TextFormField(
                controller: _estimateDescFieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 5.0),
                  ),
                  labelText: 'Story ID(Optional)',
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(12)),
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20))),
                onPressed: () => widget.startEstimate(_estimateDescFieldController.value.text),
                child: Text(
                  'Start Another Estimate',
                ))
          ]);
    } else {
      return Padding(
          padding: EdgeInsets.all(12.0),
          child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20))),
              onPressed: () => widget.reveal(),
              child: Text(
                'Reveal',
              )));
    }
  }

  Widget _getEstimateTextWidget(BuildContext context) {
    final estimateTextContent = widget.estimate.desc != null && widget.estimate.desc!.isNotEmpty
        ? 'Estimates for ${widget.estimate.desc!}'
        : 'Estimates';
    return Text(estimateTextContent, style: Theme.of(context).textTheme.headline6);
  }

  Widget _getPokerCards(BuildContext context) {
    final List<Widget> widgets = [1, 2, 3, 5, 8]
        .map(
          (e) => Container(
              margin: EdgeInsets.all(10), // Top Margin
              child: OutlinedButton(
                  onPressed: widget.estimate.revealed ? null : () => widget.sendPokerValue(e),
                  child: Text('$e', style: Theme.of(context).textTheme.headline3))),
        )
        .toList();

    return Padding(
        padding: EdgeInsets.all(12.0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: widgets));
  }

  Widget _getPokerValueWidgets(BuildContext context) {
    final colorCode = widget.estimate.revealed ? Colors.white : Colors.white60;
    final alternateColorCode = widget.estimate.revealed ? Colors.white60 : Colors.white;
    final List<Widget> widgets = widget.estimate.getPokerValues().map((e) {
      final pokerValue = widget.estimate.revealed ? '$e' : 'X';
      return Card(
          color: colorCode,
          child: Padding(
              padding: EdgeInsets.all(12.0), child: Text(pokerValue, style: Theme.of(context).textTheme.headline4)));
    }).toList(growable: true);
    if (widget.playerCount > widget.estimate.getPokerValues().length) {
      for (int i = 0; i < (widget.playerCount - widget.estimate.getPokerValues().length); i++) {
        widgets.add(Card(
            color: alternateColorCode,
            child: Padding(
                padding: EdgeInsets.all(12.0), child: Text('?', style: Theme.of(context).textTheme.headline4))));
      }
    }

    return Container(
        color: Colors.white70,
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.all(12.0),
        child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: widgets));
  }
}
