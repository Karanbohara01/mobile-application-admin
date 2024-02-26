import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/models/product-model.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;

  const EditProductScreen({Key? key, required this.product, required String productId}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();
  final TextEditingController _fullPriceController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchProductData();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _salePriceController.dispose();
    _fullPriceController.dispose();
    super.dispose();
  }

  void _fetchProductData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection("products")
          .doc(widget.product.productId)
          .get();

      if (snapshot.exists) {
        setState(() {
          _productNameController.text = snapshot.data()!['productName'];
          _productDescriptionController.text = snapshot.data()!['productDescription'];
          _salePriceController.text = snapshot.data()!['salePrice'];
          _fullPriceController.text = snapshot.data()!['fullPrice'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar('Error', 'Product not found');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Error', 'Failed to fetch product data');
    }
  }

  void _updateProductData() async {
    try {
      await FirebaseFirestore.instance.collection("products").doc(widget.product.productId).update({
        'productName': _productNameController.text,
        'productDescription': _productDescriptionController.text,
        'salePrice': _salePriceController.text,
        'fullPrice': _fullPriceController.text,
      });

      Get.snackbar('Success', 'Product data updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _productDescriptionController,
              decoration: InputDecoration(
                labelText: 'Product Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3, // Adjust as needed
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _salePriceController,
              decoration: InputDecoration(
                labelText: 'Sale Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _fullPriceController,
              decoration: InputDecoration(
                labelText: 'Full Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateProductData,
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Change button color
                padding: EdgeInsets.symmetric(vertical: 16), // Adjust button padding
              ),
            ),
          ],
        ),
      ),
    );
  }
}
