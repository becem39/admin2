import 'package:admin/const/const.dart';
import 'package:admin/controllers/product_controller.dart';
import 'package:admin/services/firestore_services.dart';
import 'package:admin/services/restaurant_services.dart';
import 'package:admin/views/products_screen/add_product.dart';
import 'package:admin/views/products_screen/product_details.dart';
import 'package:admin/views/widgets/custom_appBar.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../widgets/loading_indicator.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            controller.populateCategory();

            Get.to(() => AddProduct());
          },
          backgroundColor: purpleColor,
          child: const Icon(Icons.add),
        ),
        appBar: customAppBar(products),
        body: StreamBuilder(
            stream: RestaurantServices.getProducts(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                          data.length,
                          (index) => Card(
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetails(
                                          data: data[index],
                                        ));
                                  },
                                  leading: Image.network(
                                    data[index]['p_images'][0],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: "${data[index]['p_name']}",
                                      color: fontGrey),
                                  subtitle: Row(
                                    children: [
                                      normalText(
                                          text: "${data[index]['p_price']} TND",
                                          color: darkGrey),
                                      10.widthBox,
                                      data[index]['is_featured']
                                          ? boldText(
                                              text: "Featured", color: green)
                                          : boldText(text: "", color: green),
                                    ],
                                  ),
                                  trailing: VxPopupMenu(
                                      arrowSize: 0.0,
                                      child:
                                          const Icon(Icons.more_vert_rounded),
                                      menuBuilder: () => Column(
                                            children: List.generate(
                                              popupMenuIcons.length,
                                              (i) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      popupMenuIcons[i],
                                                      color: data[index]
                                                              ['is_featured']
                                                          ? green
                                                          : darkGrey,
                                                    ),
                                                    10.heightBox,
                                                    normalText(
                                                        text: data[index]
                                                                ['is_featured']
                                                            ? "Remove feature"
                                                            : popupMenuTiles[i],
                                                        color: darkGrey),
                                                  ],
                                                ).onTap(() {
                                                  if (data[index]
                                                      ['is_featured']) {
                                                    print('eeeee');
                                                    controller.removeFeature(
                                                        data[index].id);
                                                  } else {
                                                    controller.addFeature(
                                                        data[index].id);
                                                  }
                                                }),
                                              ),
                                            ),
                                          ).box.white.rounded.width(200).make(),
                                      clickType: VxClickType.singleClick),
                                ),
                              )),
                    ),
                  ),
                );
              }
            }));
  }
}
