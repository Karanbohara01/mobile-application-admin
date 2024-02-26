// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_admin/screens/all-orders-screen.dart';
import 'package:mobile_admin/screens/all-products-screen.dart';
import 'package:mobile_admin/screens/contact-screen.dart';
import 'package:mobile_admin/screens/main-screen.dart';



import '../screens/all-users-screen.dart';
import '../utils/app-constant.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [

            DrawerHeader2(),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(

                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Home",
                  style: TextStyle(color: AppConstants.textColor),
                ),
                leading: Icon(
                  Icons.home,
                  color: AppConstants.textColor,
                ),
                onTap:() {
                  Get.to(()=>MainScreen());
                },
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.textColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap:() {
                 Get.to(()=>AllUsersScreen());
                },
                title: Text(
                  "Users",
                  style: TextStyle(color: AppConstants.textColor),
                ),
                titleAlignment: ListTileTitleAlignment.center,

                leading: Icon(
                  Icons.person,
                  color: AppConstants.textColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.textColor,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: (){
                  Get.to(()=>AllOrdersScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Orders",
                  style: TextStyle(color: AppConstants.textColor),
                ),
                leading: Icon(
                  Icons.shopping_bag,
                  color: AppConstants.textColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.textColor,
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: (){
                  Get.to(()=>AllProductsScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Products",
                  style: TextStyle(color: AppConstants.textColor),
                ),
                leading: Icon(
                  Icons.production_quantity_limits,
                  color: AppConstants.textColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.textColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Categories",
                  style: TextStyle(color: AppConstants.textColor),
                ),
                leading: Icon(
                  Icons.category,
                  color: AppConstants.textColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.textColor,
                ),
                onTap: () {
                  // Get.back();
                  // Get.to(() => AllOrdersScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Contact",
                  style: TextStyle(color: AppConstants.textColor),
                ),
                leading: Icon(
                  Icons.contact_emergency,
                  color: AppConstants.textColor,

                ),
                onTap: () {
                  // Get.back();
                  Get.to(() => ContactScreen());
                },

                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.textColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  // Get.offAll(() => WelcomeScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Login",
                  style: TextStyle(color: AppConstants.textColor),
                ),
                leading: Icon(
                  Icons.login,
                  color: AppConstants.textColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.textColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}


class DrawerHeader2 extends StatelessWidget {
  const DrawerHeader2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        title: Text(
          "A.K",
          style: TextStyle(color: AppConstants.textColor),
        ),
        subtitle: Text(
          "Version 1.0.1",
          style: TextStyle(color: AppConstants.textColor),
        ),
        leading: CircleAvatar(
          radius: 22.0,
          backgroundColor: AppConstants.primaryColor,
          child: Text(
            "A",
            style: TextStyle(color: AppConstants.textColor),
          ),
        ),
      ),
    );
  }
}
