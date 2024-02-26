import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';



class EditUserScreen extends StatefulWidget {
  final String userId;

  const EditUserScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userId)
          .get();

      if (snapshot.exists) {
        setState(() {
          _usernameController.text = snapshot.data()!['username'];
          _emailController.text = snapshot.data()!['email'];
          _phoneController.text = snapshot.data()!['phone'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar('Error', 'User not found');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Error', 'Failed to fetch user data');
    }
  }

  void _updateUserData() async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(widget.userId).update({
        'username': _usernameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      });

      Get.snackbar('Success', 'User data updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _updateUserData,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
