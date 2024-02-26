import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
      ),
      body: FutureBuilder(
        future: Future.wait([
          FirebaseFirestore.instance.collection('users').get(),
          FirebaseFirestore.instance.collection('orders').get(),
          FirebaseFirestore.instance.collection('products').get(), // New addition for products
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            int totalUsers = snapshot.data?[0].size ?? 0;
            int totalOrders = snapshot.data?[1].size ?? 0;
            int totalProducts = snapshot.data?[2].size ?? 0; // Total number of products
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnalyticsItem(icon: Icons.person, label: 'Total Users', value: totalUsers),
                  SizedBox(height: 20),
                  _buildAnalyticsItem(icon: Icons.shopping_cart, label: 'Total Orders', value: totalOrders),
                  SizedBox(height: 20),
                  _buildAnalyticsItem(icon: Icons.inventory, label: 'Total Products', value: totalProducts),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAnalyticsItem({required IconData icon, required String label, required int value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
