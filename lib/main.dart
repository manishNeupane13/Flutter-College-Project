import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeprofessional/screenui/Cleaner.dart';
import 'package:homeprofessional/screenui/homePage.dart';
import 'package:homeprofessional/screenui/loginPage.dart';
import 'package:homeprofessional/screenui/registerPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'On Demand',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(haveaccount: true,),
      debugShowCheckedModeBanner: false,
      routes: {
        'login': (context) => LoginPage(),
        'register': (context) => RegisterPage(),
        'Cleaner': (context) => Cleaner(),
      },
    );
  }
}
