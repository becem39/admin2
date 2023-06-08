import 'package:admin/const/const.dart';
import 'package:admin/controllers/home_controller.dart';
import 'package:admin/views/products_screen/product_details.dart';
import 'package:admin/views/widgets/custom_appBar.dart';
import 'package:admin/views/widgets/dashboard_button.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../services/restaurant_services.dart';
import '../widgets/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
        appBar: customAppBar(dashboard),
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: RestaurantServices.getProducts(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return loadingIndicator();
                } else {
                  var data = snapshot.data!.docs;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(context,
                                title: products,
                                count: data.length,
                                icon: icProducts),
                            dashboardButton(context,
                                title: orders,
                                count: controller.ordersCount,
                                icon: icOrders),
                          ],
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(context,
                                title: "Staff", count: "5", icon: icStar),
                            dashboardButton(context,
                                title: "Tables", count: "15", icon: icOrders),
                          ],
                        ),
                        10.heightBox,
                        const Divider(),
                        boldText(text: "Popular products", color: fontGrey),
                        10.heightBox,
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              data.length,
                              (index) => data[index]['p_wishlist'].length == 0
                                  ? const SizedBox()
                                  : ListTile(
                                      leading: Image.network(
                                        data[index]['p_images'][0],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      onTap: () {
                                        Get.to(() =>
                                            ProductDetails(data: data[index]));
                                      },
                                      title: boldText(
                                          text: data[index]['p_name'],
                                          color: darkGrey),
                                      subtitle: normalText(
                                          text: "${data[index]['p_price']} TND",
                                          color: fontGrey),
                                    )),
                        )
                      ],
                    ),
                  );
                }
              }),
        ));
  }
}
