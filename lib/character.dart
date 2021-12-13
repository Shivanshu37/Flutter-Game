import 'package:flutter/material.dart';
class Character extends StatelessWidget {
  const Character({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 80,height: 80,child: Image.asset('images/img_1.png'));
  }
}
