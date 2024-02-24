import 'package:bloodlink/Views/Screens/Home_Screen.dart';
import 'package:bloodlink/Views/auth/constants/Routes.dart';
import 'package:bloodlink/Views/auth/SignUP/SignUP.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6e5e5),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image.asset("assets/blood2.png"),
                  ),
                  Text(
                    "Donor",
                    style: GoogleFonts.kavoon(fontSize: 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.jomhuria(fontSize: 50),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 10,
                    // color: Colors.transparent,
                    color: Color(0xfff6e5e5),
                    surfaceTintColor: Colors.pink.shade100,
                    // shadowColor: Colors.red,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                labelText: 'User name',
                                prefixIcon: Icon(Icons.alternate_email_sharp),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your user name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 10) {
                                  return 'Password must be at least 10 characters long';
                                }
                                return null;
                              },
                            ),
          
                            SizedBox(height: 10),
                          
                            ElevatedButton(
                              onPressed: () async {
                                if (loginValidation(_emailController.text,
                                    _passwordController.text)) {
                                  try {
                                    UserCredential userCredential =
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    // Check if the user is newly created
                                    bool isNewUser = userCredential
                                        .additionalUserInfo!.isNewUser;
                                    if (isNewUser) {
                                      // This is a new user logging in for the first time
                                      print(
                                          'New user logged in for the first time');
                                    } else {
                                      // This is an existing user
                                      print('Existing user logged in');
                                    }
                                    // User successfully signed in. Navigate to another screen here.
                                    String userId = userCredential.user!.uid;
                                    print('User ID: $userId');
                                    Routes.instance.push(
                                        widget: ProfileScreen(id: userId),
                                        context: context);
                                  } on FirebaseAuthException catch (e) {
                                    String message = '';
                                    if (e.code == 'user-not-found') {
                                      message = 'No user found for that email.';
                                      Fluttertoast.showToast(
                                        msg: message,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    } else if (e.code == 'wrong-password') {
                                      message =
                                          'Wrong password provided for that user.';
                                      Fluttertoast.showToast(
                                        msg: message,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    } else if (e.code == 'invalid-email') {
                                      // Handle badly formatted email
                                      message =
                                          'The email address is badly formatted.';
                                      Fluttertoast.showToast(
                                        msg: message,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    }
         
                                  } catch (e) {
                                    // Handle other exceptions
                                    print(e);
                                    Fluttertoast.showToast(
                                      msg: e.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  }
                                }
                              },
                              child: Text('login'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                              ),
                            ),

                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Sign_UP()),
                                    );
                                  },
                                  child: Text('Sign up'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool loginValidation(String email, String password) {
    if (email.isEmpty && password.isEmpty) {
      // _afficherAlerte("Email is Empty");
      Fluttertoast.showToast(
        msg: "Please enter your email and password",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (email.isEmpty) {
      Fluttertoast.showToast(
        msg: "Email is Empty",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Password is Empty",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else {
      return true;
    }
  }

  void _afficherAlerte(String mes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerte'),
          content: Text(mes),
          actions: [
            TextButton(
              onPressed: () {
                // Arrêtez le son quand l'alerte est fermée

                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
