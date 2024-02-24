import 'package:bloodlink/Views/Drawer%20Screens/Edit_Profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings_Page extends StatefulWidget {
  final String id;

  const Settings_Page({Key? key, required this.id}) : super(key: key);
  @override
  State<Settings_Page> createState() => _SettingsState();
}

class _SettingsState extends State<Settings_Page> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.15,
        centerTitle: true,
        backgroundColor: Color(0xffF95C5C),
        title: Text(
          "Settings",
          style: GoogleFonts.jomhuria(fontSize: 60),
        ),
      ),
      body: Container(
        color: Color(0xfff6e5e5),
        child: Column(
          children: [
            buildListTile(
              icon: Icons.edit,
              text: 'Edit Profile',
              onTap: () {
                // Navigate to profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Edit_Profile(id: widget.id)),
                );
              },
            ),
          ],
        ),
      ),
    );
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
      // trailing: Icon(
      //   Icons.arrow_forward_ios,
      //   color: Colors.grey,
      // ),
      onTap: onTap,
    );
  }
}
