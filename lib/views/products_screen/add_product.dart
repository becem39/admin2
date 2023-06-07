import 'package:admin/const/const.dart';
import 'package:admin/controllers/product_controller.dart';
import 'package:admin/views/products_screen/components/product_dropdown.dart';
import 'package:admin/views/products_screen/components/product_images.dart';
import 'package:admin/views/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../widgets/normal_text.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Scaffold(
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
          TextButton(
              onPressed: () {}, child: boldText(text: "Save", color: white))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField(hint: "Name", label: "Product name"),
              10.heightBox,
              customTextField(hint: "100 TND", label: "Price"),
              10.heightBox,
              customTextField(hint: "Quantity", label: "Quantity"),
              10.heightBox,
              customTextField(hint: "Name", label: "Product name"),
              10.heightBox,
              productDropdown("Category"),
              10.heightBox,
              productDropdown("SubCategory"),
              10.heightBox,
              const Divider(
                color: white,
              ),
              boldText(text: "Choose product images"),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  3,
                  (index) => productImages(label: "${index + 1}"),
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
    );
  }
}
