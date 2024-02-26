import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_admin/FirebaseService.dart';
import 'package:mobile_admin/models/product-model.dart';

void main() {
  test("Add Product", () async {
    ProductModel productModel = ProductModel(
      productId: "productId",
      categoryId: "categoryId",
      productName: "productName",
      categoryName: "categoryName",
      salePrice: "salePrice",
      fullPrice: "fullPrice",
      productImages: [""],
      isSale: true,
      productDescription: "productDescription",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deliveryTime: "deliveryTime",
    );

    FirebaseService.db = FakeFirebaseFirestore();

    final res =  FakeFirebaseFirestore()
        .collection("products")
        .doc("1")
        .set(productModel.toMap());

  });
}
