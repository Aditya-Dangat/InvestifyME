// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Stats extends StatefulWidget {
//   static const String routeName = '/statspage';

//   const Stats({Key? key}) : super(key: key);

//   @override
//   _StatsState createState() => _StatsState();
// }

// class _StatsState extends State<Stats> {
//   String? selectedAccount;
//   Map<String, double> accountTotalBuyPrices = {};
//   Map<String, double> accountTotalSellPrices = {};

//   @override
//   void initState() {
//     super.initState();
//     _fetchTotalBuyPrices(); // Fetch total buy prices on widget initialization
//     _fetchTotalSellPrices(); // Fetch total sell prices on widget initialization
//     selectedAccount = 'All'; // Set "All" as the default selected value
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffeffeff),
//       appBar: AppBar(
//         backgroundColor: Color(0xffeffeff),
//         title: Text('Statistics Page',
//             style: TextStyle(
//                 color: const Color(0xff202232),
//                 fontFamily: 'Poppins',
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold)),
//         actions: [
//           IconButton(
//             onPressed: () {
//               _fetchTotalBuyPrices();
//               _fetchTotalSellPrices();
//             },
//             icon: Icon(Icons.refresh),
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(
//               'Your Purchases & Sells',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: const Color(0xff202232),
//                   fontFamily: 'Poppins'),
//             ),
//           ),
//           SizedBox(height: 10),
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Color(0xffeffeff),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: DropdownButton<String>(
//                     value: selectedAccount,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedAccount = newValue;
//                         _fetchTotalBuyPrices();
//                         _fetchTotalSellPrices();
//                       });
//                     },
//                     items: [
//                       DropdownMenuItem(
//                           value: 'All',
//                           child: Text('All',
//                               style: const TextStyle(
//                                   color: const Color(0xff202232),
//                                   fontFamily: 'Poppins'))),
//                       ...accountTotalBuyPrices.keys
//                           .map((accountName) => DropdownMenuItem(
//                                 value: accountName,
//                                 child: Text(accountName),
//                               ))
//                           .toList(),
//                     ],
//                     hint: Text('Filter by account',
//                         style: const TextStyle(color: const Color(0xff202232))),
//                     dropdownColor: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Total Buy Price: \₹${_getTotalBuyPrice()}',
//                         style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Total Sell Price: \₹${_getTotalSellPrice()}',
//                         style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(
//               'List of Purchased Stocks',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: const Color(0xff202232),
//                   fontFamily: 'Poppins'),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Color(0xffeffeff),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: _buildPurchasedStocksList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPurchasedStocksList() {
//     return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.email)
//           .collection('accounts')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           List<Widget> stockTiles = [];
//           for (QueryDocumentSnapshot<Map<String, dynamic>> accountDoc
//               in snapshot.data!.docs) {
//             List<dynamic> transactions = accountDoc.data()['transactions'];
//             for (dynamic transaction in transactions) {
//               if (selectedAccount == 'All' ||
//                   selectedAccount == accountDoc.id) {
//                 stockTiles.add(Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: const Color(0xff202232),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 1,
//                         blurRadius: 3,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   child: ListTile(
//                     title: Text(
//                       transaction['shareName'] ?? 'N/A',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Poppins'),
//                     ),
//                     subtitle: Text(
//                       'Date: ${transaction['date'].toString()} | Total Amount: \₹${transaction['totalAmount'] ?? 'N/A'}',
//                       style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white70,
//                           fontFamily: 'Poppins'),
//                     ),
//                     onTap: () {
//                       showDetailDialog(
//                           transaction); // Show detailed info dialog on tap
//                     },
//                   ),
//                 ));
//               }
//             }
//           }
//           return Column(
//             children: [
//               Expanded(
//                 child: ListView(children: stockTiles),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }

//   void showDetailDialog(dynamic transaction) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Details'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Share Name: ${transaction['shareName'] ?? 'N/A'}'),
//               Text('Exchange Name: ${transaction['exchangeName'] ?? 'N/A'}'),
//               Text('Date: ${transaction['date'].toString()}'),
//               Text('Quantity: ${transaction['quantity'] ?? 'N/A'}'),
//               Text('Price: \₹${transaction['price'] ?? 'N/A'}'),
//               Text('Total Amount: \₹${transaction['totalAmount'] ?? 'N/A'}'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   String _getTotalBuyPrice() {
//     if (selectedAccount == 'All') {
//       double total = 0.0;
//       accountTotalBuyPrices.values.forEach((price) {
//         total += price;
//       });
//       return total.toStringAsFixed(2);
//     } else {
//       return accountTotalBuyPrices[selectedAccount]?.toStringAsFixed(2) ??
//           'N/A';
//     }
//   }

//   String _getTotalSellPrice() {
//     if (selectedAccount == 'All') {
//       double total = 0.0;
//       accountTotalSellPrices.values.forEach((price) {
//         total += price;
//       });
//       return total.toStringAsFixed(2);
//     } else {
//       return accountTotalSellPrices[selectedAccount]?.toStringAsFixed(2) ??
//           'N/A';
//     }
//   }

//   Future<void> _fetchTotalBuyPrices() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw Exception('User is not logged in');
//     }
//     String userId = user.email!;
//     QuerySnapshot<Map<String, dynamic>> accountQuerySnapshot =
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userId)
//             .collection('accounts')
//             .get();

//     Map<String, double> totalBuyPrices = {};
//     for (QueryDocumentSnapshot<Map<String, dynamic>> accountDoc
//         in accountQuerySnapshot.docs) {
//       double totalBuyPrice = 0.0;
//       List<dynamic> transactions = accountDoc.data()['transactions'];
//       for (dynamic transaction in transactions) {
//         if (transaction['type'] == 'Buy') {
//           totalBuyPrice += transaction['price'] * transaction['quantity'];
//         }
//       }
//       totalBuyPrices[accountDoc.id] = totalBuyPrice;
//     }

//     setState(() {
//       accountTotalBuyPrices = totalBuyPrices;
//     });
//   }

//   Future<void> _fetchTotalSellPrices() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw Exception('User is not logged in');
//     }
//     String userId = user.email!;
//     QuerySnapshot<Map<String, dynamic>> accountQuerySnapshot =
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userId)
//             .collection('accounts')
//             .get();

