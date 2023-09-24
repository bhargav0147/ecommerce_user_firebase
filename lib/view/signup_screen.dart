import 'package:ecommerce_user_firebase/utlis/ecoom_firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 550,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(65))),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Container(
                      width: double.infinity,
                      height: 150,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/512/9674/9674989.png',
                              height: 100,
                              width: 100,
                            ),
                            const SizedBox(height: 10),
                            Text('Ecommerce App',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25)),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  height: 526,
                  width: 335,
                  decoration: BoxDecoration(
                    // color: ThemeColor.primaryBackground,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    child: Container(
                      color: Colors.white24,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            height: 4,
                            width: 38,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.black),
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Create Your Account',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            height: 60,
                            width: double.infinity,
                            child: showTextfield('Email', txtEmail),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 60,
                            width: double.infinity,
                            child: showTextfield('Password', txtPass),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () async {
                              String massage = await FirebaseHelper.helper.createAcoountWithEmailPass(
                                  password: txtPass.text, email: txtEmail.text);
                              if (massage == "Success") {
                                Get.back();
                              }
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text("$massage")));
                            },
                            child: Container(
                              height: 49,
                              width: 296,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.amber),
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'I have already account ',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black54),
                              ),
                              InkWell(
                                onTap: () {
                                Get.back();
                                },
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget showTextfield(
      String hint,
      TextEditingController controllerName,
      ) {
    return TextField(
      controller: controllerName,
      cursorColor: Colors.black54,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              fontSize: 15,
              fontFamily: 'prompt',
              fontWeight: FontWeight.w400,
              color: Colors.black54),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.amber))),
    );
  }
}
