import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster/screens/Landing.dart';
import 'package:cluster/screens/faculty/facultydashboard.dart';
import 'package:cluster/screens/faculty/selectproposal.dart';
import 'package:cluster/screens/student/studentdashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';



class AuthService {

  handleAuth() {
    var stream=FirebaseFirestore.instance.collection("studentdata");
    return StreamBuilder(

    stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                  child: CircularProgressIndicator(
                    color: b3,
                  )),
            );
          }
          if (snapshot.hasData) {

           return StreamBuilder<QuerySnapshot>(
              stream: stream.snapshots() ,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData ) {
                  List docs=snapshot.data!.docs;
                  for(int i=0;i<docs.length;i++){
                    if(docs[i]["uid"]==FirebaseAuth.instance.currentUser!.uid){
                     return studentdashboard(activeindex: 0,);
                    }
                  }
                  //return selectproposal();
                  return facultydashboard();
                }
                return Container(
                  color: Colors.white,
                  child: Center(
                      child: CircularProgressIndicator(
                        color: b3,
                      )),
                );
              }
            );

          }
          return Landing();
          //return MapView();
        });
  }

}