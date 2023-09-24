import 'package:ecommerce_user_firebase/firebase_options.dart';
import 'package:ecommerce_user_firebase/view/cart_screen.dart';
import 'package:ecommerce_user_firebase/view/home_screen.dart';
import 'package:ecommerce_user_firebase/view/login_screen.dart';
import 'package:ecommerce_user_firebase/view/signup_screen.dart';
import 'package:ecommerce_user_firebase/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/':(p0) => SplashScreen(),
      '/login':(p0) => LoginScreen(),
      '/signup':(p0) => SignUpScreen(),
      '/home':(p0) => HomeScreen(),
      '/cart':(p0) => CartScreen(),
    },
  ));
}