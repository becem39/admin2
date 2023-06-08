import 'package:admin/const/const.dart';

class FirestoreServices {
  //get user data

  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getSubCategoryProducts(title) {
    return firestore
        .collection(productsCollection)
        .where('p_subCategory', isEqualTo: title)
        .snapshots();
  }

  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var result = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          return value.docs.length;
        }
      }),
      firestore
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          return value.docs.length;
        }
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          return value.docs.length;
        }
      }),
    ]);

    int cartCount = result[0] ?? 0;
    int wishlistCount = result[1] ?? 0;
    int ordersCount = result[2] ?? 0;

    return [cartCount, wishlistCount, ordersCount];
    //return result;
  }

  static allProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .snapshots();
  }

  static searchProducts(title) {
    return firestore.collection(productsCollection).get();
    //.where('p_name', isLessThanOrEqualTo: title)
  }

  static Future<List<String>> getCategories() async {
    final snapshot = await firestore.collection('categories').get();
    var categoryNames = <String>[];
    for (final doc in snapshot.docs) {
      final data = doc.data();
      final categoryName = data['name'] as String?;

      if (categoryName != null) {
        categoryNames.add(categoryName);
      }
    }
    return categoryNames;
  }

  static Future<List<String>> getSubCategories(category) async {
    final snapshot = await firestore
        .collection('categories')
        .where('name', isEqualTo: category)
        .get();
    var subCategories = <String>[];

    for (final doc in snapshot.docs) {
      var data = doc.data();
      var subCategoryList = data['subCategories'] as List<dynamic>?;

      if (subCategoryList != null) {
        subCategories.addAll(
            subCategoryList.map((subCategory) => subCategory.toString()));
      }
    }

    return subCategories;
  }
}
