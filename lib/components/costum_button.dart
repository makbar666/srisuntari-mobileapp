import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onTap;

  const CustomButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
        primary: Colors.grey.shade100,
        onPrimary: Colors.black54,
        elevation: 0, // Hapus bayangan pada tombol
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(14.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
