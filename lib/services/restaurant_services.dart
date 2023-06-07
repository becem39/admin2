import 'package:admin/const/const.dart';

class RestaurantServices {
  static getProfile(uid) {
    return firestore
        .collection("Restaurants")
        .where("id", isEqualTo: uid)
        .get();
  }

  static getOrder() {
    return firestore
        .collection(ordersCollection)
        .where('restaurant_list', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getProducts() {
    return firestore.collection(productsCollection).snapshots();
  }
}
