import 'package:admin/const/const.dart';
import 'package:admin/controllers/auth_controller.dart' as admin;
import 'package:admin/views/home_screen/home.dart';
import 'package:admin/views/widgets/app_button.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';

import '../widgets/loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(admin.AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                30.heightBox,
                normalText(text: welcome, size: 18),
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      icLogo,
                      width: 300,
                      height: 200,
                    )
                        .box
                        .border(color: white)
                        .rounded
                        .padding(const EdgeInsets.all(8))
                        .make(),
                    30.heightBox,
                  ],
                ),
                20.heightBox,
                Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          hintText: emailHint,
                          fillColor: textfieldGrey,
                          // filled: true,
                          prefixIcon: Icon(
                            Icons.email,
                            color: purpleColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      10.heightBox,
                      TextFormField(
                        controller: controller.passwordController,
                        decoration: const InputDecoration(
                          hintText: passwordHint,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: purpleColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      30.heightBox,
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: normalText(
                                  text: forgotPassword, color: purpleColor))),
                      SizedBox(
                          width: context.screenWidth - 100,
                          child: controller.isLoading.value
                              ? loadingIndicator()
                              : appButton(
                                  title: login,
                                  onPress: () async {
                                    controller.isLoading(true);
                                    await controller
                                        .loginMethod(context: context)
                                        .then((value) {
                                      if (value != null) {
                                        VxToast.show(context, msg: "Logged in");
                                        controller.isLoading(false);
                                        Get.offAll(() => const Home());
                                      } else {
                                        controller.isLoading(false);
                                      }
                                    });
                                  })),
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .outerShadowMd
                      .padding(const EdgeInsets.all(8))
                      .make(),
                ),
                10.heightBox,
                Center(
                  child: normalText(text: anyProblem),
                ),
                const Spacer(),
                Center(
                  child: boldText(text: credit),
                ),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
