import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:admin/const/const.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;
  var profileImgPath = "".obs;
  var nameController = TextEditingController();
 
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var profileImageLink = "";
  var isLoading = false.obs;

  /////
  ///restaurant controllers
  var restaurantNameController = TextEditingController();
  var restaurantAddressController = TextEditingController();
  var restaurantMobileController = TextEditingController();
  var restaurantDescriptionController = TextEditingController();

  //change img
  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
      update();
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  //upload

  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password}) {
    var store =
        firestore.collection(restaurantCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      //  'image_url': imgUrl,
    }, SetOptions(merge: true));
    isLoading(false);
  }

  // change password
  changeAuthPassword({email, password, newPassword}) async {
    final cred =
        EmailAuthProvider.credential(email: email!, password: password!);
    await auth.currentUser!.reauthenticateWithCredential(cred);
    await auth.currentUser!.updatePassword(newPassword!);
    await auth.signOut();
  }

  updateRestaurant({name, address, mobile, desc}) async {
    var store =
        firestore.collection(restaurantCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'address': address,
      'mobile': mobile,
      "desc": desc,
      //  'image_url': imgUrl,
    }, SetOptions(merge: true));
    isLoading(false);
  }
}
