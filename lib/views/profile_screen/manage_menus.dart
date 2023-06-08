import 'package:admin/const/const.dart';
import 'package:admin/controllers/edit_controller.dart';
import 'package:admin/controllers/product_controller.dart';
import 'package:admin/views/products_screen/components/product_dropdown.dart';
import 'package:admin/views/profile_screen/manage_subCategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../services/restaurant_services.dart';
import '../widgets/custom_appBar.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/normal_text.dart';

class ManageMenus extends StatelessWidget {
  const ManageMenus({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(EditController());
    return Scaffold(
      appBar: customAppBar("Caregories"),
      body: StreamBuilder(
        stream: RestaurantServices.getCategories(),
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
                    return ListTile(
                      onTap: () {
                        Get.to(() => ManageSubcategories(
                              data: data[index],
                              categoryId: data[index].id,
                              subCategories: List<String>.from(
                                  data[index]['subCategories']),
                            ));
                      },
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                          text: "${data[index]['name']}", color: purpleColor),
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
                                            text: "${data[index]['name']}",
                                            color: purpleColor),
                                        10.heightBox,
                                        customTextField(
                                            hint: "${data[index]['name']}",
                                            label: "Category name",
                                            controller:
                                                controller.categoryController),
                                        10.heightBox,
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextButton(
                                            onPressed: () {
                                              controller.updateCategory(
                                                  data[index].id);
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
                                              controller.removeCategory(
                                                  data[index].id);
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
                            text: "Add a new category", color: purpleColor),
                        10.heightBox,
                        customTextField(
                            hint: "category",
                            label: "Category name",
                            controller: controller.newcat),
                        10.heightBox,
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              controller.addCategory();
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
/*
                          */





                          /*

                          TextButton(
                        onPressed: () {
                          controller.removeCategory(data[index].id);
                        },
                        child: normalText(text: "Delete"),
                      ),   
                          */