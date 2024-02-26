import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_admin/models/product-model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();
  final TextEditingController _fullPriceController = TextEditingController();
  final TextEditingController _isSaleController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();

  List<XFile>? _selectedImages;

  @override
  void dispose() {
    _categoryIdController.dispose();
    _categoryNameController.dispose();
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _salePriceController.dispose();
    _fullPriceController.dispose();
    _isSaleController.dispose();
    _deliveryTimeController.dispose();
    super.dispose();
  }

  void _addProduct() async {
    try {
      List<String> imageURLs = [];

      // Upload images to cloud storage and get their URLs
      if (_selectedImages != null) {
        for (var imageFile in _selectedImages!) {
          String imageURL = await uploadImageToStorage(imageFile);
          imageURLs.add(imageURL);
        }
      }

      // Create a new product object
      ProductModel newProduct = ProductModel(
        productId: FirebaseFirestore.instance.collection("products").doc().id,
        categoryId: _categoryIdController.text,
        categoryName: _categoryNameController.text,
        productName: _productNameController.text,
        productDescription: _productDescriptionController.text,
        salePrice: _salePriceController.text,
        fullPrice: _fullPriceController.text,
        productImages: imageURLs,
        isSale: _isSaleController.text.toLowerCase() == 'true',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
        deliveryTime: _deliveryTimeController.text,
      );

      // Add the product to Firestore
      await FirebaseFirestore.instance.collection("products").doc(newProduct.productId).set(newProduct.toMap());

      Get.snackbar('Success', 'Product added successfully');

      // Clear the text controllers and selected images list
      _categoryIdController.clear();
      _categoryNameController.clear();
      _productNameController.clear();
      _productDescriptionController.clear();
      _salePriceController.clear();
      _fullPriceController.clear();
      _isSaleController.clear();
      _deliveryTimeController.clear();
      setState(() {
        _selectedImages = null;
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product');
    }
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
      if (pickedFiles != null) {
        setState(() {
          _selectedImages = pickedFiles;
        });
      }
    } catch (e) {
      print('Error picking images: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to pick images'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<String> uploadImageToStorage(XFile imageFile) async {
    try {
      // Create a unique filename for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Reference to the Firebase Storage bucket
      firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child('images/$fileName');

      // Upload the image file to Firebase Storage
      await storageReference.putFile(File(imageFile.path));

      // Get the download URL of the uploaded image
      String imageURL = await storageReference.getDownloadURL();

      return imageURL;
    } catch (e) {
      // Handle any errors that occur during image upload
      print('Error uploading image: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _categoryIdController,
                decoration: InputDecoration(labelText: 'Category ID'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _categoryNameController,
                decoration: InputDecoration(labelText: 'Category Name'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _productDescriptionController,
                decoration: InputDecoration(labelText: 'Product Description'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _salePriceController,
                decoration: InputDecoration(labelText: 'Sale Price'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _fullPriceController,
                decoration: InputDecoration(labelText: 'Full Price'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _deliveryTimeController,
                decoration: InputDecoration(labelText: 'Delivery Time'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImages,
                child: Text('Select Images'),
              ),
              SizedBox(height: 16),
              _buildSelectedImagesPreview(),
              SizedBox(height: 16),
              TextFormField(
                controller: _isSaleController,
                decoration: InputDecoration(labelText: 'Is Sale (true/false)'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImagesPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Images:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _selectedImages?.map((image) {
              return Container(
                margin: EdgeInsets.only(right: 8),
                width: 100,
                height: 100,
                child: Image.file(
                  File(image.path),
                  fit: BoxFit.cover,
                ),
              );
            }).toList() ??
                [],
          ),
        ),
      ],
    );
  }
}
