import 'package:admin/const/const.dart';
import 'package:admin/controllers/auth_controller.dart';
import 'package:admin/controllers/profile_controller.dart';
import 'package:admin/services/restaurant_services.dart';
import 'package:admin/views/auth_screen/login_screen.dart';
import 'package:admin/views/profile_screen/edit_profile_screen.dart';
import 'package:admin/views/profile_screen/manage_menus.dart';
import 'package:admin/views/profile_screen/manage_staff.dart';
import 'package:admin/views/restaurant_screen/restaurant_settings_screen.dart';
import 'package:admin/views/widgets/loading_indicator.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: settings, size: 16),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditProfileScreen(
                        userName: controller.snapshotData['name'],
                      ));
                },
                icon: const Icon(Icons.edit)),
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>().signOutMethod(context);
                  await auth.signOut();
                  Get.offAll(() => const LoginScreen());
                },
                child: normalText(text: logout)),
          ],
        ),
        body: FutureBuilder(
            future: RestaurantServices.getProfile(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator(c: white);
              } else {
                controller.snapshotData = snapshot.data!.docs[0];
                return Column(
                  children: [
                    ListTile(
                      leading: Image.asset(icLogo)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
                      title:
                          boldText(text: "${controller.snapshotData["name"]}"),
                      subtitle: normalText(
                          text: "${controller.snapshotData["email"]}"),
                    ),
                    const Divider(),
                    10.heightBox,
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: List.generate(
                            profileButtonIcons.length,
                            (index) => ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => RestaurantSettings());
                                        break;
                                      case 1:
                                        Get.to(() => ManageMenus());
                                        break;
                                      case 2:
                                        Get.to(() => ManageStaff());
                                        break;
                                    }
                                  },
                                  leading: Icon(
                                    profileButtonIcons[index],
                                    color: white,
                                  ),
                                  title: normalText(
                                      text: profileButtonList[index]),
                                )),
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
