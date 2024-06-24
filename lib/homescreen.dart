// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:investifyme_1/bottomBar.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//   // static const String routeName = '/homepage';

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int myIndex = 0;
//   int buttonSelected = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         bottom: PreferredSize(
//           preferredSize:
//               const Size.fromHeight(3.0), // Set the height of the bottom border
//           child: Container(
//             color: Colors.white, // Set the color of the bottom border
//             height: 2.0, // Set the height of the bottom border
//           ),
//         ),
//         toolbarHeight: 80,
//         backgroundColor:Colors.white,
//         title: const Text('Hello ,\nWelcome to InvestifyMe',
//             style: TextStyle(color: Colors.white, fontSize: 15.0)),
//       ),
//       body: Column(
//         children: [
//           // App Bar
//           // Your app bar goes here

//           // Carousel Slider
//           // CarouselSlider(
//           //   items: [
//           //     Container(
//           //       decoration: BoxDecoration(

//           //         color: Colors.white,
//           //         borderRadius:
//           //             BorderRadius.circular(10.0), // Set the border radius
//           //       ),
//           //       child: Padding(
//           //         padding: const EdgeInsets.all(16.0),
//           //         child: Text(
//           //           "The single most important concept in investing is the time value of money.\n- Benjamin Graham",
//           //           style: TextStyle(color: const Color(0xff202232)),
//           //         ),
//           //       ),
//           //     ),
//           //     Container(
//           //       decoration: BoxDecoration(
//           //         color: Colors.white,
//           //         borderRadius:
//           //             BorderRadius.circular(10.0), // Set the border radius
//           //       ),
//           //       child: Padding(
//           //         padding: const EdgeInsets.all(16.0),
//           //         child: Text(
//           //           "The market can be irrational for months, but not forever. \n- John Maynard Keynes ",
//           //           style: TextStyle(color: const Color(0xff202232)),
//           //         ),
//           //       ),
//           //     ),
//           //     Container(
//           //       decoration: BoxDecoration(
//           //         color: Colors.white,
//           //         borderRadius:
//           //             BorderRadius.circular(10.0), // Set the border radius
//           //       ),
//           //       child: Padding(
//           //         padding: const EdgeInsets.all(16.0),
//           //         child: Text(
//           //           "Be fearful when others are greedy, and be greedy when others are fearful. \n- Warren Buffett",
//           //           style: TextStyle(color: const Color(0xff202232)),
//           //         ),
//           //       ),
//           //     ),
//           //   ],
//           //   options: CarouselOptions(
//           //     height: 100.0,
//           //     aspectRatio: 16 / 9,
//           //     autoPlay: true,
//           //     autoPlayInterval: const Duration(seconds: 2),
//           //     enlargeCenterPage: true,
//           //   ),
//           // ),

//           CarouselSlider(
//             items: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 padding: const EdgeInsets.all(16.0), // Adjust padding as needed
//                 child: Text(
//                   "The single most important concept in investing is the time value of money.\n- Benjamin Graham",
//                   style: TextStyle(color: const Color(0xff202232)),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 padding: const EdgeInsets.all(16.0), // Adjust padding as needed
//                 child: Text(
//                   "The market can be irrational for months, but not forever. \n- John Maynard Keynes ",
//                   style: TextStyle(color: const Color(0xff202232)),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 padding: const EdgeInsets.all(16.0), // Adjust padding as needed
//                 child: Text(
//                   "Be fearful when others are greedy, and be greedy when others are fearful. \n- Warren Buffett",
//                   style: TextStyle(color: const Color(0xff202232)),
//                 ),
//               ),
//             ],
//             options: CarouselOptions(
//               height: 150.0, // Adjust height as needed
//               aspectRatio: 16 / 9,
//               autoPlay: true,
//               autoPlayInterval: const Duration(seconds: 2),
//               enlargeCenterPage: true,
//             ),
//           ),

//           Expanded(
//             child: MyStockData(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyStockData extends StatefulWidget {
//   @override
//   _MyStockDataState createState() => _MyStockDataState();
// }

