import 'package:bloodlink/Views/auth/constants/Routes.dart';
import 'package:bloodlink/Views/auth/SignUP/Information_Form.dart';
import 'package:bloodlink/Views/auth/SignIn/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sign_UP extends StatefulWidget {
  const Sign_UP({super.key});

  @override
  State<Sign_UP> createState() => _Sign_UPState();
}

class _Sign_UPState extends State<Sign_UP> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  get userID => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset("assets/blood2.png"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Welcome to",
                        style: GoogleFonts.kavoon(fontSize: 40),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "BLOODLINK",
                        style: GoogleFonts.kavoon(fontSize: 50),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Create a new account",
                        style: GoogleFonts.jomhuria(fontSize: 50),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.red.shade50,
                  shadowColor: Colors.black,
                  elevation: 10,
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
                              labelText: 'Email Address',
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
                              if (value == null || value.isEmpty) {
                                return 'Password must be not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                String userID = userCredential.user!.uid;
                                Routes.instance.push(
                                    widget: Info_Form(id: userID),
                                    context: context);

                                // User successfully signed up. Navigate to another screen here.
                              } on FirebaseAuthException catch (e) {
                                String message = ''; // Provide an initial value
                                if (e.code == 'email-already-in-use') {
                                  message =
                                      'The account already exists for that email.';
                                  Fluttertoast.showToast(
                                    msg: message,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                } else if (e.code == 'weak-password') {
                                  message =
                                      'The password provided is too weak.';
                                  Fluttertoast.showToast(
                                    msg: message,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text('Create a new account'),
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
                              Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                },
                                child: Text('Sign in'),
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
}
