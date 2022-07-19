// source: Base card from Ajarn's bill_splitting

import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({required this.theColor, required this.theChild, this.theOnTap});

  //instance variable
  final Color theColor;
  final Widget theChild;
  final VoidCallback? theOnTap; // function as a variable..nullable


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: theOnTap,
      child: Container(
        child: theChild,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: theColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
