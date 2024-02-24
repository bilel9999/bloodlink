import 'package:bloodlink/Views/auth/SignUP/SignUP.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/SignIn/login_screen.dart';

class Front_page extends StatefulWidget {
  const Front_page({super.key});

  @override
  State<Front_page> createState() => _Front_pageState();
}

class _Front_pageState extends State<Front_page> {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Container(
        color: Color(0xfff6e5e5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.asset("assets/blood2.png"),
            ),
            Text(
              "BLOODLINK",
              style: GoogleFonts.kavoon(fontSize: 50),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    width: width * 0.7,
                    child: TextButton(
                      child: Text(
                        'Sign in',
                        style: GoogleFonts.jomhuria(
                          fontSize: 40,
                        ),
                      ),
                      style: TextButton.styleFrom(
                          shadowColor: Colors.black,
                          primary: Color(0xffF95C5C),
                          backgroundColor: Color(0xffFFFFFF).withOpacity(0.86)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width * 0.7,
                    child: TextButton(
                      child: Text(
                        'Create Account',
                        style: GoogleFonts.jomhuria(fontSize: 40),
                      ),
                      style: TextButton.styleFrom(
                          primary: Color(0xffFFFFFF).withOpacity(0.84),
                          backgroundColor: Color(0xffEF8282).withOpacity(0.55)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Sign_UP()),
                          // MaterialPageRoute(builder: (context) => Sign_UP()),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
