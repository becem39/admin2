import 'dart:io';

import 'package:admin/const/const.dart';
import 'package:admin/controllers/product_controller.dart';
import 'package:admin/views/products_screen/components/product_dropdown.dart';
import 'package:admin/views/products_screen/components/product_images.dart';
import 'package:admin/views/widgets/custom_textfield.dart';
import 'package:admin/views/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../widgets/normal_text.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsController());

    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: white,
              )),
          title: boldText(text: "Add product", color: white, size: 16),
          actions: [
            controller.isLoading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadProduc(context);
                      Get.back();
                    },
                    child: boldText(text: "Save", color: white))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "Name",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "100 TND",
                    label: "Price",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    hint: "Quantity",
                    label: "Quantity",
                    controller: controller.pquantityController),
                10.heightBox,
                /* customTextField(
                    hint: "img",
                    label: "ImgUrl",
                    controller: controller.pimgController),
                10.heightBox,*/
                productDropdown(
                  "Category",
                  controller.categoryList,
                  controller.categoryValue,
                  controller,
                ),
                10.heightBox,
                productDropdown(
                  "subCategory",
                  controller.subCategoryList,
                  controller.subCategoryValue,
                  controller,
                ),
                10.heightBox,
                const Divider(
                  color: white,
                ),
                boldText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => index < controller.pImagesList.length &&
                              controller.pImagesList[index] != null
                          ? Image.file(
                              controller.pImagesList[index] as File,
                              width: 100,
                            )
                          : productImages(label: "${index + 1}").onTap(() {
                              print(controller.pImagesList);
                              controller.pickImage(index);
                            }),
                    ),
                  ),
                ),
                10.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: lightGrey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
