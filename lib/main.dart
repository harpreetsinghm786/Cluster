import 'package:cluster/helper/authservice.dart';
import 'package:cluster/screens/student/studentcreateProfile.dart';
import 'package:cluster/screens/student/studentsignin.dart';
import 'package:cluster/screens/student/studentprofile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,

        builder: (context, snapshot) {
          // Check for Errors
          if (snapshot.hasError) {
            print("Something Went Wrong>>"+snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                  child: CircularProgressIndicator(color: b4,)),
            );
          }

          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,

          ));

          return MaterialApp(


            title: 'Cluster',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(

              scaffoldBackgroundColor: Colors.white,

              textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.grey
              ),
            ),
             home:AuthService().handleAuth(),

            //home: CreateProfile(),
          );
        });
  }

}

