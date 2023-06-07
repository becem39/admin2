import 'package:admin/const/const.dart';

import 'normal_text.dart';

Widget dashboardButton(context, {title, count,icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            boldText(text: title, size: 16),
            boldText(text: count, size: 20),
          ],
        ),
      ),
      Image.asset(
        icon,
        width: 40,
        color: white,
      ),
    ],
  )  .box
          .color(purpleColor)
          .rounded
          .size(size.width * 0.4, 80)
          .padding(const EdgeInsets.all(8))
          .make();
}
