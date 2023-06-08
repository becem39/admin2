import 'package:admin/controllers/product_controller.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import '../../../const/const.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductsController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: normalText(text: hint, color: fontGrey),
        value: dropvalue.value == '' ? null : dropvalue.value,
        isExpanded: true,
        onChanged: (value) {
          if (hint == "Category") {
            controller.subCategoryValue.value = '';
            controller.populateSubCategory(value.toString());
          }
          dropvalue.value = value.toString();
        },
        items: list.map((e) {
          return DropdownMenuItem<String>(
            value: e,
            child: e.text.make(),
          );
        }).toList(),
      ),
    )
        .box
        .white
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .roundedSM
        .make(),
  );
}
