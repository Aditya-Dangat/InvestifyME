// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:investifyme_1/splash.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   List<String> accounts = [];  // Initializes empty list for accounts
//   String? currentAccount;

//   @override
//   void initState() {
//     super.initState();
//     fetchAccounts();
//   }

//   Future<void> fetchAccounts() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       var userEmail = user.email;  // Assuming user email is unique and used as a document ID.
//       var userDocRef = FirebaseFirestore.instance.collection('users').doc(userEmail);
//       var snapshot = await userDocRef.get();
//       if (snapshot.exists && snapshot.data()!.containsKey('accounts')) {
//         List<String> fetchedAccounts = List<String>.from(snapshot.data()!['accounts']);
//         setState(() {
//           accounts = fetchedAccounts;
//           currentAccount = accounts.isNotEmpty ? accounts.first : null;
//         });
//       }
//     }
//   }

//   Future<void> _addAccountToFirestore(String newAccountName) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null && newAccountName.isNotEmpty) {
//       var userEmail = user.email;
//       var userDocRef = FirebaseFirestore.instance.collection('users').doc(userEmail);

//       // Update the accounts array by adding a new account name
//       userDocRef.update({
//         'accounts': FieldValue.arrayUnion([newAccountName])
//       }).then((_) {
//         print('Account added to Firestore!');
//         setState(() {
//           accounts.add(newAccountName);
//           currentAccount = newAccountName;
//         });
//       }).catchError((error) {
//         // If the document does not exist, create it with the new account
//         if (error.code == 'not-found') {
//           userDocRef.set({
//             'accounts': [newAccountName]
//           }).then((_) {
//             print('Document created and account added to Firestore!');
//             setState(() {
//               accounts = [newAccountName];
//               currentAccount = newAccountName;
//             });
//           }).catchError((error) {
//             print('Error creating document: $error');
//           });
//         } else {
//           print('Error updating document: $error');
//         }
//       });
//     } else {
//       print('No user is currently signed in!');
//     }
//   }

//   Future<void> _showAddAccountDialog(BuildContext context) async {
//     String newAccountName = '';
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add New Account'),
//           content: TextField(
//             onChanged: (value) {
//               newAccountName = value;
//             },
//             decoration: const InputDecoration(
//               hintText: 'Enter account name',
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel', style: TextStyle(color: Color(0xff2a52cd))),
//               onPressed: () {
//                 Navigator.of(context). pop();
//               },
//             ),
//             const SizedBox(height: 16.0),
//             TextButton(
//               child: const Text('Add', style: TextStyle(color: Colors.white)),
//               onPressed: () {
//                 _addAccountToFirestore(newAccountName).then((_) {
//                   Navigator.of(context).pop();
//                 });
//               },
//               style: TextButton.styleFrom(backgroundColor: const Color(0xff2a52cd)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffeffeff),
//       appBar: AppBar(
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(4.0),
//           child: Container(
//             color: const Color(0xff202232),
//             height: 2.0,
//           ),
//         ),
//         toolbarHeight: 80,
//         backgroundColor: const Color(0xffeffeff),
//         title: const Text('Profile', style: TextStyle(color: const Color(0xff202232), fontSize: 20.0)),
//       ),
//       body: Center(
//         child:
//          Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             DropdownButton<String>(
//               value: currentAccount,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   currentAccount = newValue!;
//                 });
//               },
//               items: accounts.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value, style: const TextStyle(color: Colors.white)),
//                 );
//               }).toList(),
//               dropdownColor: const Color(0xff2a52cd),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _showAddAccountDialog(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff2a52cd),
//               ),
//               child: const Text('Add New Account', style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(height: 8.0,),
//             ElevatedButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => SplashPage()),
//                   (Route<dynamic> route) => false,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff2a52cd),
//               ),

//               child: const Text('Log Out', style: TextStyle(color: Colors.white)),
//             ),

//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:investifyme_1/splash.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   List<String> accounts = [];  // Initializes empty list for accounts
//   String? currentAccount;

//   @override
//   void initState() {
//     super.initState();
//     fetchAccounts();
//   }

//   Future<void> fetchAccounts() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       var userEmail = user.email;  // Assuming user email is unique and used as a document ID.
//       var userDocRef = FirebaseFirestore.instance.collection('users').doc(userEmail);
//       var snapshot = await userDocRef.get();
//       if (snapshot.exists && snapshot.data()!.containsKey('accounts')) {
//         List<String> fetchedAccounts = List<String>.from(snapshot.data()!['accounts']);
//         setState(() {
//           accounts = fetchedAccounts;
//           currentAccount = accounts.isNotEmpty ? accounts.first : null;
//         });
//       }
//     }
//   }

