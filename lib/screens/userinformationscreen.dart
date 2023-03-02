import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/model/user_model.dart';
import 'package:untitled1/provider/auth_provider.dart';
import 'package:untitled1/screens/home_screen.dart';
import 'package:untitled1/utilities/utils.dart';
import 'package:untitled1/widgets/custom_button.dart';
import 'dart:io';

import 'package:untitled1/widgets/textfeld.dart';
class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
  }
// for selecting image
  void selectImage()async{
    image = await pickImage(context);
    setState(() {

    });
}

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true?
        const Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        ):
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {selectImage();},
                  child: image == null
                      ? const CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 50,
                    child: Icon(Icons.account_circle,
                      size: 50,
                      color: Colors.white,),
                  )
                      : CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 50,
                  ),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 15),
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      textFeld(hintText: "Stephen Mbubah",
                          icon: Icons.account_circle,
                          maxLines: 1,
                          controller: nameController,
                          inputType: TextInputType.name),
                      textFeld(hintText: "abc@example.com",
                          icon: Icons.email,
                          maxLines: 1,
                          inputType: TextInputType.emailAddress,
                          controller: emailController),
                      textFeld(hintText: "Enter your bio here",
                          icon: Icons.edit,
                          maxLines: 1,
                          controller: bioController,
                          inputType: TextInputType.name),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width* 0.8,
                        child: CustomButton(
                          text: "Continue",
                          onPressed: (){
                            StoreData();
                          },
                        ),
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
  //store user data to database
void StoreData()async{
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        uid: "",
        bio: bioController.text.trim(),
        phoneNumber: "",
        createdAt: "",
        profilePic: "");
    if(image!=null){
      ap.saveUserDataToFirebase(
          context: context,
          userModel: userModel,
          profilePic: image! ,
          onSuccess: (){
            //once data is saved we need to store it locally also
            ap.saveUserDataToSP().then((value) => ap.setSignIn()).
            then((value) =>
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(
                    builder: (context)=>const HomeScreen()) ,
                        (route) => false));
          });
    }else {
      showSnackBar(context, "Please upload your profile photo");
    }
}
}
