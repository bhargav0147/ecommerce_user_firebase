import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_firebase/model/ecom_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static final FirebaseHelper helper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
 Stream<QuerySnapshot<Map<String, dynamic>>> readData()
 {
  return firestore.collection("product").snapshots();

 }

  Future<void> addNotes(EcomModel dataList
      ) async {
    await firestore.collection("SaveCart").add({
      "title": dataList.title,
      "description": dataList.des,
      "category": dataList.category,
      "price": dataList.price,
      "image": dataList.image,
      "id":dataList.id
    });
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> cartReadData()
  {
    return firestore.collection("SaveCart").snapshots();

  }

  void cartDeleteProduct(String id)
  {
   firestore.collection('SaveCart').doc(id).delete();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> createAcoountWithEmailPass(
      {required String email, required String password})
  async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Success";
    }catch(e)
    {
      return "$e";
    }
  }

  Future<String> signInAcoountWithEmailPass(
      {required String email, required String password})
  async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    }catch(e)
    {
      return "$e";
    }
  }

  Future<String> signInWithAnonymously() async {
    try {
      await auth.signInAnonymously();
      return "Success";
    } catch (e) {
      return "$e";
    }
  }

  Future<String> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser
          ?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return 'Success';
    }catch(e)
    {
      return '$e';
    }
  }
}
