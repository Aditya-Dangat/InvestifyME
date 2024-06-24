import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:investifyme_1/homePage.dart';
import 'package:investifyme_1/portfolio.dart';
import 'package:investifyme_1/profilepage.dart';
import 'package:investifyme_1/signup.dart';
import 'package:investifyme_1/splash.dart';
import 'package:investifyme_1/homescreen.dart';
import 'package:investifyme_1/stats.dart';
import 'package:investifyme_1/utils/routes.dart';
import 'package:investifyme_1/login.dart';
import 'package:investifyme_1/news.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAkVohiauBRHzsam-k8X-o5nPJC9uE4xwo', 
      authDomain: 'investify-5c9ee.firebaseapp.com',
      projectId: 'investify-5c9ee',
      storageBucket: 'investify-5c9ee.appspot.com',
      messagingSenderId: '227284515983',
      appId: '1:227284515983:android:ca96c276ec41ebbc07c4fa',
    ),
  );
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "splash",
      routes: {
        "splash": (context) => SplashPage(),
        "login": (context) => LoginPage(),
        "home": (context) => BottomBar(controller: _controller),
        // MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.splashRoute: (context) => SplashPage(),
        MyRoutes.homescreenRoute: (context) => const HomeScreen(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.signupRoute: (context) => SignupScreen(),
        MyRoutes.newsRoute: (context) => newsPage(),
        MyRoutes.statsRoute: (context) => const Stats(),
        MyRoutes.portfolioRoute: (context) => const Portfolio(),
        MyRoutes.profileRoute: (context) => ProfilePage(),
      },
    );
  }
}

class BottomBar extends StatefulWidget {
  final PersistentTabController controller;

  const BottomBar({Key? key, required this.controller}) : super(key: key);
  

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: widget.controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: const Color(0xff202232),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      newsPage(),
      const Stats(),
      const Portfolio(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded),
        title: ("Homepage"),
        activeColorPrimary: const Color(0xff2a52cd),
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "MyRoutes.homeRoute",
          routes: {
            MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.splashRoute: (context) => SplashPage(),
            MyRoutes.homescreenRoute: (context) => const HomeScreen(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.signupRoute: (context) => SignupScreen(),
            MyRoutes.newsRoute: (context) => newsPage(),
            MyRoutes.statsRoute: (context) => const Stats(),
            MyRoutes.portfolioRoute: (context) => const Portfolio(),
            MyRoutes.profileRoute: (context) => ProfilePage(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.newspaper_rounded),
        title: ("Updates"),
        activeColorPrimary: const Color(0xff2a52cd),
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "MyRoutes.newsRoute",
          routes: {
            MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.splashRoute: (context) => SplashPage(),
            MyRoutes.homescreenRoute: (context) => const HomeScreen(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.signupRoute: (context) => SignupScreen(),
            MyRoutes.newsRoute: (context) => newsPage(),
            MyRoutes.statsRoute: (context) => const Stats(),
            MyRoutes.portfolioRoute: (context) => const Portfolio(),
            MyRoutes.profileRoute: (context) => ProfilePage(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.stacked_line_chart_rounded),
        title: ("Analysis"),
        activeColorPrimary: const Color(0xff2a52cd),
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "MyRoutes.statsRoute",
          routes: {
            MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.splashRoute: (context) => SplashPage(),
            MyRoutes.homescreenRoute: (context) => const HomeScreen(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.signupRoute: (context) => SignupScreen(),
            MyRoutes.newsRoute: (context) => newsPage(),
            MyRoutes.statsRoute: (context) => const Stats(),
            MyRoutes.portfolioRoute: (context) => const Portfolio(),
            MyRoutes.profileRoute: (context) => ProfilePage(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.post_add_rounded),
        title: ("Portfolio"),
        activeColorPrimary: const Color(0xff2a52cd),
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "MyRoutes.portfolioRoute",
          routes: {
            MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.splashRoute: (context) => SplashPage(),
            MyRoutes.homescreenRoute: (context) => const HomeScreen(),
            MyRoutes.loginRoute:(context) => LoginPage(),
            MyRoutes.signupRoute: (context) => SignupScreen(),
            MyRoutes.newsRoute: (context) => newsPage(),
            MyRoutes.statsRoute: (context) => const Stats(),
            MyRoutes.portfolioRoute: (context) => const Portfolio(),
            MyRoutes.profileRoute: (context) => ProfilePage(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.people_alt_rounded),
        title: ("User"),
        activeColorPrimary: const Color(0xff2a52cd),
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "MyRoutes.profileRoute",
          routes: {
            MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.splashRoute: (context) => SplashPage(),
            MyRoutes.homescreenRoute: (context) => const HomeScreen(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.signupRoute: (context) => SignupScreen(),
            MyRoutes.newsRoute: (context) => newsPage(),
            MyRoutes.statsRoute: (context) => const Stats(),
            MyRoutes.portfolioRoute: (context) => const Portfolio(),
            MyRoutes.profileRoute: (context) => ProfilePage(),
          },
        ),
      ),
    ];
  }
}

