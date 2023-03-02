

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
void showSnackBar(BuildContext context, String content){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(content)
      )
  );
}
Future<File?>pickImage(BuildContext context) async {
  File? image;
  try{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      image= File(pickedImage.path);

    }
  }catch(e){
    showSnackBar(context, e.toString());
  }
  return image;
}

class Babatunde{

  final String text;
  final int num;
  final String balance;

  Babatunde({required this.text, required this.num, required this.balance});


}

class Customer {
  Customer(
      {required this.accountName,
        required this.bankName,
        required this.accountNumber,
        required this.bankBalance});
  final String accountName;
  final String bankName;
  final int accountNumber;
  final double bankBalance;
}

 TextFormField Foreignfield(String text, String content, BuildContext context, int fourty, TextEditingController controller, Color color){
  return  TextFormField(
    key: null ,
    controller: controller,


  );
 }