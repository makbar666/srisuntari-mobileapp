import 'package:flutter/material.dart';

class CostumButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const CostumButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.black, // Warna efek "splash" saat sentuhan
      highlightColor: Colors.green, // Warna saat widget ditekan
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(
            color: Colors.grey.shade200, // Warna garis pinggir
            width: 2.0, // Lebar garis pinggir
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Manrope',
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}