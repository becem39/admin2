import 'package:admin/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantServices {
  static getProfile(uid) {
    return firestore
        .collection("Restaurants")
        .where("id", isEqualTo: uid)
        .get();
  }

  static getOrder() {
    return firestore.collection(ordersCollection).snapshots();
    //.where('restaurant_list', arrayContains: currentUser!.uid)
  }

  static getProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  static getCategories() {
    return firestore.collection("categories").snapshots();
  }

  static getSubCategories(categoryId) {
    return firestore.collection("categories").doc(categoryId).snapshots();
  }

  static getStaff() {
    return firestore.collection("staff").snapshots();
  }

  ////////////////
  ///
  ///
  static Future<DocumentReference> addStaff(
      Map<String, dynamic> staffData) async {
    CollectionReference staffCollection = firestore.collection('staff');
    DocumentReference staffRef = await staffCollection.add(staffData);
    return staffRef;
  }

  // Store staff member data using the UID
  static Future<void> storeStaffData(Map<String, dynamic> staffData) async {
    CollectionReference staffDataCollection =
        firestore.collection('staff_data');
    await staffDataCollection.doc(staffData['id']).set(staffData);
  }

  /*static Future<void> removeStaffByName(String staffName) async {
    CollectionReference staffCollection = firestore.collection('staff');
    QuerySnapshot snapshot =
        await staffCollection.where('name', isEqualTo: staffName).get();
    List<DocumentSnapshot> documents = snapshot.docs;

    if (documents.isNotEmpty) {
      for (DocumentSnapshot document in documents) {
        await document.reference.delete();
      }
    }
  }*/
  static Future<void> removeStaffById(String staffId) async {
    try {
      await FirebaseFirestore.instance
          .collection('staff')
          .doc(staffId)
          .delete();
    // ignore: empty_catches
    } catch (e) {
    }
  }
}
