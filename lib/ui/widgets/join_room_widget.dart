import 'package:flutter/material.dart';
import 'package:planning_poker/utils/app_context_extension.dart';

class JoinRoomWidget extends StatefulWidget {
  final Function joinRoom;

  const JoinRoomWidget({required this.joinRoom});

  @override
  _JoinRoomWidgetState createState() => _JoinRoomWidgetState();
}

class _JoinRoomWidgetState extends State<JoinRoomWidget> {
  final _formKey = GlobalKey<FormState>();
  final _roomNoFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child:
            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 240,
            child: TextFormField(
              controller: _roomNoFieldController,
              validator: (value) {
                if (value?.isEmpty == true) {
                  return context.resources.strings.enterRoomNo;
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5.0),
                ),
                labelText: context.resources.strings.enterRoomNo,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(12)),
          ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20))),
            onPressed: () => {
              if (_formKey.currentState!.validate()) {widget.joinRoom(_roomNoFieldController.value.text)}
            },
            child: Text(context.resources.strings.joinRoom),
          ),
        ]));
  }
}
