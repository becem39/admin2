import 'package:admin/const/const.dart';
import 'package:admin/services/firestore_services.dart';
import 'package:get/get.dart';

import '../models/category_model.dart';

class ProductsController extends GetxController {
//name,price,quantity,cat,subcat,picsx3,
  var pnameController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();
  var categoryList = <String>[].obs;
// FirestoreServices.getCategories();
  var subCategoryList = <String>[].obs;
  var pImagesList = [].obs;
  List<Category> category = [];

  var categoryValue = ''.obs;
  var subCategoryValue = ''.obs;

 Future<List<String>> populateCategory() async {
    categoryList.clear();
    List<String> categories = await FirestoreServices.getCategories() ?? [];
    categoryList.addAll(categories);
    return categories;
  }
Future<List<String>> populateSubCategory(String category) async {
    subCategoryList.clear();
    List<String> subCategories =
        await FirestoreServices.getSubCategories(category) ?? [];
    subCategoryList.addAll(subCategories);
    subCategoryValue.value = ''; // Clear the selected subcategory value
    return subCategories;
  }


  /* Future<void> populateCategory() async {
    try {
      List<String> categories = await FirestoreServices.getCategories();
      categoryList.assignAll(categories);
    } catch (error) {
      print('Error retrieving categories: $error');
    }
  }

  Future<void> populateSubCategory(String category) async {
    try {
      List<String> subCategories =
          await FirestoreServices.getSubCategories(category);
      subCategoryList.value = subCategories;
      // subCategoryList.assignAll(subCategories);
    } catch (error) {
      print('Error retrieving subcategories: $error');
    }
  }*/
}



/*    var categoryList = [].obs;
  var subCategoryList = [].obs;
  var pImagesList = [].obs;
  List<Category> category = [];

  var categoryValue = ''.obs;
  var subCategoryValue = ''.obs;
*/