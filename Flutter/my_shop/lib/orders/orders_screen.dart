import 'package:flutter/material.dart';
import 'package:my_shop/common/classes/result.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';
import '../common/drawer/app_drawer.dart';
import '../orders/order_item.dart';

// This is used in case if it just shows a data
class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<OrdersProvider>(context, listen: false)
              .fetchAndSet(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final result = dataSnapshot.data as Result;
              if (result != null && !result.success) {
                return Center(
                  child: Text(result.failure.message),
                );
              } else {
                return Consumer<OrdersProvider>(
                    builder: (ctx, ordersProvider, _) => ListView.builder(
                      itemCount: ordersProvider.orders.length,
                      itemBuilder: (ctx, index) => OrderItem(ordersProvider.orders[index]),
                    )
                );
              }
            }
          },
        )
    );
  }
}

// // This approach is used when we call others screens from here and then get back here
// // and we don't want to re-fetch data
// class OrdersScreen extends StatefulWidget {
//   @override
//   _OrdersScreenState createState() => _OrdersScreenState();
// }
//
// class _OrdersScreenState extends State<OrdersScreen> {
//   Future _ordersFuture;
//
//   Future _obtainOrdersFuture() {
//     return Provider.of<OrdersProvider>(context, listen: false)
//         .fetchAndSet();
//   }
//
//   @override
//   void initState() {
//     _ordersFuture = _obtainOrdersFuture();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final ordersProvider = Provider.of<OrdersProvider>(context);
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Your Orders'),
//         ),
//         drawer: AppDrawer(),
//         body: FutureBuilder(
//           future: _ordersFuture,
//           builder: (ctx, dataSnapshot) {
//             if (dataSnapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               final result = dataSnapshot.data as Result;
//               if (result != null && !result.success) {
//                 return Center(
//                   child: Text(result.failure.message),
//                 );
//               } else {
//                 return Consumer<OrdersProvider>(
//                     builder: (ctx, ordersProvider, _) => ListView.builder(
//                       itemCount: ordersProvider.orders.length,
//                       itemBuilder: (ctx, index) => OrderItem(ordersProvider.orders[index]),
//                     )
//                 );
//               }
//             }
//           },
//         )
//     );
//   }
// }
