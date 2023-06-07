import 'package:admin/const/colors.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator({c=purpleColor}) {
  return  CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(c),
  );
}
