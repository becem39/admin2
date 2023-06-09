import 'package:admin/const/const.dart';
import 'package:admin/controllers/order_controller.dart';
import 'package:admin/views/widgets/app_button.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import 'components/order_place_details.dart';

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();
  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['on_delivery'];
    controller.deliverd.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: darkGrey,
              )),
          title: boldText(text: "Order details", color: fontGrey, size: 16),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: appButton(
                color: green,
                onPress: () {
                  controller.confirmed(true);
                  controller.changeStatus(
                      title: "order_confirmed",
                      status: true,
                      docId: widget.data.id);
                },
                title: "Confirm order"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //order status

                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(text: 'Order status', color: fontGrey, size: 16),
                      SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Placed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.ondelivery.value,
                        onChanged: (value) {
                          controller.ondelivery.value = value;
                          controller.changeStatus(
                              title: "on_delivery",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "On Delivery", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.deliverd.value,
                        onChanged: (value) {
                          controller.deliverd.value = value;
                          controller.changeStatus(
                              title: "order_delivered",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "Delivered", color: fontGrey),
                      ),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(8))
                      .outerShadowSm
                      .white
                      .border(color: lightGrey)
                      .roundedSM
                      .make(),
                ),

                //order details
                Column(
                  children: [
                    orderPlaceDetails(
                        data1: "${widget.data['order_code']}",
                        title1: 'order code'),
                    orderPlaceDetails(
                      title1: "Order date ",
                      data1: intl.DateFormat().add_yMd().format(
                            (widget.data['order_date'].toDate()),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              boldText(
                                  text: "Shipping address", color: purpleColor),
                              "User : ${widget.data['order_by_name']}"
                                  .text
                                  .make(),
                              "email : ${widget.data['order_by_email']}"
                                  .text
                                  .make(),
                              "address : ${widget.data['order_by_address']}"
                                  .text
                                  .make(),
                              "state : ${widget.data['order_by_state']}"
                                  .text
                                  .make(),
                              "city : ${widget.data['order_by_city']}"
                                  .text
                                  .make(),
                              "phone : ${widget.data['order_by_phone']}"
                                  .text
                                  .make(),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Total amount", color: purpleColor),
                                "${widget.data['total_amount']} TND"
                                    .text
                                    .color(red)
                                    .make(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
                const Divider(),
                10.heightBox,
                boldText(text: "Order products", color: purpleColor),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Image.network(
                                  controller.orders[index]['img']),
                            ),
                            orderPlaceDetails(
                              title1: controller.orders[index]['title'],
                              data1: controller.orders[index]['quantity'],
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .shadowMd
                    .margin(const EdgeInsets.only(bottom: 4))
                    .white
                    .make(),
                10.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
