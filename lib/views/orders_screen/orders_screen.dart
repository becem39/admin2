import 'package:admin/const/const.dart';
import 'package:admin/controllers/order_controller.dart';
import 'package:admin/services/restaurant_services.dart';
import 'package:admin/views/orders_screen/order_details.dart';
import 'package:admin/views/widgets/custom_appBar.dart';
import 'package:admin/views/widgets/loading_indicator.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: customAppBar(orders),
      body: StreamBuilder(
        stream: RestaurantServices.getOrder(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var time = data[index]["order_date"]?.toDate();
                    return ListTile(
                      onTap: () {
                        Get.to(() => OrderDetails(
                              data: data[index],
                            ));
                      },
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                          text: "${data[index]['order_code']}",
                          color: purpleColor),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: fontGrey,
                              ),
                              if (time != null)
                                boldText(
                                  text: intl.DateFormat()
                                      .add_yMd()
                                      .add_jms()
                                      .format(time),
                                  color: fontGrey,
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              data[index]['order_delivered']
                                  ? boldText(text: 'Deliverd', color: green)
                                  : boldText(text: 'processing', color: red),
                            ],
                          ),
                        ],
                      ),
                      trailing: boldText(
                          text: "${data[index]['total_amount']} TND",
                          color: darkGrey),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