//   Future<void> _addAccountToFirestore(String newAccountName) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null && newAccountName.isNotEmpty) {
//       var userEmail = user.email;
//       var userDocRef = FirebaseFirestore.instance.collection('users').doc(userEmail);

//       // Update the accounts array by adding a new account name
//       userDocRef.update({
//         'accounts': FieldValue.arrayUnion([newAccountName])
//       }).then((_) {
//         print('Account added to Firestore!');
//         setState(() {
//           accounts.add(newAccountName);
//           currentAccount = newAccountName;
//         });
//       }).catchError((error) {
//         // If the document does not exist, create it with the new account
//         if (error.code == 'not-found') {
//           userDocRef.set({
//             'accounts': [newAccountName]
//           }).then((_) {
//             print('Document created and account added to Firestore!');
//             setState(() {
//               accounts = [newAccountName];
//               currentAccount = newAccountName;
//             });
//           }).catchError((error) {
//             print('Error creating document: $error');
//           });
//         } else {
//           print('Error updating document: $error');
//         }
//       });
//     } else {
//       print('No user is currently signed in!');
//     }
//   }

//   Future<void> _showAddAccountDialog(BuildContext context) async {
//     String newAccountName = '';
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add New Account'),
//           content: TextField(
//             onChanged: (value) {
//               newAccountName = value;
//             },
//             decoration: const InputDecoration(
//               hintText: 'Enter account name',
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel', style: TextStyle(color: Color(0xff2a52cd))),
//               onPressed: () {
//                 Navigator.of(context). pop();
//               },
//             ),
//             const SizedBox(height: 16.0),
//             TextButton(
//               child: const Text('Add', style: TextStyle(color: Colors.white)),
//               onPressed: () {
//                 _addAccountToFirestore(newAccountName).then((_) {
//                   Navigator.of(context).pop();
//                 });
//               },
//               style: TextButton.styleFrom(backgroundColor: const Color(0xff2a52cd)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffeffeff),
//       appBar: AppBar(
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(4.0),
//           child: Container(
//             color: const Color(0xff202232),
//             height: 2.0,
//           ),
//         ),
//         toolbarHeight: 80,
//         backgroundColor: const Color(0xffeffeff),
//         title: const Text('Profile', style: TextStyle(color: const Color(0xff202232), fontSize: 20.0)),
//       ),
//       body: Center(

//         child: SingleChildScrollView(

//                 //body: SafeArea(

//                   child: Column(children: [
//                     SizedBox(
//                       height: 60,
//                     ),
//                     SizedBox(
//                       height: 120,
//                     ),
//                     Image.asset(
//                       "assets/images/logof.png",
//                       //fit: BoxFit.fill,
//                       width: 250,
//                       height: 300,
//                     ),
//                     SizedBox(
//                       height: 40.0,
//                     ),
//                     Text(
//                       'Personalized investing, just for you.',

//                       style: TextStyle(
//                         color: const Color(0xff202232),fontSize:20.0,fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: 40.0,
//                     ),

//             DropdownButton<String>(
//               value: currentAccount,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   currentAccount = newValue!;
//                 });
//               },
//               items: accounts.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value, style: const TextStyle(color: Colors.white)),
//                 );
//               }).toList(),
//               dropdownColor: const Color(0xff2a52cd),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _showAddAccountDialog(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff2a52cd),
//               ),
//               child: const Text('Add New Account', style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(height: 8.0,),
//             ElevatedButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => SplashPage()),
//                   (Route<dynamic> route) => false,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff2a52cd),
//               ),

//               child: const Text('Log Out', style: TextStyle(color: Colors.white)),
//             ),

//           ],
//                   ),

//               )
//             )

//       );

//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:investifyme_1/splash.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   List<String> accounts = [];  // Initializes empty list for accounts
//   String? currentAccount;

//   @override
//   void initState() {
//     super.initState();
//     fetchAccounts();
//   }

//   Future<void> fetchAccounts() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       var userEmail = user.email;  // Assuming user email is unique and used as a document ID.
//       var userDocRef = FirebaseFirestore.instance.collection('users').doc(userEmail);
//       var snapshot = await userDocRef.get();
//       if (snapshot.exists && snapshot.data()!.containsKey('accounts')) {
//         List<String> fetchedAccounts = List<String>.from(snapshot.data()!['accounts']);
//         setState(() {
//           accounts = fetchedAccounts;
//           currentAccount = accounts.isNotEmpty ? accounts.first : null;
//         });
//       }
//     }
//   }

