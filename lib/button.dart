import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  final child;
  final function;
  static bool holdingButton = false;
  const MyButton({this.child,this.function});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        function();
      },
      child: Container(
        color: Colors.teal,
        child: child,
      ),
    );
  }
}
