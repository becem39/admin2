import 'package:admin/const/const.dart';
import 'package:admin/views/products_screen/add_product.dart';
import 'package:admin/views/products_screen/product_details.dart';
import 'package:admin/views/widgets/custom_appBar.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddProduct());
        },
        backgroundColor: purpleColor,
        child: const Icon(Icons.add),
      ),
      appBar: customAppBar(products),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
                20,
                (index) => Card(
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ProductDetails());
                        },
                        leading: Image.asset(
                          imgProduct,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: boldText(text: "Product title", color: fontGrey),
                        subtitle: Row(
                          children: [
                            normalText(text: "\$40.0 TND", color: darkGrey),
                            10.widthBox,
                            boldText(text: "Featured", color: green),
                          ],
                        ),
                        trailing: VxPopupMenu(
                            arrowSize: 0.0,
                            child: const Icon(Icons.more_vert_rounded),
                            menuBuilder: () => Column(
                                  children: List.generate(
                                    popupMenuIcons.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(popupMenuIcons[index]),
                                          10.heightBox,
                                          normalText(
                                              text: popupMenuTiles[index],
                                              color: darkGrey),
                                        ],
                                      ).onTap(() {}),
                                    ),
                                  ),
                                ).box.white.rounded.width(200).make(),
                            clickType: VxClickType.singleClick),
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
