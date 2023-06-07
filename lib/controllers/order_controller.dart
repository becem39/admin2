import 'package:admin/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  var orders = [];
  var ondelivery = false.obs;
  var confirmed = false.obs;
  var deliverd = false.obs;
  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      orders.add(item);
      /* if (item['restaurant_id'] == currentUser!.uid) {
        orders.add(item);
      }*/
    }
  }

  changeStatus({title, status, docId}) async {
    var store = firestore.collection(ordersCollection).doc(docId);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
