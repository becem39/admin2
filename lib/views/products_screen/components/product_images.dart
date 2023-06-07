import 'package:admin/const/const.dart';
import 'package:admin/views/widgets/normal_text.dart';

Widget productImages({required label, onPress}) {
  return "$label"
      .text
      .bold
      .color(fontGrey)
      .size(16)
      .makeCentered()
      .box
      .color(lightGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
