import 'package:admin/const/const.dart';
import 'package:admin/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../models/category_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ProductsController extends GetxController {
//name,price,quantity,cat,subcat,picsx3,
  var pnameController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();
  var pimgController = TextEditingController();
  var categoryList = <String>[].obs;
// FirestoreServices.getCategories();
  var subCategoryList = <String>[].obs;
  var isLoading = false.obs;

  var pImagesList = <Rx<File?>>[].obs;
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
    subCategoryValue.value = '';
    return subCategories;
  }

  pickImage(index) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result == null) {
        return;
      } else {
        final path = result.files.single.path!;
        List<Rx<File?>> tempList = List.from(pImagesList);
        tempList[index].value = File(path);
        pImagesList.assignAll(tempList);
      }
    } catch (e) {}
  }

  uploadProduc(context) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      "is_featured": false,
      'p_category': categoryValue.value,
      'p_images': FieldValue.arrayUnion([pimgController.text]),
      'p_subCategory': subCategoryValue.value,
      'p_wishlist': FieldValue.arrayUnion(([])),
      'p_name': pnameController.text,
      'p_price': ppriceController.text,
      'p_quantity': pquantityController.text,
      'p_rating': "3.0",
      "featured_id": "",
    });
    isLoading(false);
    VxToast.show(context, msg: "uploaded");
  }

  addFeature(docId) async {
   await firestore
        .collection(productsCollection)
        .doc(docId)
        .set({'is_feature': true},SetOptions(merge: true));
  }
   removeFeature(docId) async {
 await   firestore
        .collection(productsCollection)
        .doc(docId)
        .set({'is_feature': false}, SetOptions(merge: true));
  }
}



/*    var categoryList = [].obs;
  var subCategoryList = [].obs;
  var pImagesList = [].obs;
  List<Category> category = [];

  var categoryValue = ''.obs;
  var subCategoryValue = ''.obs;
*/