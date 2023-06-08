import 'package:admin/const/const.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

AppBar customAppBar(title) {
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    leading:  IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: purpleColor,
        )),
    title: boldText(
      text: title,
      color: darkGrey,
      size: 16,
    ),
    actions: [
      Center(
        child: normalText(
            text: intl.DateFormat('EEE, MMM d, ' ' yy').format(DateTime.now()),
            color: purpleColor),
      ),
      10.widthBox,
    ],
  );
}
