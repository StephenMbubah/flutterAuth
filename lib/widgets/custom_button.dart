
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)))
        ),
        child: Text(widget.text, style: const TextStyle(fontSize: 16),),
    );
  }
}
