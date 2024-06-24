import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Portfolio extends StatefulWidget {
  static const String routeName = '/portfolio';

  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  String _formType = 'Buy';

  // Form fields controller
  final TextEditingController _shareNameController = TextEditingController();
  final TextEditingController _exchangeNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // Form fields controller
// Dropdown menu values
  List<String> accountNames = [];
  String? selectedAccount;

  @override
  void initState() {
    super.initState();
    fetchAccounts(); // Call the fetchProfiles function on initState.
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
          accountNames = fetchedAccounts;
          selectedAccount = accountNames.isNotEmpty ? accountNames.first : null;
        });
      }
    }
  }

  void clearForm() {
    _shareNameController.clear();
    _exchangeNameController.clear();
    _dateController.clear();
    _quantityController.clear();
    _priceController.clear();
    _totalAmountController.clear();
    _noteController.clear();
    // Optionally reset the dropdown
    setState(() {
      selectedAccount = null;
    });
  }

  void _submitForm() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in to submit.")),
      );
      return;
    }
    if (selectedAccount == null || selectedAccount!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a valid account.")),
      );
      return;
    }

    Map<String, dynamic> transactionData = {
      'shareName': _shareNameController.text,
      'exchangeName': _exchangeNameController.text,
      'date': _dateController
          .text, // This should ideally be converted to a Firestore Timestamp
      'quantity': int.tryParse(_quantityController.text) ?? 0,
      'price': double.tryParse(_priceController.text) ?? 0.0,
      'totalAmount': double.tryParse(_totalAmountController.text) ?? 0.0,
      'note': _noteController.text,
      'type': _formType
    };

    DocumentReference accountDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.email) // Document ID as user's email
        .collection('accounts')
        .doc(selectedAccount); // Document for the selected account

    // Update the account document with new transaction
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot accountSnapshot = await transaction.get(accountDocRef);
      if (!accountSnapshot.exists) {
        // If the account does not exist, initialize it
        transaction.set(accountDocRef, {
          'transactions': [transactionData]
        });
      } else {
        // If the account exists, append to the transactions array
        List<dynamic> updatedTransactions =
            List.from(accountSnapshot.get('transactions') ?? []);
        updatedTransactions.add(transactionData);
        transaction
            .update(accountDocRef, {'transactions': updatedTransactions});
      }
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Transaction submitted successfully")),
      );
      clearForm(); // Clear the form after successful submission
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit transaction: $error")),
      );
      print("Failed to submit transaction: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeffeff),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(4.0), // Set the height of the bottom border
          child: Container(
            color: Color(0xffeffeff), // Set the color of the bottom border
            height: 2.0, // Set the height of the bottom border
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: const Color(0xffeffeff),
        title: Text('$_formType Share Form',
            style: TextStyle(
                color: const Color(0xff202232),
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Button to switch between buy and sell forms
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2a52cd),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              setState(() {
                _formType = _formType == 'Buy' ? 'Sell' : 'Buy';
              });
            },
            child: Text('Switch to ${_formType == 'Buy' ? 'Sell' : 'Buy'} Form',
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Poppins')),
          ),
          const SizedBox(height: 16.0),
          // Account Name Dropdown
          // Account Name Dropdown
          DropdownButtonFormField<String>(
            value: selectedAccount,
            onChanged: (String? newValue) {
              setState(() {
                selectedAccount = newValue!;
              });
            },
            items: accountNames.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: const TextStyle(color: const Color(0xff202232))),
              );
            }).toList(),
            decoration: const InputDecoration(
              labelText: 'Select Account',
              labelStyle: TextStyle(color: const Color(0xff202232)),
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.white),
            dropdownColor: Colors.white,
          ),
          const SizedBox(height: 16.0),
          // Share Name Field
          TextFormField(
            controller: _shareNameController,
            decoration: const InputDecoration(
                labelText: 'Share Name',
                labelStyle: TextStyle(color: const Color(0xff202232))),
            style: const TextStyle(
                color: const Color(0xff202232), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          // Exchange Name Field
          TextFormField(
            controller: _exchangeNameController,
            decoration: const InputDecoration(
                labelText: 'Exchange Name',
                labelStyle: TextStyle(color: const Color(0xff202232))),
            style: const TextStyle(
                color: const Color(0xff202232), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          // Date Field
          TextFormField(
            controller: _dateController,
            decoration: InputDecoration(
                labelText:
                    'Date of ${_formType == 'Buy' ? 'Purchase' : 'Sale'}',
                labelStyle: const TextStyle(color: const Color(0xff202232))),
            style: const TextStyle(
                color: const Color(0xff202232), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          // Quantity Field
          TextFormField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: 'Quantity of Shares',
                labelStyle: TextStyle(color: const Color(0xff202232))),
            style: const TextStyle(
                color: const Color(0xff202232), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          // Price Per Share Field
          TextFormField(
            controller: _priceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
                labelText: 'Price Per Share',
                labelStyle: TextStyle(color: const Color(0xff202232))),
            style: const TextStyle(
                color: const Color(0xff202232), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          // Total Amount Field
          TextFormField(
            controller: _totalAmountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
                labelText: 'Total Amount',
                labelStyle: TextStyle(color: const Color(0xff202232))),
            style: const TextStyle(
                color: const Color(0xff202232), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          // Note Field
          TextFormField(
            controller: _noteController,
            decoration: const InputDecoration(
                labelText: 'Note',
                labelStyle: TextStyle(color: const Color(0xff202232))),
            style: const TextStyle(
                color: const Color(0xff202232), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32.0),
          // Submit Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2a52cd),
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _submitForm, // Call the submit form method here

            child: const Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers
    _shareNameController.dispose();
    _exchangeNameController.dispose();
    _dateController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _totalAmountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
