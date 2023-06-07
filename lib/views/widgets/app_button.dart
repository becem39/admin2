import 'package:admin/const/const.dart';
import 'package:admin/views/widgets/normal_text.dart';

Widget appButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: normalText(text: title, size: 16));
}