//   Future<void> _addAccountToFirestore(String newAccountName) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null && newAccountName.isNotEmpty) {
//       var userEmail = user.email;
//       var userDocRef = FirebaseFirestore.instance.collection('users').doc(userEmail);

//       // Update the accounts array by adding a new account name
//       userDocRef.update({
//         'accounts': FieldValue.arrayUnion([newAccountName])
//       }).then((_) {
//         print('Account added to Firestore!');
//         setState(() {
//           accounts.add(newAccountName);
//           currentAccount = newAccountName;
//         });
//       }).catchError((error) {
//         // If the document does not exist, create it with the new account
//         if (error.code == 'not-found') {
//           userDocRef.set({
//             'accounts': [newAccountName]
//           }).then((_) {
//             print('Document created and account added to Firestore!');
//             setState(() {
//               accounts = [newAccountName];
//               currentAccount = newAccountName;
//             });
//           }).catchError((error) {
//             print('Error creating document: $error');
//           });
//         } else {
//           print('Error updating document: $error');
//         }
//       });
//     } else {
//       print('No user is currently signed in!');
//     }
//   }

//   Future<void> _showAddAccountDialog(BuildContext context) async {
//     String newAccountName = '';
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add New Account'),
//           content: TextField(
//             onChanged: (value) {
//               newAccountName = value;
//             },
//             decoration: const InputDecoration(
//               hintText: 'Enter account name',
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel', style: TextStyle(color: Color(0xff2a52cd))),
//               onPressed: () {
//                 Navigator.of(context). pop();
//               },
//             ),
//             const SizedBox(height: 16.0),
//             TextButton(
//               child: const Text('Add', style: TextStyle(color: Colors.white)),
//               onPressed: () {
//                 _addAccountToFirestore(newAccountName).then((_) {
//                   Navigator.of(context).pop();
//                 });
//               },
//               style: TextButton.styleFrom(backgroundColor: const Color(0xff2a52cd)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffeffeff),
//       appBar: AppBar(
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(4.0),
//           child: Container(
//             color: const Color(0xff202232),
//             height: 2.0,
//           ),
//         ),
//         toolbarHeight: 80,
//         backgroundColor: const Color(0xffeffeff),
//         title: const Text('Profile', style: TextStyle(color: const Color(0xff202232), fontSize: 20.0)),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             Image.asset(
//               "assets/images/logof.png",
//               width: 250,
//               height: 300,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Personalized investing, just for you.',
//               style: TextStyle(color: const Color(0xff202232), fontSize: 20.0, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             DropdownButton<String>(
//               value: currentAccount,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   currentAccount = newValue!;
//                 });
//               },
//               items: accounts.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value, style: const TextStyle(color: Colors.white)),
//                 );
//               }).toList(),
//               dropdownColor: const Color(0xff2a52cd),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _showAddAccountDialog(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff2a52cd),
//               ),
//               child: const Text('Add New Account', style: TextStyle(color: Colors.white)),
//             ),
//             SizedBox(height: 8.0),
//             ElevatedButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => SplashPage()),
//                   (Route<dynamic> route) => false,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff2a52cd),
//               ),
//               child: const Text('Log Out', style: TextStyle(color: Colors.white)),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:investifyme_1/splash.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> accounts = []; // Initializes empty list for accounts
  String? currentAccount;

  @override
  void initState() {
    super.initState();
    fetchAccounts();
  }

  Future<void> fetchAccounts() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userEmail = user
          .email; // Assuming user email is unique and used as a document ID.
      var userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userEmail);
      var snapshot = await userDocRef.get();
      if (snapshot.exists && snapshot.data()!.containsKey('accounts')) {
        List<String> fetchedAccounts =
            List<String>.from(snapshot.data()!['accounts']);
        setState(() {
          accounts = fetchedAccounts;
          currentAccount = accounts.isNotEmpty ? accounts.first : null;
        });
      }
    }
  }

  Future<void> _addAccountToFirestore(String newAccountName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && newAccountName.isNotEmpty) {
      var userEmail = user.email;
      var userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userEmail);

      // Update the accounts array by adding a new account name
      userDocRef.update({
        'accounts': FieldValue.arrayUnion([newAccountName])
      }).then((_) {
        print('Account added to Firestore!');
        setState(() {
          accounts.add(newAccountName);
          currentAccount = newAccountName;
        });
      }).catchError((error) {
        // If the document does not exist, create it with the new account
        if (error.code == 'not-found') {
          userDocRef.set({
            'accounts': [newAccountName]
          }).then((_) {
            print('Document created and account added to Firestore!');
            setState(() {
              accounts = [newAccountName];
              currentAccount = newAccountName;
            });
          }).catchError((error) {
            print('Error creating document: $error');
          });
        } else {
          print('Error updating document: $error');
        }
      });
    } else {
      print('No user is currently signed in!');
    }
  }

  Future<void> _showAddAccountDialog(BuildContext context) async {
    String newAccountName = '';
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Account'),
          content: TextField(
            onChanged: (value) {
              newAccountName = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter account name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xff2a52cd))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 16.0),
            TextButton(
              child: const Text('Add', style: TextStyle(color: Colors.white)),
              onPressed: () {
                _addAccountToFirestore(newAccountName).then((_) {
                  Navigator.of(context).pop();
                });
              },
              style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff2a52cd)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeffeff),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: const Color(0xffeffeff),
            height: 2.0,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: const Color(0xffeffeff),
        title: const Text('PROFILE',
            style: TextStyle(
                color: const Color(0xff202232),
                fontSize: 20.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0), // Adjust the horizontal padding as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              Image.asset(
                "assets/images/vector2.png",
                width: 250,
                height: 300,
              ),
              SizedBox(height: 20),
              Text(
                'Your PORTFOLIO,\n your control,\n\t your financial FUTURE.',
                style: TextStyle(
                    color: const Color(0xff1580C2),
                    fontSize: 30.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              // DropdownButton<String>(
              //   value: currentAccount,
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       currentAccount = newValue!;
              //     });
              //   },
              //   items: accounts.map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value, style: const TextStyle(color: const Color(0xff202232))),
              //     );
              //   }).toList(),
              //   dropdownColor: Colors.white,
              // ),

              // Center(
              //   child: SizedBox(
              //     width: 200, // Set the desired width for the dropdown button
              //     child: DropdownButton<String>(
              //       value: currentAccount,
              //       alignment: Alignment.center,
              //       onChanged: (String? newValue) {
              //         setState(() {
              //           currentAccount = newValue!;
              //         });
              //       },
              //       items:
              //           accounts.map<DropdownMenuItem<String>>((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(
              //             value,
              //             style:
              //                 const TextStyle(color: const Color(0xff202232)),
              //             textAlign: TextAlign.center,
              //           ),
              //         );
              //       }).toList(),
              //       dropdownColor: Colors.white,
              //     ),
              //   ),
              // ),

              Center(
                child: SizedBox(
                  width: 200, // Set the desired width for the dropdown button
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Aligns the dropdown button to the center
                    children: [
                      DropdownButton<String>(
                        value: currentAccount,
                        onChanged: (String? newValue) {
                          setState(() {
                            currentAccount = newValue!;
                          });
                        },
                        items: accounts
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  color: const Color(0xff202232),
                                  fontFamily: 'Poppins'),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () => _showAddAccountDialog(context),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: const Color(0xff2a52cd),
              //   ),
              //   child: const Text('Add New Account',
              //       style: TextStyle(color: Colors.white)),
              // ),

              SizedBox(
                width: 200, // Set the desired width for the ElevatedButton
                height: 50, // Set the desired height for the ElevatedButton
                child: ElevatedButton(
                  onPressed: () => _showAddAccountDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2a52cd),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('ADD NEW ACCOUNT',
                      style: TextStyle(
                          color: const Color(0xfffeffeff),
                          fontFamily: 'Poppins',
                          fontSize: 20.0)),
                ),
              ),

              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     FirebaseAuth.instance.signOut();
              //     Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              //       MaterialPageRoute(builder: (context) => SplashPage()),
              //       (Route<dynamic> route) => false,
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: const Color(0xff2a52cd),
              //   ),
              //   child: const Text('Log Out',
              //       style: TextStyle(color: Colors.white)),
              // ),

              SizedBox(
                width: 100, // Set the desired width for the ElevatedButton
                height: 50, // Set the desired height for the ElevatedButton
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => SplashPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2a52cd),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('LOG OUT',
                      style: TextStyle(
                          color: const Color(0xfffeffeff),
                          fontFamily: 'Poppins',
                          fontSize: 20.0)),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
