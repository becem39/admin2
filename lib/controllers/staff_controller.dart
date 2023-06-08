import 'package:admin/const/const.dart';
import 'package:admin/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../services/restaurant_services.dart';

class StaffController extends GetxController {
  var password = TextEditingController();
  var email = TextEditingController();
 
  var newStaff = TextEditingController();
  Future<String> addStaff(name,code) async {
 /*  firestore.collection("staff").doc().set(
        {'name': newStaff.text}, SetOptions(merge: true));*/
  var staff = {
      'name': name,
      'order_count':'00',
      "password":code,
    };
   
         DocumentReference staffRef = await RestaurantServices.addStaff(staff);
    String uid = staffRef.id;

    return uid;
  }



 
}
