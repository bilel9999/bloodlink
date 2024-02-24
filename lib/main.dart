import 'package:bloodlink/Views/Screens/Front_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "BloodLink",
      options: const FirebaseOptions(
          apiKey: "AIzaSyALXtkiHAglIcV4qxSUngw6Yd6jtDcK0SE",
          appId: "1:322242423384:android:ddd6808158c37720ce382d",
          messagingSenderId: "AIzaSyANIPmw37ZBD91xt8Bs4hnfh-8vGEPgi0U",
          projectId: "bloodlink-ab798"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xfff6e5e5)),
        useMaterial3: true,
      ),
      home: const Front_page(),
    );
  }
}
