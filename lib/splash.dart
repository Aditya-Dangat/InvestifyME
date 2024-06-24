import 'package:flutter/material.dart';
import 'package:investifyme_1/utils/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.loginRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xffeffeff),
        child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                //body: SafeArea(

                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        Image.asset(
                          "assets/images/logopf.png"
                          // fit: BoxFit.fill
                          ,
                          width: 250,
                          height: 300,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'PERSONALIZED',
                          style: TextStyle(
                              color: const Color(0xff1580C2),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          'INVESTING',
                          style: TextStyle(
                              color: const Color(0xff1580C2),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          'JUST FOR YOU.',
                          style: TextStyle(
                              color: const Color(0xff202232),
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 90.0,
                        ),
                        Material(
                          color: Color(0xff1580C2),
                          borderRadius:
                              BorderRadius.circular(changeButton ? 50.0 : 25.0),
                          child: InkWell(
                            onTap: () async => moveToHome(context),
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              width: changeButton
                                  ? 50
                                  : MediaQuery.of(context).size.width * 0.5,
                              height: 60,
                              alignment: Alignment.center,
                              child: changeButton
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : Text("GET STARTED",
                                      style: TextStyle(
                                          color: const Color(0xfffeffeff),
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins')),
                            ),
                          ),
                        ),
                      ]),
                ))));
  }
}
