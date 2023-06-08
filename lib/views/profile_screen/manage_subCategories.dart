import 'package:admin/const/const.dart';
import 'package:admin/controllers/edit_controller.dart';
import 'package:admin/controllers/product_controller.dart';
import 'package:admin/views/products_screen/components/product_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../services/restaurant_services.dart';
import '../widgets/custom_appBar.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/normal_text.dart';

class ManageSubcategories extends StatelessWidget {
  final String categoryId;
  final List<String> subCategories;
  final dynamic data;
  const ManageSubcategories(
      {super.key,
      this.data,
      required this.categoryId,
      required this.subCategories});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(EditController());
    return Scaffold(
      appBar: customAppBar("SubCaregories"),
      body: StreamBuilder(
        stream: RestaurantServices.getCategories(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children:
                      List.generate(data['subCategories'].length, (index) {
                    return ListTile(
                      onTap: () {},
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                          text: "${data['subCategories'][index]}",
                          color: purpleColor),
                      trailing: TextButton(
                        child: normalText(text: "Edit"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Container(
                                    height: 200,
                                    width: 450,
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        boldText(
                                            text:
                                                "${data['subCategories'][index]}",
                                            color: purpleColor),
                                        10.heightBox,
                                        customTextField(
                                            hint:
                                                "${data['subCategories'][index]}",
                                            label: "Category name",
                                            controller: controller
                                                .subCategoryController),
                                        10.heightBox,
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextButton(
                                            onPressed: () {
                                              controller.updateSubCategory(
                                                  categoryId,
                                                  "${data['subCategories'][index]}",
                                                  controller
                                                      .subCategoryController
                                                      .text);
                                              Navigator.pop(context);
                                            },
                                            child: normalText(
                                                text: "Update",
                                                color: purpleColor),
                                          ),
                                        ),
                                        10.heightBox,
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextButton(
                                            onPressed: () {
                                              controller.removeSubCategory(
                                                  categoryId,
                                                  "${data['subCategories'][index]}");
                                              Navigator.pop(context);
                                            },
                                            child: normalText(
                                                text: "Delete",
                                                color: purpleColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                  }),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    height: 200,
                    width: 450,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        boldText(
                            text: "Add a new sub category", color: purpleColor),
                        10.heightBox,
                        customTextField(
                            hint: "SubCategory",
                            label: "subCategory name",
                            controller: controller.newsubcat),
                        10.heightBox,
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              controller.addSubCategory(categoryId);
                              Navigator.pop(context);
                            },
                            child: normalText(text: "Add", color: purpleColor),
                          ),
                        ),
                        10.heightBox,
                      ],
                    ),
                  ),
                );
              });
        },
        backgroundColor: purpleColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
