import 'package:admin/const/const.dart';
import 'package:admin/views/widgets/custom_textfield.dart';
import 'package:admin/views/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';
import '../widgets/normal_text.dart';

class RestaurantSettings extends StatelessWidget {
  const RestaurantSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          backgroundColor: purpleColor,
          title: boldText(text: editProfile, size: 16, color: white),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(c: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateRestaurant(
                          name: controller.restaurantNameController.text,
                          address: controller.restaurantAddressController.text,
                          mobile: controller.restaurantMobileController.text,
                          desc:
                              controller.restaurantDescriptionController.text);
                      VxToast.show(context, msg: "Updated");
                    },
                    child: normalText(text: "Save", color: white)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              customTextField(
                  label: name,
                  hint: nameHint,
                  controller: controller.restaurantNameController),
              10.heightBox,
              customTextField(
                  label: address,
                  hint: addressHint,
                  controller: controller.restaurantAddressController),
              10.heightBox,
              customTextField(
                  label: mobile,
                  hint: "12345678",
                  controller: controller.restaurantMobileController),
              10.heightBox,
              customTextField(
                  label: description,
                  hint: descriptionHint,
                  isDesc: true,
                  controller: controller.restaurantDescriptionController),
              10.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
