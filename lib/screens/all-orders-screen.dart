// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../utils/app-constant.dart';
// import 'SpecificCustomerScreen.dart';
//
// class AllOrdersScreen extends StatelessWidget {
//   const AllOrdersScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Orders'),
//         backgroundColor: AppConstants.primaryColor,
//       ),
//       body: FutureBuilder(
//         future: FirebaseFirestore.instance
//             .collection("orders")
//             .orderBy('createdAt', descending: true)
//             .get(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Container(
//               child: const Center(
//                 child: Text('Error occurred while fetching orders'),
//               ),
//             );
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Container(
//               child: const Center(
//                 child: CupertinoActivityIndicator(),
//               ),
//             );
//           }
//
//           if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//             return Container(
//               child: const Center(
//                 child: Text('No orders found'),
//               ),
//             );
//           }
//
//           return ListView.builder(
//             shrinkWrap: true,
//             physics: BouncingScrollPhysics(),
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final data = snapshot.data!.docs[index];
//
//               return Card(
//                 elevation: 5,
//                 child: ListTile(
//                   onTap: ()=>Get.to(
//                       ()=>SpecificCustomerScreen(
//                         docId:snapshot.data!.docs[index]['uId'],
//                         customerName:snapshot.data!.docs[index]
//                           ['customerName']),
//
//                   ),
//                   leading: CircleAvatar(
//                     backgroundColor: AppConstants.secondaryColor,
//                  child:Text(data['customerName'][0]) ,
//                   ),
//                   title: Text(data['customerName']),
//                   subtitle: Text(data['customerPhone']),
//                   trailing: Icon(Icons.edit),
//
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app-constant.dart';
import 'SpecificCustomerScreen.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Orders'),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("orders")
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Error occurred while fetching orders'),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Text('No orders found'),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: () => Get.to(() => SpecificCustomerScreen(
                    docId: snapshot.data!.docs[index]['uId'],
                    customerName: snapshot.data!.docs[index]['customerName'],
                  )),
                  leading: CircleAvatar(
                    backgroundColor: AppConstants.secondaryColor,
                    child: Text(
                      data['customerName'][0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    data['customerName'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(data['customerPhone']),



                ),
              );
            },
          );
        },
      ),
    );
  }
}
