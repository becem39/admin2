import 'package:admin/const/const.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:flutter/widgets.dart';


Widget orderPlaceDetails({title1, data1}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    child: Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boldText(text: title1,color: fontGrey),
            boldText(text: data1,color: red),]
        ),
      ],
    ),
  );
}
