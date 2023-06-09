import 'package:admin/views/home_screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import '../const/const.dart';
import '../services/restaurant_services.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

//text controllers !

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Restaurants')
          .doc("JVp1fdovf5bTZrsqmq5l59G8pEp1")
          .get();
      if (snapshot.exists) {
        String role = snapshot['role'];
        if (role == 'admin') {
          Get.to(const Home());
        } else {
          VxToast.show(context, msg: "Invalid credentials");
        }
      }
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup !
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method

  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'role': 'client',
      'id': currentUser!.uid,
      'cart_count': '00',
      'wishlist_count': '00',
      'order_count': '00',
    });
  }

  Future<void> storeStaffData({
    required String id,
    required String name,
    required String email,
    required String password,
  }) async {
    var staffData = {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };

    // Store the staff member data in the database
    RestaurantServices.storeStaffData(staffData);
  }
  //signout

  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
