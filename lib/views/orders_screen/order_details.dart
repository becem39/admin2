import 'package:admin/const/const.dart';
import 'package:admin/views/widgets/app_button.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';

import 'components/order_place_details.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: SizedBox(
        height: 60,
        width: context.screenWidth,
        child: appButton(color: green, onPress: () {}, title: "Confirm order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
//order status

              Column(
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
                    value: true,
                    onChanged: (value) {},
                    title: boldText(text: "Confirmed", color: fontGrey),
                  ),
                  SwitchListTile(
                    activeColor: green,
                    value: false,
                    onChanged: (value) {},
                    title: boldText(text: "On loacation", color: fontGrey),
                  ),
                  SwitchListTile(
                    activeColor: green,
                    value: false,
                    onChanged: (value) {},
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

//order details
              Column(
                children: [
                  orderPlaceDetails(
                      data1: "data['order_code']", title1: 'order code'),
                  orderPlaceDetails(title1: "Order date ", data1: DateTime.now()
                      /* data1: intl.DateFormat()
                          .add_yMd()
                          .add_jms()
                          .format((data['order_date'].toDate()))),*/
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
                            "User : {data['order_by_name']}".text.make(),
                            "email : {data['order_by_email']}".text.make(),
                            "address : {data['order_by_address']}".text.make(),
                            "state : {data['order_by_state']}".text.make(),
                            "city : {data['order_by_city']}".text.make(),
                            "phone : {data['order_by_phone']}".text.make(),
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
                              "{data['total_amount']} TND"
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
                children: List.generate(3, (index) {
                  return Column(
                    children: [
                      orderPlaceDetails(
                        title1: "data['orders'][index]['title']",
                        data1: "data['orders'][index]['quantity']",
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
    );
  }
}
