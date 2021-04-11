import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DEFAULT_COLOR = Color.fromRGBO(112, 112, 112, 1);
  static const DARK_COLOR = Color.fromRGBO(82, 82, 82, 1);
  static const OPERATION_COLOR = Color.fromRGBO(250, 158, 13, 1);

  final String text;
  final bool large;
  final Color color;
  final void Function(String) callback;

  Button({ 
    @required this.text, 
    this.large = false, 
    this.color = DEFAULT_COLOR,
    @required this.callback
  });
  
  Button.large({
    @required this.text, 
    this.large = true, 
    this.color = DEFAULT_COLOR,
    @required this.callback
  });
  
  Button.operation({
    @required this.text, 
    this.large = false, 
    this.color = OPERATION_COLOR,
    @required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: large ? 2 : 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: this.color),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w200)),
        onPressed: () => callback(text),
      ),
    );
  }
}
