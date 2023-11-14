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
    return InkWell(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
        });
        widget.onTap?.call();
      },
      splashColor: Colors.black,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: isPressed
            ? BorderSide(color: Colors.green, width: 2.0)
            : BorderSide(color: Colors.grey.shade200, width: 2.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontFamily: 'Manrope',
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
