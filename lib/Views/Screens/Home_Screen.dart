import 'package:bloodlink/Views/Drawer%20Screens/About.dart';
import 'package:bloodlink/Views/Drawer%20Screens/Profile_info.dart';
import 'package:bloodlink/Views/Drawer%20Screens/Settings.dart';
import 'package:bloodlink/Views/auth/SignIn/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  final String id;

  const ProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.jomhuria(fontSize: 40, color: Colors.white),
        ),
        backgroundColor: Colors.redAccent.shade400,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('InfoForm')
            .doc(id)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(child: Text('No data available'));
          }

          Map<String, dynamic> userData =
              snapshot.data!.data() as Map<String, dynamic>;
          String name = userData['name'] ?? '';
          String surname = userData['surname'] ?? '';

          return Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent.shade400,
                  Colors.redAccent,
                  Color(0xfff95c5c),
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xfff95c5c),
                      size: 50.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Welcome, $name $surname!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'We are thrilled to have you with us.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              color: const Color(0xffF95C5C),
            ),
            Expanded(
              child: Container(
                color: const Color(0xfff6e5e5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildListTile(
                      icon: Icons.person,
                      text: 'Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile_Info(id: id)),
                        );
                      },
                    ),
                    buildListTile(
                      icon: Icons.settings,
                      text: 'Settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Settings_Page(id: id)),
                        );
                      },
                    ),
                    buildListTile(
                      icon: Icons.info,
                      text: 'About',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => About()),
                        );
                      },
                    ),
                    buildListTile(
                      icon: Icons.logout,
                      text: 'Log out',
                      onTap: () {
                        // Log out the user
                        logout(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    try {
      // Sign out the current user
      await FirebaseAuth.instance.signOut();

      // Navigate back to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginScreen()), // Replace 'LoginScreen()' with your actual login screen
      );
    } catch (e) {
      // Handle any errors that occur during logout
      print('Error logging out: $e');
      // Optionally, display an error message or handle the error in a different way
    }
  }

  Widget buildListTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16), // Adjust padding
      leading: Icon(
        icon,
        color: Colors.red,
        size: 40,
      ),
      title: Align(
        // Align icon and text vertically
        alignment: Alignment.centerLeft,
        child: Text(text, style: GoogleFonts.jomhuria(fontSize: 50)),
      ),
      onTap: onTap,
    );
  }
}
