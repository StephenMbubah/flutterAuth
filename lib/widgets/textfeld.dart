
import 'package:flutter/material.dart';

Widget textFeld({required String hintText,
  required IconData icon,
  required int maxLines,
  required TextEditingController controller,
  required TextInputType inputType,
}){
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: TextFormField(
      cursorColor: Colors.purple,
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Container(
          margin:  const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.purple,
          ),
          child: Icon(icon,
            size: 20,
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Colors.transparent
          ),
        ),
        hintText:  hintText,
        alignLabelWithHint: true,
        fillColor: Colors.purple.shade50,
        filled: true,
      ),
    ),

  );
}
