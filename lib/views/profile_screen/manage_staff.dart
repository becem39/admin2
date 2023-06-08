import 'package:admin/const/const.dart';
import 'package:admin/controllers/auth_controller.dart';
import 'package:admin/controllers/edit_controller.dart';
import 'package:admin/controllers/product_controller.dart';
import 'package:admin/controllers/staff_controller.dart';
import 'package:admin/views/products_screen/components/product_dropdown.dart';
import 'package:admin/views/profile_screen/manage_subCategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../services/restaurant_services.dart';
import '../widgets/custom_appBar.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/normal_text.dart';

class ManageStaff extends StatelessWidget {
  const ManageStaff({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(StaffController());
    var auth = Get.put(AuthController());
    return Scaffold(
      appBar: customAppBar("Staff"),
      body: StreamBuilder(
        stream: RestaurantServices.getStaff(),
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
                      onTap: () {},
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                          text: "${data[index]['name']}", color: purpleColor),
                      subtitle: boldText(
                          text:
                              "Total orders made :      ${data[index]['order_count']}",
                          color: purpleColor),
                      trailing: TextButton(
                        onPressed: () {
                          String staffId = data[index].id;

                          RestaurantServices.removeStaffById(staffId);
                        },
                        child: normalText(text: "Delete", color: purpleColor),
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
                  height: 300,
                  width: 450,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      boldText(
                        text: "Add a new Worker",
                        color: purpleColor,
                      ),
                      10.heightBox,
                      customTextField(
                        hint: "Worker",
                        label: "Worker name",
                        controller: controller.newStaff,
                      ),
                      10.heightBox,
                      customTextField(
                        hint: "Email",
                        label: "Worker email",
                        controller: controller.email,
                      ),
                      10.heightBox,
                      customTextField(
                        hint: "Password",
                        label: "Password",
                        controller: controller.password,
                      ),
                      10.heightBox,
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () async {
                            String workerName = controller.newStaff.text;
                            String code = controller.password.text;
                            String uid =
                                await controller.addStaff(workerName, code);

                            await auth
                                .signupMethod(
                              email: controller.email.text,
                              password: controller.password.text,
                              context: context,
                            )
                                .then((value) {
                              return auth.storeStaffData(
                                id: uid,
                                email: controller.email.text,
                                password: controller.password.text,
                                name: workerName,
                              );
                            });
                          },
                          child: normalText(text: "Add", color: purpleColor),
                        ),
                      ),
                      10.heightBox,
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: purpleColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
