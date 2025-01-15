import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;

   const MyButton({
    super.key,
  required this.text,
  required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpressed,
      color: Theme.of(context).primaryColor,
      child: Text(text),
    );
  }
}
