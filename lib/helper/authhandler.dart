import 'package:cluster/screens/Landing.dart';
import 'package:cluster/screens/faculty/facultydashboard.dart';
import 'package:cluster/screens/student/studentdashboard.dart';
import 'package:cluster/screens/student/studentsignin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





studentLoginnow(String? email, String? password,BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    ).then((value) => {Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=> studentdashboard(activeindex: 0,)), (route) => false)});
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
       ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("No user found for that email.")));

    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Wrong password provided for that user.")));

    }
  }


}

facultyLoginnow(String? email, String? password,BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    ).then((value) => {Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=> facultydashboard()), (route) => false)});
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("No user found for that email.")));

    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Wrong password provided for that user.")));

    }
  }


}

Logoutnow(BuildContext context) async {
  await FirebaseAuth.instance.signOut().then((value) => Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=>Landing()), (route) => false));
}