import 'package:admin/const/const.dart';
import 'package:admin/controllers/profile_controller.dart';
import 'package:admin/views/widgets/custom_textfield.dart';
import 'package:admin/views/widgets/loading_indicator.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../widgets/normal_text.dart';

class ManageStaff extends StatefulWidget {
  final String? userName;
  const ManageStaff({super.key, this.userName});

  @override
  createState() => _ManageStaffState();
}

class _ManageStaffState extends State<ManageStaff> {
  late ProfileController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<ProfileController>();
    if (widget.userName != null) {
      controller.nameController.text = widget.userName!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          backgroundColor: purpleColor,
          title: boldText(text: "Manage menus", size: 16, color: white),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(c: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);

                      //if old pass matches db
                      if (controller.snapshotData['password'] ==
                          controller.oldPasswordController.text) {
                        await controller.changeAuthPassword(
                          email: controller.snapshotData['email'],
                          password: controller.oldPasswordController.text,
                          newPassword: controller.newPasswordController,
                        );
                        await controller.updateProfile(
                          name: controller.nameController.text,
                          password: controller.newPasswordController.text,
                          /*  imgUrl: controller.profileImageLink,*/
                        );
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "updated");
                      } else if (controller
                              .oldPasswordController.text.isEmpty &&
                          controller.newPasswordController.text.isEmpty) {
                        await controller.updateProfile(
                          name: controller.nameController.text,
                          password: controller.snapshotData['password'],
                          /* imgUrl: controller.profileImageLink,*/
                        );
                        // ignore: use_build_context_synchronously

                        VxToast.show(context, msg: "updated2");
                      } else {
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Wrong old password");
                        controller.isLoading(false);
                      }
                    },
                    child: normalText(text: "Save", color: white)),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            controller.snapshotData["image_url"].isEmpty &&
                    controller.profileImgPath.isEmpty
                ? Image.asset(
                    icLogo,
                    height: 200,
                    width: 200,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : controller.snapshotData["image_url"] !=
                        controller.profileImgPath.isEmpty
                    ? Image.network(
                        controller.snapshotData["image_url"],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),

            /*  Image.asset(
                icLogo,
                height: 200,
                width: 200,
              ).box.roundedFull.clip(Clip.antiAlias).make(),*/
            10.heightBox,
            /*  ElevatedButton(
                  onPressed: () {
                    controller.changeImage(context);
                  },
                  child: normalText(text: "Change Logo", color: fontGrey)),*/
            10.heightBox,
            const Divider(
              color: white,
            ),
            10.heightBox,
            customTextField(
                label: name,
                hint: "Restaurant name",
                controller: controller.nameController),
            10.heightBox,
            customTextField(
                label: password,
                hint: passwordHint,
                controller: controller.oldPasswordController),
            10.heightBox,
            customTextField(
                label: "New password",
                hint: passwordHint,
                controller: controller.newPasswordController),
            10.heightBox,
          ],
        ),
      ),
    );
  }
}
