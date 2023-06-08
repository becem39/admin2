import 'package:admin/const/const.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  var navIndex = 0.obs;
   var ordersCount = 0.obs;

  Future<int> getOrdersCollectionLength() async {
    final querySnapshot = await firestore.collection(ordersCollection).get();
    return querySnapshot.docs.length;
  }

  Future<void> fetchOrdersCount() async {
     ordersCount.value = await getOrdersCollectionLength();
  
  }

  @override
  void onInit() {
    fetchOrdersCount();
    super.onInit();
  }
}
