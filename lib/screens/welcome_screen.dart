
import 'package:flutter/material.dart';
import 'package:untitled1/screens/register_screen.dart';
import 'package:untitled1/widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        top: true,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:25 ,horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/get started.png"),
                  const SizedBox(height: 20,),
                  const Text("Let's get started", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const Text("Never a better time than now to start", style: TextStyle(fontSize: 14, color: Colors.black38,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                      },
                      text:("Get Started")
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
