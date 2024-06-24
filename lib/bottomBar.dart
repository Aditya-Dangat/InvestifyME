import 'package:flutter/material.dart';
import 'package:investifyme_1/homescreen.dart';
import 'package:investifyme_1/news.dart';
import 'dart:io';
// class BottomNavBar extends StatefulWidget {
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     HomeScreen(), // Use HomeScreen instead of HomePage
//     newsPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: Container(
//       decoration: BoxDecoration(
//             border: Border(
//               top: BorderSide(
//                 color: Colors.white, // Set border color here
//                 width: 2.0, // Set border width here
//               ),
//             ),
//           ),
//       child: BottomNavigationBar(
//         backgroundColor: Color(0xff202232),
//         currentIndex: _currentIndex,
//         onTap: _onTabTapped,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.newspaper),
//             label: 'Newspaper',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart),
//             label: 'Bar Chart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: 'Work',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Person',
//           ),
//         ],
//       ),
//       )
//     );

//   }

//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }


// class CustomBottomNavBar extends StatefulWidget {
//   final screens = [
//     HomeScreen(),
//     newsPage(),
//   ];
  
//   @override
//   _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   int currentIndex = 0;


//   @override
//   Widget build(BuildContext context) =>
//   Scaffold
//   (
    
//     body: IndexedStack(
//       children: screens,
//     )
//     BottomNavigationBar:BottomNavigationBar(
//       backgroundColor: Color(0xff202232),
//       selectedItemColor: Color(0xff2a52cd),
//       type:BottomNavigationBarType.fixed,
//       showUnselectedLabels: false,
//       currentIndex: currentIndex,
//       onTap: (index)=> setState(()=>currentIndex = index),
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.newspaper),
//           label: 'News',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.bar_chart),
//           label: 'Analysis',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.work),
//           label: 'Work',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//     ),
//   );
//   }


// class CustomBottomNavBar extends StatefulWidget {
//   @override
//   _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   final screens = [
//     HomeScreen(),
//     newsPage(),
//     // Add more screen instances for other tabs
//   ];

//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: currentIndex,
//         children: screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color(0xff202232),
//         selectedItemColor: Color(0xff2a52cd),
//         type: BottomNavigationBarType.fixed,
//         showUnselectedLabels: false,
//         currentIndex: currentIndex,
//         onTap: (index) => setState(() => currentIndex = index),
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.newspaper),
//             label: 'News',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart),
//             label: 'Analysis',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: 'Work',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BottomNavBar extends StatefulWidget {
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   // final screens = [
//   //   HomeScreen(),
//   //   newsPage(),
//     // Add more screen instances for other tabs
//   //];

//   // int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: IndexedStack(
//       //   index: currentIndex,
//       //   children: screens,
//       // ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color(0xff202232),
//         selectedItemColor: Color(0xff2a52cd),
//         type: BottomNavigationBarType.fixed,
//         showUnselectedLabels: false,
//         // currentIndex: currentIndex,
//         onTap: (int index) {_selectTab(pageKeys[index],index);},
//         currentIndex: _selectedIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.newspaper),
//             label: 'News',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart),
//             label: 'Analysis',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: 'Work',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }

// void _selectTab(String tabItem, int index){
//   setState((){
//     _currentIndex = pageKeys[index];
//     _selectedIndex = index;
//   }
//   );
// }