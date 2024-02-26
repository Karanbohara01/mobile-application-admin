


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/controllers/get-all-user-length-controller.dart';
import 'package:mobile_admin/screens/edit-user-screen.dart';

import '../models/user-model.dart';
import '../utils/app-constant.dart';

class AllUsersScreen extends StatelessWidget {
  AllUsersScreen({Key? key});

  final GetUserLengthController _getUserLengthController = Get.put(GetUserLengthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text('Users (${_getUserLengthController.userCollectionLength.value})');
        }),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("users")
            .orderBy('createdOn', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred while fetching users'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No users found'),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];
              UserModel userModel = UserModel(
                uId: data['uId'],
                username: data['username'],
                email: data['email'],
                phone: data['phone'],
                userImg: data['userImg'],
                userDeviceToken: data['userDeviceToken'],
                country: data['country'],
                userAddress: data['userAddress'],
                street: data['street'],
                isAdmin: data['isAdmin'],
                isActive: data['isActive'],
                createdOn: data['createdOn'],
                city: '',
              );
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppConstants.secondaryColor,
                    backgroundImage: CachedNetworkImageProvider(
                      userModel.userImg,
                      errorListener: (err) {
                        print('Error loading image');
                        Icon(Icons.error);
                      },
                    ),
                  ),
                  title: Text(userModel.username),
                  subtitle: Text(userModel.email),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Get.to(() => EditUserScreen(userId: userModel.uId));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
