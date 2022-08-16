import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeprofessional/screenui/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _phone_number = TextEditingController();
  bool haveaccount = false;
  @override
  void initState() {
    super.initState();
    //   FirebaseFirestore.instance
    //     .collection("Professional Information")
    //     .doc(_phone_number.text)
    //     .get()
    //     .then((value) {
    //   value.exists
    //       ? haveaccount = true
    //       : haveaccount = false;

    //   print(value.exists);
    // });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _phone_number.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextField(
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.phone,
                              controller: _phone_number,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Contact Number",
                                  prefixIcon: Icon(Icons.phone),
                                  fillColor: Colors.grey.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              controller: emailController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  prefixIcon: Icon(Icons.account_box),
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              // keyboardType: TextInputType.number,
                              controller: passwordController,
                              style: TextStyle(),
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  prefixIcon: Icon(Icons.lock_outline_rounded),
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: SignIn,
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'register');
                                  },
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
                                TextButton(
                                    onPressed: ForgotPassword,
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ForgotPassword() {
    print(emailController.text.length);

    if (emailController.text.length != 0) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim())
          .then((value) {
        Fluttertoast.showToast(
            msg: "Password Reset Email Sent",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: "Password Rest Email Not Sent",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Enter the E-mail",
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 12);
    }
  }
//  verifyOTP()
//  async {
//  await FirebaseAuth.instance.signInWithCredential(
//   PhoneAuthProvider.credential(verificationId: , smsCode:passwordController.text)
//  ).whenComplete(()
//  {
//   print("sucess");
//  });
//  }

  SignIn() {
    if (_phone_number.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        Fluttertoast.showToast(
            msg: "Login Sucessfull",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);

        FirebaseFirestore.instance
            .collection("Personal Information")
            .doc(_phone_number.text.trim().toString())
            .get()
            .then((value) {
          value.exists ? haveaccount = true : haveaccount = false;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        haveaccount: haveaccount,
                        contact_number: _phone_number.text,
                      )));

          print(value.exists);
        });
      }).onError((error, stackTrace) {
        print(error.toString());
        Fluttertoast.showToast(
            msg: "Login Unsucessfull",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      });
    } else {
      if (emailController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "E-mail Required",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      } else if (passwordController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Password Required",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      } else if (_phone_number.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Phone Number Required",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      }
    }
  }
}
