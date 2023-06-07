import 'package:admin/views/widgets/normal_text.dart';

import '../../../const/const.dart';

Widget productDropdown(title) {
  return DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      hint: normalText(text: "Choose $title", color: fontGrey),
      value: null,
      isExpanded: true,
      onChanged: (value) {},
      items: [],
    ),
  )
      .box
      .white
      .padding(const EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .make();
}
