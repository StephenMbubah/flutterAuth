
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/provider/auth_provider.dart';
import 'package:untitled1/screens/home_screen.dart';
import 'package:untitled1/screens/userinformationscreen.dart';
import 'package:untitled1/widgets/custom_button.dart';

import '../utilities/utils.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);
  final String verificationId;


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading= Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: isLoading == true?
              const Center(
                child:CircularProgressIndicator(
                  color: Colors.purple,
                ) ,
              ):
              Center(
              child: Padding(
              padding: EdgeInsets .symmetric(vertical: 25, horizontal: 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: ()=> Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            Container(
            width: 200,
            height: 200,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purple.shade50,
            ),
            child: Image.asset('assets/images/images.dart'),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Verification",
            style: TextStyle(fontSize: 22, color: Colors.black38,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10),
          const Text("Enter the OTP sent to your phone", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black38,fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 15,
              ),

              // remember to use the pin interest package to design the boxes for the OTP
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.purple.shade200),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
                onCompleted: (value){
                  setState(() {
                    otpCode= value;
                  });
                  print(otpCode);
                },
              ),
                  const SizedBox(
                    height : 25
                  ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: CustomButton(
                  text: 'Verify',
                  onPressed: (){
                    print(otpCode);
                    otpCode != null? verifyOtp(context, otpCode!): showSnackBar(context, "Enter 6-digit code");
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Didn't receive any code?",
                style:TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black ) ,),
              const SizedBox(
                height: 15,
              ),
              const Text("Resend New Code",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold, color: Colors.purple
                ),)


            ])


          ),),),),);
  }
  void verifyOtp(BuildContext context, String userOtp){
    final ap= Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSuccess: (){
          // check whether user exists in the db
          ap.checkExistingUser().then((value) async{
            if(value==true){
              //user exists in our app
              ap.getDataFromFirestore().then((value) => ap.setSignIn().then
                ((value) =>
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context)=>const HomeScreen()), (route) => false)));
            }else{
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(
                  builder: (context)=> const UserInformationScreen()),
                      (route) => false);
            }
          });
        }
    );

  }
}

