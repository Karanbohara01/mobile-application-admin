import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/screens/all-orders-screen.dart';
import 'package:mobile_admin/screens/all-products-screen.dart';
import 'package:mobile_admin/screens/all-users-screen.dart';
import 'package:mobile_admin/screens/setting-screen.dart';
import 'package:mobile_admin/utils/app-constant.dart';
import 'package:mobile_admin/widgets/drawer-widget.dart';

import 'add-product-screen.dart';
import 'analytics-screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Panel",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppConstants.primaryColor,
        elevation: 0, // Remove the shadow
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, Admin!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuItem(context, "Manage Users", Icons.people, () {
                    Get.to(() => AllUsersScreen());
                  }),
                  _buildMenuItem(context, "Manage Orders", Icons.shopping_cart, () {
                    Get.to(() => AllOrdersScreen());
                  }),
                  _buildMenuItem(context, "Manage Products", Icons.inventory, () {
                    Get.to(() => AddProductScreen());
                  }),
                  _buildMenuItem(context, "Analytics", Icons.analytics, () {
                    // Add functionality for Analytics
                    Get.to(() => AnalyticsScreen());
                  }),
                  _buildMenuItem(context, "Settings", Icons.settings, () {
                    // Add functionality for Settings
                    Get.to(() => SettingsScreen());
                  }), _buildMenuItem(context, "All Products", Icons.production_quantity_limits_sharp, () {
                    // Add functionality for Settings
                    Get.to(() => AllProductsScreen());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: AppConstants.primaryColor,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
