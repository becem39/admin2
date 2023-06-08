import 'package:admin/const/const.dart';
import 'package:admin/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditController extends GetxController {
  var categoryController = TextEditingController();
  var subCategoryController = TextEditingController();
  var newcat = TextEditingController();
  var newsubcat = TextEditingController();
  addCategory() async {
    await firestore.collection("categories").doc().set(
        {'name': newcat.text, 'subCategories': []}, SetOptions(merge: true));
  }

  updateCategory(String docId) async {
    await firestore.collection("categories").doc(docId).set({
      'name': categoryController.text,
    }, SetOptions(merge: true));
  }

  removeCategory(String docId) async {
    await firestore.collection("categories").doc(docId).delete();
  }

  /////////////////////////////
  addSubCategory(String docId) async {
    final categoryDoc = firestore.collection("categories").doc(docId);
    final subCategory = newsubcat.text;

    await categoryDoc.update({
      'subCategories': FieldValue.arrayUnion([subCategory]),
    });
  }

  updateSubCategory(String docId, String subCategoryName,String newsubCategoryName) async {
    final categoryDoc = firestore.collection("categories").doc(docId);

    await categoryDoc.update({
      'subCategories': FieldValue.arrayRemove([subCategoryName]),
    });

    await categoryDoc.update({
      'subCategories': FieldValue.arrayUnion([newsubCategoryName]),
    });
  }

  removeSubCategory(String docId, String subCategory) async {
    final categoryDoc = firestore.collection("categories").doc(docId);

    await categoryDoc.update({
      'subCategories': FieldValue.arrayRemove([subCategory]),
    });
  }
}
