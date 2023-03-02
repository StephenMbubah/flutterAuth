
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/provider/auth_provider.dart';
import 'package:untitled1/screens/home_screen.dart';
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
    final ap =Provider.of<AuthProvider>(context, listen: false);
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
                      onPressed: ()async{
                        if(ap.isSignedIn==true){
                          await ap.getDataFromSP().whenComplete(() => Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context)=> RegisterScreen())));
                          print('signed in');
                        }else{
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          print("not signed in");
                        }
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
