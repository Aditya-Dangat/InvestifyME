import 'package:flutter/material.dart';
import 'package:investifyme_1/homescreen.dart';
import 'package:investifyme_1/login.dart';
import 'package:investifyme_1/main.dart';
import 'package:investifyme_1/news.dart';
import 'package:investifyme_1/portfolio.dart';
import 'package:investifyme_1/profilepage.dart';
import 'package:investifyme_1/signup.dart';
import 'package:investifyme_1/splash.dart';
import 'package:investifyme_1/stats.dart';
import 'package:investifyme_1/utils/routes.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

//  THIS PAGE WILL ACT LIKE A MAIN.DART FILE FOR THE APP WHERE BOTTOM BAR WORKS

class HomePage extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  HomePage({super.key});

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_rounded),
        title: ("Homepage"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: MyRoutes.homescreenRoute,
          routes: {
            "splash": (context) => SplashPage(),
            "login": (context) => LoginPage(),
            "home": (context) => BottomBar(controller: _controller),
            // MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.splashRoute: (context) => SplashPage(),
            MyRoutes.homescreenRoute: (context) => HomeScreen(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.signupRoute: (context) => SignupScreen(),
            MyRoutes.newsRoute: (context) => newsPage(),
            MyRoutes.statsRoute: (context) => Stats(),
            MyRoutes.portfolioRoute: (context) => Portfolio(),
            MyRoutes.profileRoute: (context) => ProfilePage(),
          },
        ),
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.newspaper_rounded),
        title: ("Updates"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: MyRoutes.newsRoute,
          routes: {
            "splash": (context) => SplashPage(),
            "login": (context) => LoginPage(),
            "home": (context) => BottomBar(controller: _controller),
            // MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.splashRoute: (context) => SplashPage(),
            MyRoutes.homescreenRoute: (context) => HomeScreen(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.signupRoute: (context) => SignupScreen(),
            MyRoutes.newsRoute: (context) => newsPage(),
            MyRoutes.statsRoute: (context) => Stats(),
            MyRoutes.portfolioRoute: (context) => Portfolio(),
            MyRoutes.profileRoute: (context) => ProfilePage(),
          },
        ),
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.stacked_line_chart_rounded),
        title: ("Stats"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: MyRoutes.statsRoute,
          routes: {
            "splash": (context) => SplashPage(),
            "login": (context) => LoginPage(),
            "home": (context) => BottomBar(controller: _controller),
            // MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.splashRoute: (context) => SplashPage(),
            MyRoutes.homescreenRoute: (context) => HomeScreen(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.signupRoute: (context) => SignupScreen(),
            MyRoutes.newsRoute: (context) => newsPage(),
            MyRoutes.statsRoute: (context) => Stats(),
            MyRoutes.portfolioRoute: (context) => Portfolio(),
            MyRoutes.profileRoute: (context) => ProfilePage(),
          },
        ),
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.post_add_rounded),
        title: ("Portfolio"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: MyRoutes.portfolioRoute,
          routes: {
            "splash": (context) => SplashPage(),
            "login": (context) => LoginPage(),
            "home": (context) => BottomBar(controller: _controller),
            // MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.splashRoute: (context) => SplashPage(),
            MyRoutes.homescreenRoute: (context) => HomeScreen(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.signupRoute: (context) => SignupScreen(),
            MyRoutes.newsRoute: (context) => newsPage(),
            MyRoutes.statsRoute: (context) => Stats(),
            MyRoutes.portfolioRoute: (context) => Portfolio(),
            MyRoutes.profileRoute: (context) => ProfilePage(),
          },
        ),
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.people_alt_rounded),
        title: ("User"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: MyRoutes.profileRoute,
          routes: {
            "splash": (context) => SplashPage(),
            "login": (context) => LoginPage(),
            "home": (context) => BottomBar(controller: _controller),
            // MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.splashRoute: (context) => SplashPage(),
            MyRoutes.homescreenRoute: (context) => HomeScreen(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.signupRoute: (context) => SignupScreen(),
            MyRoutes.newsRoute: (context) => newsPage(),
            MyRoutes.statsRoute: (context) => Stats(),
            MyRoutes.portfolioRoute: (context) => Portfolio(),
            MyRoutes.profileRoute: (context) => ProfilePage(),
          },
        ),
      ),
      // Add other bottom navigation bar items here
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Bar Module',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.indigo,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
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
          ),
        );
      },
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      newsPage(),
      Stats(),
      Portfolio(),
      ProfilePage(),
    ];
  }
}



