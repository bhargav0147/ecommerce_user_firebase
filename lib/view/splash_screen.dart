import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Get.toNamed('/login');
    });
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/9674/9674989.png',
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),
            Text('Ecommerce App',style: TextStyle(letterSpacing: 1,color: Colors.black,fontSize: 20),)
          ],
        ),
      )
    ));
  }
}
