import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/model/user_model.dart';
import 'package:untitled1/screens/otp_screen.dart';
import 'package:untitled1/utilities/utils.dart';
import 'dart:io';

class AuthProvider extends ChangeNotifier{
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  late UserModel? newModel;
  UserModel  get userModel => newModel!;

  final FirebaseAuth _fireBaseAuth =FirebaseAuth.instance;
  final FirebaseFirestore _fireBaseFirestore =FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;


  
   AuthProvider(){
    checkSign();
  }
  void checkSign() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("isSigned") ?? false;
    notifyListeners();
  }
  Future setSignIn()async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true)?? false;
    notifyListeners();

  }
  void signInwithPhone(BuildContext context, String phoneNumber)async{
    try{
      await _fireBaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential)async{
            await _fireBaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error){
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken){
            Navigator.push(context,
                MaterialPageRoute(
                builder: (context)=> OtpScreen(verificationId:verificationId,)));
          },
          codeAutoRetrievalTimeout: (verificationId){}
      );
    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
})async{
    _isLoading = true;
    notifyListeners();
    try{
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
     User user = (await _fireBaseAuth.signInWithCredential(creds)).user!;
     if (user != null){
       _uid = user.uid;
       onSuccess();
     }
     _isLoading = false;
     notifyListeners();
    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }

  }

  //DATABASE OPERATION
Future<bool> checkExistingUser() async{
    DocumentSnapshot snapshot =await _fireBaseFirestore.collection("users").doc(_uid).get();
    if(snapshot.exists){
      print("USER EXISTS");
      return true;
    }else{
      print("NEW USER");
      return false;
    }
}
void saveUserDataToFirebase({
  required BuildContext context,
  required UserModel userModel,
  required File profilePic,
  required Function onSuccess,
})async{
    _isLoading = true;
    notifyListeners();
    try{
      // uploading image to firebase storage.
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        userModel.profilePic = value;
        userModel.createdAt= DateTime.now().microsecondsSinceEpoch.toString();
        userModel.phoneNumber= _fireBaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _fireBaseAuth.currentUser!.phoneNumber!;
      });
      newModel = userModel;

      // uploading to database
      await _fireBaseFirestore.collection("users").doc(_uid).set(userModel.toMap()).then((value){
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
}
Future<String>storeFileToStorage(String ref, File file)async{
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot= await uploadTask;
    String downloadurl = await snapshot.ref.getDownloadURL();
    return downloadurl;
}
Future getDataFromFirestore()async{
    await _fireBaseFirestore.collection("users")
  .doc(_fireBaseAuth.currentUser!.uid)
        .get().then((DocumentSnapshot snapshot) {
       newModel = UserModel(
         name: snapshot['name'],
         email: snapshot['email'],
         createdAt: snapshot[''],
         bio: snapshot[''],
         uid: snapshot[''],
         profilePic: snapshot[''],
         phoneNumber: snapshot[''],
       );
    });
}

// storing data locally
Future saveUserDataToSP()async{
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
}
Future getDataFromSP()async{
    SharedPreferences s= await SharedPreferences.getInstance();
    String data = s.getString("user_model")??'';
    newModel = UserModel.froMap(jsonDecode(data));
    _uid =newModel!.uid;
    notifyListeners();
}
Future userSignOut()async{
  SharedPreferences s= await SharedPreferences.getInstance();
    await _fireBaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
}
}

