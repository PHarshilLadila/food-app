// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:food_app/functionalities/file%20operation/order_provider.dart';
// import 'package:provider/provider.dart';

// class OrederScreen extends StatefulWidget {
//   const OrederScreen({super.key});

//   @override
//   State<OrederScreen> createState() => _OrederScreenState();
// }

// class _OrederScreenState extends State<OrederScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final orderProvider = Provider.of<OrderProvider>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Order History"),
//       ),
//       body: orderProvider.oreders.isEmpty
//           ? Center(
//               child: Text("No Orders Found"),
//             )
//           : ListView.builder(
//               itemCount: orderProvider.oreders.length,
//               itemBuilder: (context, index) {
//                 final order = orderProvider.oreders[index];
//                 return ListTile(
//                   title: Text("${order}"),
//                   subtitle: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text("\$${order["price"]} - ${order["date"]}"),
//                       Spacer(),
//                       FaIcon(
//                         FontAwesomeIcons.trashCan,
//                         color: Colors.red,
//                       )
//                     ],
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/functionalities/file%20operation/order_provider.dart';
import 'package:provider/provider.dart';

class OrederScreen extends StatefulWidget {
  const OrederScreen({super.key});

  @override
  State<OrederScreen> createState() => _OrederScreenState();
}

class _OrederScreenState extends State<OrederScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          if (orderProvider.oreders.isEmpty) {
            return const Center(
              child: Text("No Orders Found"),
            );
          }

          return ListView.builder(
            itemCount: orderProvider.oreders.length,
            itemBuilder: (context, index) {
              final order = orderProvider.oreders[index];
              return ListTile(
                title: Text(order["itemName"] ?? "Unknown Item"),
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network("${order["itemImage"] ?? ""}")),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("\$${order["itemPrice"] ?? 0}"),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Add functionality to delete the order
                        // orderProvider.oreders.removeAt(index);
                        // // ignore: invalid_use_of_protected_member
                        // orderProvider.notifyListeners();
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
