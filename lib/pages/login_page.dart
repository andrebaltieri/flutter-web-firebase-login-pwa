import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gvault/globals.dart';
import 'package:gvault/models/user_model.dart';
import 'package:gvault/pages/dashboard_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEE4A63),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 250,
          ),
          SizedBox(
            height: 32,
            width: double.infinity,
          ),
          MaterialButton(
            color: Colors.white,
            onPressed: () async {
              var loggedIn = await signInWithGoogle();
              if (loggedIn) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text("Login com Google"),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> signInWithGoogle() async {
    await Firebase.initializeApp();

    final UserCredential userCredential =
        await _auth.signInWithPopup(new GoogleAuthProvider());

    final User? user = userCredential.user;

    if (user != null) {
      loggedUser = new UserModel(
        displayName: user.displayName ?? '',
        email: user.email ?? '',
        photoUrl: user.photoURL ?? '',
      );

      return true;
    }

    return false;
  }
}
