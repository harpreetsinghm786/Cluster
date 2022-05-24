import 'package:cluster/screens/student/studentdashboard.dart';
import 'package:cluster/screens/student/studentsignin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




Signinnow(String? email,String? password,BuildContext context) async {
  try {
    final credential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    ).then((value) =>  Loginnow(email,password,context));

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("The password provided is too weak.")));

    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("The account already exists for that email.")));

    }
  } catch (e) {
    print(e);
  }
}

Loginnow(String? email, String? password,BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    ).then((value) => {Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=>Dashboard()), (route) => false)});
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
       ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("No user found for that email.")));

    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Wrong password provided for that user.")));

    }
  }


}

Logoutnow(BuildContext context) async {
  await FirebaseAuth.instance.signOut().then((value) => Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=>studentsignin()), (route) => false));
}