// class _MyStockDataState extends State<MyStockData> {
//   String _ticker = 'AAPL';
//   Map<String, dynamic>? _stock;

//   Future<void> _fetchStock() async {
//     var url = Uri.https('stock-price-by-api-ninjas.p.rapidapi.com',
//         '/v1/stockprice', {'ticker': _ticker});
//     var headers = {
//       'X-RapidAPI-Key': '278e8723c9msh554f917e8019544p1ffa0djsn2f9a760441f8',
//       'X-RapidAPI-Host': 'stock-price-by-api-ninjas.p.rapidapi.com'
//     };

//     var response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       setState(() {
//         _stock = jsonDecode(response.body);
//       });
//     } else {
//       print('Error: ${response.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Theme(
//             data: Theme.of(context).copyWith(
//               textTheme: Theme.of(context).textTheme.apply(
//                     bodyColor: Colors.white,
//                     displayColor: Colors.white,
//                   ),
//             ),
//             child: TextField(
//               decoration: const InputDecoration(
//                 labelText: 'Ticker Symbol',
//                 hintText: 'Enter a ticker symbol (e.g. AAPL)',
//                 hintStyle: TextStyle(fontSize: 18.0, color: Colors.white24),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _ticker = value;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           ElevatedButton(
//             onPressed: _fetchStock,
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.white,
//               backgroundColor: Colors.blue,
//             ),
//             child: const Text(
//               'Fetch Stock',
//               style: TextStyle(fontSize: 18.0, color: Colors.white),
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           if (_stock != null)
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Name: ${_stock!['name']}',
//                   style: const TextStyle(fontSize: 18.0, color: Colors.white),
//                 ),
//                 const SizedBox(height: 4.0),
//                 Text(
//                   'Price: ${_stock!['price'].toStringAsFixed(2)}',
//                   style: const TextStyle(fontSize: 18.0, color: Colors.white),
//                 ),
//                 const SizedBox(height: 4.0),
//                 Text(
//                   'Exchange: ${_stock!['exchange']}',
//                   style: const TextStyle(fontSize: 18.0, color: Colors.white),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;
  int buttonSelected = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeffeff),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Color(0xffeffeff),
            height: 2.0,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: Color(0xffeffeff),
        title: const Text('Welcome to InvestifyMe!! ',
            style: TextStyle(
                color: const Color(0xff202232),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/1.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/2.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/3.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 120.0,
              aspectRatio: 16 / 9,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              enlargeCenterPage: true,
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Top Stocks For Today',
                style: TextStyle(
                    fontSize: 20,
                    color: const Color(0xff202232),
                    fontFamily: 'Poppins'),
              ),
            ),
          ),
          Expanded(
            child: MyStockData(),
          ),
        ],
      ),
    );
  }
}

class MyStockData extends StatefulWidget {
  @override
  _MyStockDataState createState() => _MyStockDataState();
}

class _MyStockDataState extends State<MyStockData> {
  String _ticker = 'AAPL';
  Map<String, dynamic>? _stock;

  List<Map<String, String>> companyList = [
    {'Company': 'Tata Consultancy Services', 'Industry': 'IT Services'},
    {'Company': 'Hindustan Unilever', 'Industry': 'Consumer Goods'},
    {'Company': 'Infosys', 'Industry': 'IT Services'},
    {'Company': 'HDFC Bank', 'Industry': 'Banking'},
    {'Company': 'Reliance Industries', 'Industry': 'Conglomerate'},
    {'Company': 'Bajaj Finance', 'Industry': 'Financial Services'},
    {'Company': 'Larsen & Toubro', 'Industry': 'Engineering and Construction'},
    {'Company': 'ITC', 'Industry': 'Tobacco and FMCG'},
    {'Company': 'ICICI Bank', 'Industry': 'Banking'},
    {'Company': 'Godrej Consumer Products', 'Industry': 'FMCG'},
  ];

