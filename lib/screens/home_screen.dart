import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/provider/auth_provider.dart';
import 'package:untitled1/screens/welcome_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Flutter Phone Auth"),
        actions: [
          IconButton(
              onPressed: (){
                ap.userSignOut().then((value) =>
                Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context)=> const WelcomeScreen())));
                },
              icon:  Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple,
              backgroundImage: NetworkImage(ap.
              newModel!.profilePic),
              radius: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(ap.newModel!.name),
            Text(ap.newModel!.phoneNumber),
            Text(ap.newModel!.email),
            Text(ap.newModel!.bio),
          ],
        ),
      ),
    );
  }
}