//     Map<String, double> totalSellPrices = {};
//     for (QueryDocumentSnapshot<Map<String, dynamic>> accountDoc
//         in accountQuerySnapshot.docs) {
//       double totalSellPrice = 0.0;
//       List<dynamic> transactions = accountDoc.data()['transactions'];
//       for (dynamic transaction in transactions) {
//         if (transaction['type'] == 'Sell') {
//           totalSellPrice += transaction['price'] * transaction['quantity'];
//         }
//       }
//       totalSellPrices[accountDoc.id] = totalSellPrice;
//     }

//     setState(() {
//       accountTotalSellPrices = totalSellPrices;
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Stats extends StatefulWidget {
  static const String routeName = '/statspage';

  const Stats({Key? key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  String? selectedAccount;
  Map<String, double> accountTotalBuyPrices = {};
  Map<String, double> accountTotalSellPrices = {};
  Map<String, double> accountTotalProfitsOrLosses = {};
  @override
  void initState() {
    super.initState();
    _fetchTotalBuyPrices(); // Fetch total buy prices on widget initialization
    _fetchTotalSellPrices(); // Fetch total sell prices on widget initialization
    _fetchTotalLosOrProfit(); // Fetch total loss or profit on widget initialization
    selectedAccount = 'All'; // Set "All" as the default selected value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeffeff),
      appBar: AppBar(
        backgroundColor: Color(0xffeffeff),
        title: Text('Statistics Page',
            style: TextStyle(
                color: const Color(0xff202232),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins')),
        actions: [
          IconButton(
            onPressed: () {
              _fetchTotalBuyPrices();
              _fetchTotalSellPrices();
              _fetchTotalLosOrProfit();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Your Purchases & Sells',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xff202232),
                fontFamily: 'Poppins',
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xffeffeff),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: DropdownButton<String>(
                    value: selectedAccount,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedAccount = newValue;
                        _fetchTotalBuyPrices();
                        _fetchTotalSellPrices();
                        _fetchTotalLosOrProfit();
                      });
                    },
                    items: [
                      DropdownMenuItem(
                          value: 'All',
                          child: Text('All',
                              style: const TextStyle(
                                  color: const Color(0xff202232),
                                  fontFamily: 'Poppins'))),
                      ...accountTotalBuyPrices.keys
                          .map((accountName) => DropdownMenuItem(
                                value: accountName,
                                child: Text(accountName),
                              ))
                          .toList(),
                    ],
                    hint: Text('Filter by account',
                        style: const TextStyle(
                            color: const Color(0xff202232),
                            fontFamily: 'Poppins')),
                    dropdownColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Buy Price: \₹${_getTotalBuyPrice()}',
                        style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total Sell Price: \₹${_getTotalSellPrice()}',
                        style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Total Loss/Profit: \₹${_getTotalLossOrProfit()}',
                        style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'List of Purchased/Sold Stocks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xff202232),
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xffeffeff),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildPurchasedStocksList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchasedStocksList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('accounts')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Widget> stockTiles = [];
          for (QueryDocumentSnapshot<Map<String, dynamic>> accountDoc
              in snapshot.data!.docs) {
            List<dynamic> transactions = accountDoc.data()['transactions'];
            for (dynamic transaction in transactions) {
              if ((transaction['type'] == 'Buy') && (selectedAccount == 'All' ||
                  selectedAccount == accountDoc.id)) {
                stockTiles.add(Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff202232),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      '${transaction['shareName'] ?? 'N/A'} | Buy',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins'),
                    ),
                    subtitle: Text(
                      'Date: ${transaction['date'].toString()} | Total Amount: \₹${transaction['totalAmount'] ?? 'N/A'}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontFamily: 'Poppins'),
                    ),
                    onTap: () {
                      showDetailDialog(
                          transaction); // Show detailed info dialog on tap
                    },
                  ),
                ));
              }
              else if ((transaction['type'] == 'Sell') && (selectedAccount == 'All' ||
                  selectedAccount == accountDoc.id)) {
                stockTiles.add(Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff202232),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      '${transaction['shareName'] ?? 'N/A'} | Sell',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins'),
                    ),
                    subtitle: Text(
                      'Date: ${transaction['date'].toString()} | Total Amount: \₹${transaction['totalAmount'] ?? 'N/A'}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontFamily: 'Poppins'),
                    ),
                    onTap: () {
                      showDetailDialog(
                          transaction); // Show detailed info dialog on tap
                    },
                  ),
                ));
              }
            }
          }
          return Column(
            children: [
              Expanded(
                child: ListView(children: stockTiles),
              ),
            ],
          );
        }
      },
    );
  }

  void showDetailDialog(dynamic transaction) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Share Name: ${transaction['shareName'] ?? 'N/A'}'),
              Text('Exchange Name: ${transaction['exchangeName'] ?? 'N/A'}'),
              Text('Date: ${transaction['date'].toString()}'),
              Text('Quantity: ${transaction['quantity'] ?? 'N/A'}'),
              Text('Price: \₹${transaction['price'] ?? 'N/A'}'),
              Text('Total Amount: \₹${transaction['totalAmount'] ?? 'N/A'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _getTotalBuyPrice() {
    if (selectedAccount == 'All') {
      double total = 0.0;
      accountTotalBuyPrices.values.forEach((price) {
        total += price;
      });
      return total.toStringAsFixed(2);
    } else {
      return accountTotalBuyPrices[selectedAccount]?.toStringAsFixed(2) ??
          'N/A';
    }
  }

  String _getTotalSellPrice() {
    if (selectedAccount == 'All') {
      double total = 0.0;
      accountTotalSellPrices.values.forEach((price) {
        total += price;
      });
      return total.toStringAsFixed(2);
    } else {
      return accountTotalSellPrices[selectedAccount]?.toStringAsFixed(2) ??
          'N/A';
    }
  }

  String _getTotalLossOrProfit(){
    if (selectedAccount == 'All') {
      double total = 0.0;
      accountTotalProfitsOrLosses.values.forEach((price) {
        total += price;
    });
    return total.toStringAsFixed(2);
    } else {
    return accountTotalProfitsOrLosses[selectedAccount]?.toStringAsFixed(2) ??
          'N/A';
  }
  }

  Future<void> _fetchTotalBuyPrices() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    String userId = user.email!;
    QuerySnapshot<Map<String, dynamic>> accountQuerySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('accounts')
            .get();

    Map<String, double> totalBuyPrices = {};
    for (QueryDocumentSnapshot<Map<String, dynamic>> accountDoc
        in accountQuerySnapshot.docs) {
      double totalBuyPrice = 0.0;
      List<dynamic> transactions = accountDoc.data()['transactions'];
      for (dynamic transaction in transactions) {
        if (transaction['type'] == 'Buy') {
          totalBuyPrice += transaction['price'] * transaction['quantity'];
        }
      }
      totalBuyPrices[accountDoc.id] = totalBuyPrice;
    }

    setState(() {
      accountTotalBuyPrices = totalBuyPrices;
    });
  }

  Future<void> _fetchTotalSellPrices() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    String userId = user.email!;
    QuerySnapshot<Map<String, dynamic>> accountQuerySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('accounts')
            .get();

    Map<String, double> totalSellPrices = {};
    for (QueryDocumentSnapshot<Map<String, dynamic>> accountDoc
        in accountQuerySnapshot.docs) {
      double totalSellPrice = 0.0;
      List<dynamic> transactions = accountDoc.data()['transactions'];
      for (dynamic transaction in transactions) {
        if (transaction['type'] == 'Sell') {
          totalSellPrice += transaction['price'] * transaction['quantity'];
        }
      }
      totalSellPrices[accountDoc.id] = totalSellPrice;
    }

    setState(() {
      accountTotalSellPrices = totalSellPrices;
    });
  }


    //update code to return value calculated by (sell value - buy value)
    // and return loss if value is less than 0 or profit if value is greater
    // than zero with the value itself
  Future<void> _fetchTotalLosOrProfit() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    String userId = user.email!;
    QuerySnapshot<Map<String, dynamic>> accountQuerySnapshot =
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('accounts')
        .get();

    Map<String, double> totalProfitsOrLosses = {};
    for (QueryDocumentSnapshot<Map<String, dynamic>> accountDoc
    in accountQuerySnapshot.docs) {
      double totalBuyPrice = 0.0;
      double totalSellPrice = 0.0;
      List<dynamic> transactions = accountDoc.data()['transactions'];
      for (dynamic transaction in transactions) {
        if (transaction['type'] == 'Buy') {
          totalBuyPrice += transaction['price'] * transaction['quantity'];
        } else if (transaction['type'] == 'Sell') {
          totalSellPrice += transaction['price'] * transaction['quantity'];
        }
      }
      // Calculate profit or loss
      double profitOrLoss = totalSellPrice - totalBuyPrice;
      totalProfitsOrLosses[accountDoc.id] = profitOrLoss;
    }

    setState(() {
      accountTotalProfitsOrLosses = totalProfitsOrLosses;
    });
  }


}