  // Dummy data for stock prices and exchanges (replace with actual data)
  Map<String, Map<String, dynamic>> stockData = {
    'Tata Consultancy Services': {'Price': 3838.00, 'Exchange': 'NSE'},
    'Hindustan Unilever': {'Price': 2213.95, 'Exchange': 'BSE'},
    'Infosys': {'Price': 1415.75, 'Exchange': 'NYSE'},
    'HDFC Bank': {'Price': 1515.65, 'Exchange': 'NSE'},
    'Reliance Industries': {'Price': 2871.00, 'Exchange': 'BSE'},
    'Bajaj Finance': {'Price': 6927.00, 'Exchange': 'NSE'},
    'Larsen & Toubro': {'Price': 3500.00, 'Exchange': 'BSE'},
    'ITC': {'Price': 436.00, 'Exchange': 'NSE'},
    'ICICI Bank': {'Price': 1139.90, 'Exchange': 'NYSE'},
    'Godrej Consumer Products': {'Price': 1246.55, 'Exchange': 'BSE'},
  };

  Future<void> _fetchStock() async {
    var url = Uri.https('stock-price-by-api-ninjas.p.rapidapi.com',
        '/v1/stockprice', {'ticker': _ticker});
    var headers = {
      'X-RapidAPI-Key': '278e8723c9msh554f917e8019544p1ffa0djsn2f9a760441f8',
      'X-RapidAPI-Host': 'stock-price-by-api-ninjas.p.rapidapi.com'
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        _stock = jsonDecode(response.body);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  void _closeContainer() {
    setState(() {
      _stock = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center(
            // child:
            // Theme(
            //   data: Theme.of(context).copyWith(
            //     textTheme: Theme.of(context).textTheme.apply(
            //           bodyColor: const Color(0xff202232),
            //           displayColor: const Color(0xff202232),
            //         ),
            //   ),
            //   child: Center(
            //     child: TextField(
            //       decoration: InputDecoration(
            //         labelText: 'Ticker Symbol',
            //         hintText: 'Enter a ticker symbol (e.g. AAPL)',
            //         hintStyle:
            //             TextStyle(fontSize: 15.0, color: const Color(0xff202232)),
            //       ),
            //       onChanged: (value) {
            //         setState(() {
            //           _ticker = value;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Center(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.apply(
                          bodyColor: const Color(0xff202232),
                          displayColor: const Color(0xff202232),
                        ),
                  ),
                  child: Column(
                    children: [
                      // Text(
                      //   'Ticker Symbol',
                      //   style: TextStyle(
                      //       fontSize: 15.0, color: const Color(0xff202232)),
                      // ),
                      SizedBox(
                          height:
                              8.0), // Adding some space between the text and TextField
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter a ticker symbol (e.g. AAPL)',
                          hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: const Color(0xff202232),
                              fontFamily: 'Poppins'),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _ticker = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0),
            // Center(
            //   child: ElevatedButton(

            //     onPressed: _fetchStock,
            //     style: ElevatedButton.styleFrom(
            //       foregroundColor: Colors.white,
            //       backgroundColor: const Color(0xff2a52cd),
            //     ),
            //     child: Text(
            //       'Fetch Stock',
            //       style: TextStyle(fontSize: 15.0, color: Colors.white),
            //     ),
            //   ),
            // ),

            Center(
              child: SizedBox(
                height: 50.0, // Set the desired height
                width: 200.0, // Set the desired width
                child: ElevatedButton(
                  onPressed: _fetchStock,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the desired border radius
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xff2a52cd),
                  ),
                  child: Text(
                    'FETCH STOCK',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: companyList.length,
                itemBuilder: (context, index) {
                  final company = companyList[index]['Company']!;
                  final industry = companyList[index]['Industry']!;
                  final price = stockData[company]!['Price']!;
                  final exchange = stockData[company]!['Exchange']!;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff202232),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          '$company - $industry',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontFamily: 'Poppins'),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price: \₹${price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white70,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              'Exchange: $exchange',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white70,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        if (_stock != null)
          Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name: ${_stock!['name']}',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontFamily: 'Poppins'),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: _closeContainer,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Price: ₹${_stock!['price'].toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Exchange: ${_stock!['exchange']}',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
