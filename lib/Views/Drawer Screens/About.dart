import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: GoogleFonts.jomhuria(fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF95C5C),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xfff6e5e5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/blood2.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '''
Imagine this: A siren wails, a life hangs in the balance. They need a specific blood type, and time is running out. 
But wait... 
YOU appear! With BloodLink, you're not just a user, you're a hero on-demand.

Every ping on your phone is a call to action: a chance to be the missing piece, the match that saves a life. Hospitals in your area send urgent requests, and YOU decide if you can answer the call. No pressure, just the power to make a difference, one blood donation at a time.

Be the hero your community needs.
Be the reason someone gets another chance. Together, we can rewrite stories, one blood drop at a time.''',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
