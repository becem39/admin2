import 'package:admin/const/const.dart';
import 'package:admin/views/products_screen/product_details.dart';
import 'package:admin/views/widgets/custom_appBar.dart';
import 'package:admin/views/widgets/dashboard_button.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(dashboard),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context,
                    title: products, count: "60", icon: icProducts),
                dashboardButton(context,
                    title: orders, count: "15", icon: icOrders),
              ],
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context,
                    title: rating, count: "60", icon: icStar),
                dashboardButton(context,
                    title: totalSales, count: "15", icon: icOrders),
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
                  3,
                  (index) => ListTile(
                        leading: Image.asset(
                          imgProduct,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          Get.to(() => ProductDetails());
                        },
                        title: boldText(text: "Product name", color: darkGrey),
                        subtitle: normalText(text: "4 tnd", color: fontGrey),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
