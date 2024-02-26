import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/models/order-model.dart';
import 'package:mobile_admin/utils/app-constant.dart';

import 'check-single-order-screen.dart';

class SpecificCustomerScreen extends StatelessWidget {
  String docId;
  String customerName;
   SpecificCustomerScreen({
    super.key,
    required this.docId,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(customerName),
      ),
      body:  FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("orders").doc(docId).collection('confirmOrders')
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: const Center(
                child: Text('Error occurred while fetching orders'),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Container(
              child: const Center(
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
              String orderDocId = data.id;

              OrderModel orderModel = OrderModel(
                  categoryId: data['categoryId'],
                  categoryName: data['customerName'],
                  createdAt: data['createdAt'],
                  customerAddress: data['customerAddress'],
                  customerDeviceToken: data['customerDeviceToken'],
                  customerId: data['customerId'],
                  customerName: data['customerName'],
                  customerPhone: data['customerPhone'],
                  deliveryTime: data['deliveryTime'],
                  fullPrice: data['fullPrice'],
                  isSale: data['isSale'],
                  productDescription: data['productDescription'],
                  productId: data['productId'],
                  productImages: data['productImages'],
                  productName: data['productName'],
                  productQuantity: data['productQuantity'],
                  productTotalPrice: data['productTotalPrice'],
                  salePrice: data['salePrice'],
                  status: data['status'],
                  updatedAt: data['updatedAt'],
              );

              return Card(
                elevation: 5,
                child: ListTile(
                  onTap: ()=>Get.to(
                        ()=>CheckSingleOrderScreen(
                        docId:snapshot.data!.docs[index].id,
                          orderModel:orderModel,
                        ),


                  ),
                  leading: CircleAvatar(
                    backgroundColor: AppConstants.secondaryColor,
                    child:Text(orderModel.customerName[0]) ,
                  ),
                  title: Text(data['customerName']),
                  subtitle: Text(orderModel.productName),
                  trailing: InkWell(
                    onTap: (){
                      showBottomSheet(
                        userDocId:docId,
                        orderModel:orderModel,
                        orderDocId:orderDocId

                      );

                    },
                      child: Icon(Icons.more_vert)),

                ),
              );
            },
          );
        },
      ),
    );
  }
  void showBottomSheet({required String userDocId, required OrderModel orderModel, required String orderDocId}){
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: ()
                async
                {
                  await FirebaseFirestore.instance.collection('orders').doc(userDocId).collection('confirmOrder').doc(orderDocId)
                      .update(
                    {
                      'status':false,
                    },
                  );
                }, child: Text('Pending')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: ()
                async
                {
                  await FirebaseFirestore.instance.collection('orders').doc(userDocId).collection('confirmOrder').doc(orderDocId)
                      .update(
                    {
                      'status':true,
                    },
                  );

                }, child: Text('Delivered')),
              )
            ],
          )
        ],
      )
    ),);
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobile_admin/models/order-model.dart';
// import 'package:mobile_admin/screens/check-single-order-screen.dart';
// import 'package:mobile_admin/utils/app-constant.dart';
//
// class SpecificCustomerScreen extends StatelessWidget {
//   final String docId;
//   final String customerName;
//
//   SpecificCustomerScreen({
//     required this.docId,
//     required this.customerName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppConstants.primaryColor,
//         title: Text(customerName),
//       ),
//       body: FutureBuilder(
//         future: FirebaseFirestore.instance
//             .collection("orders")
//             .doc(docId)
//             .collection('confirmOrders')
//             .orderBy('createdAt', descending: true)
//             .get(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error occurred while fetching orders'),
//             );
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CupertinoActivityIndicator(),
//             );
//           }
//
//           if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text('No orders found'),
//             );
//           }
//
//           return ListView.separated(
//             padding: EdgeInsets.all(16),
//             itemCount: snapshot.data!.docs.length,
//             separatorBuilder: (context, index) => SizedBox(height: 16),
//             itemBuilder: (context, index) {
//               final data = snapshot.data!.docs[index];
//
//               OrderModel orderModel = OrderModel(
//                 categoryId: data['categoryId'],
//                 categoryName: data['customerName'],
//                 createdAt: data['createdAt'],
//                 customerAddress: data['customerAddress'],
//                 customerDeviceToken: data['customerDeviceToken'],
//                 customerId: data['customerId'],
//                 customerName: data['customerName'],
//                 customerPhone: data['customerPhone'],
//                 deliveryTime: data['deliveryTime'],
//                 fullPrice: data['fullPrice'],
//                 isSale: data['isSale'],
//                 productDescription: data['productDescription'],
//                 productId: data['productId'],
//                 productImages: data['productImages'],
//                 productName: data['productName'],
//                 productQuantity: data['productQuantity'],
//                 productTotalPrice: data['productTotalPrice'],
//                 salePrice: data['salePrice'],
//                 status: data['status'],
//                 updatedAt: data['updatedAt'],
//               );
//
//               return Card(
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: ListTile(
//                   contentPadding: EdgeInsets.all(16),
//                   onTap: () => Get.to(() => CheckSingleOrderScreen(
//                     docId: snapshot.data!.docs[index].id,
//                     orderModel: orderModel,
//                   )),
//                   leading: CircleAvatar(
//                     backgroundColor: AppConstants.secondaryColor,
//                     child: Text(orderModel.customerName.substring(0, 1).toUpperCase()),
//                   ),
//                   title: Text(
//                     data['customerName'],
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     orderModel.productName,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   trailing: Icon(Icons.arrow_forward_ios),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

