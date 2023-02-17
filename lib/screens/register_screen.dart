import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/widgets/custom_button.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController  =TextEditingController();
  Country country = Country(
      phoneCode: "234",
      countryCode: "NIG",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Nigeria",
      example: "Nigeria",
      displayName: "Nigeria",
      displayNameNoCountryCode: "NIG",
      e164Key: ""
  );
  @override
  Widget build(BuildContext context) {
    phoneController.selection= TextSelection.fromPosition(
        TextPosition(
            offset: phoneController.text.length)
    );
    return  Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                child: Column(
                  children: [
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
                    const Text("Register",
                      style: TextStyle(fontSize: 22, color: Colors.black38,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10),
                    const Text("Add a Phone number, we will send you a verification code", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.black38,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: phoneController,
                      cursorColor: Colors.purple,
                      onChanged: (value){
                        setState(() {
                          phoneController.text= value;
                        });
                      },
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: "Enter your PhoneNumber",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey.shade600),
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(8),
                            child: InkWell(
                              onTap: (){
                                showCountryPicker(context: context,
                                    countryListTheme: const CountryListThemeData(
                                      bottomSheetHeight: 450
                                    ),
                                    onSelect: (value){
                                      setState(() {
                                        country=value;
                                      });
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${country.flagEmoji} + ${country.phoneCode}",
                                  style:const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black
                                  ),),
                              ),
                            ),
                        ),
                        suffixIcon: phoneController.text.length>9? Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.done, color: Colors.white,
                            size: 20,
                          ),
                        ): null
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: CustomButton(
                        text: "Login",
                        onPressed: (){},),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
