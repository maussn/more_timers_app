import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTile extends StatelessWidget {
  int value;

  MyTile({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
        child: Text(
          value < 10 ? '0$value' : value.toString(),
          style: TextStyle(
            fontSize: 40,
            color:Colors.white,
            fontWeight: FontWeight.bold,
          )
        ),
      ),
    );
  }
}