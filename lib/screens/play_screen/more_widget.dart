import 'package:flutter/material.dart';

class MoreWidget extends StatelessWidget {
  final Size size;
  const MoreWidget(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown.shade600),
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg/prbg.png'), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Column());
  }
}
