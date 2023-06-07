import 'package:admin/const/const.dart';
import 'package:get/get.dart';

import '../models/category_model.dart';

class ProductsController extends GetxController {
//name,price,quantity,cat,subcat,picsx3,
  var pnameController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();
  var categoryList = [].obs;
  var subCategoryList = [].obs;
  var pImagesList = [].obs;
  List<Category> category = [];

  var categoryValue = ''.obs;
  var subCategoryValue = ''.obs;
 
}
