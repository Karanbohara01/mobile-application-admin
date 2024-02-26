import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:mobile_admin/models/product-model.dart';
import '../utils/app-constant.dart';
import 'edit-product-screen.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products"),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("products")
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text('Error occurred while fetching products'),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No products found'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];
              final productModel = ProductModel(
                productId: data['productId'],
                categoryId: data['categoryId'],
                productName: data['productName'],
                categoryName: data['categoryName'],
                salePrice: data['salePrice'],
                fullPrice: data['fullPrice'],
                productImages: data['productImages'],
                isSale: data['isSale'],
                deliveryTime: data['deliveryTime'],
                productDescription: data['productDescription'],
                createdAt: data['createdAt'],
                updatedAt: data['updatedAt'],
              );

              return GestureDetector(
                onTap: () {
                  Get.to(() => EditProductScreen(productId: productModel.productId, product: productModel));
                },
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: productModel.productImages.isNotEmpty
                            ? productModel.productImages[0]
                            : '',
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    title: Text(productModel.productName),
                    subtitle: Text(productModel.productDescription),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            editProduct(context, productModel);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteProduct(context, productModel);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void editProduct(BuildContext context, ProductModel productModel) {
    Get.to(() => EditProductScreen(productId: productModel.productId, product: productModel));
  }

  void deleteProduct(BuildContext context, ProductModel productModel) async {
    bool confirm = await showConfirmationDialog(context);
    if (confirm) {
      await FirebaseFirestore.instance.collection("products").doc(productModel.productId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product deleted successfully'),
        ),
      );
    }
  }

  Future<bool> showConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
