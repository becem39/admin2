import 'package:admin/const/const.dart';

Widget normalText({text, color = Colors.white,size=14}) {
  return "$text".text.size(size).color(color).make();
}

Widget boldText({text, color = Colors.white, size=14}) {
  return "$text".text.semiBold.size(size).color(color).make();
}
