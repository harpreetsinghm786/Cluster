import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../helper/authhandler.dart';
import '../../helper/responsive.dart';
import 'studentlogin.dart';

class studentcreateprofile extends StatefulWidget {
  String? email, password;
  studentcreateprofile({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  _studentcreateprofileState createState() =>
      _studentcreateprofileState(email: this.email, password: this.password);
}

class _studentcreateprofileState extends State<studentcreateprofile> {
  String? email, password;
  String? username, title, branch;
  TextEditingController? _username, _title;
  final formKey = GlobalKey<FormState>();
  bool? load = false;
  String dropdownValuegender = 'First';

  _studentcreateprofileState({this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Responsive.istablet(context)
                            ? Container()
                            : Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: b1,
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: b2,
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: b3,
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: b4,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                child: Image(
                                              image: AssetImage(
                                                "assets/images/cluster.png",
                                              ),
                                              height: 200,
                                              width: 200,
                                            )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                child: Text(
                                              "Cluster",
                                              style: getheadstyle(
                                                  40,
                                                  FontWeight.normal,
                                                  Colors.white),
                                              softWrap: true,
                                              textAlign: TextAlign.start,
                                            )),
                                            Container(
                                                child: Text(
                                              "Project Management System for Students",
                                              style: getsimplestyle(
                                                  10,
                                                  FontWeight.normal,
                                                  Colors.white),
                                              softWrap: true,
                                              textAlign: TextAlign.start,
                                            )),
                                          ],
                                        ),
                                      ),

                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Poweredby EE IITR \n © Copyright 2022-2023",
                                              style: getsimplestyle(
                                                  10,
                                                  FontWeight.normal,
                                                  Colors.white),
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                            )),
                                      ),

                                      //9417636424
                                    ],
                                  ),
                                )
                              ],
                            ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Create Profile",
                                        style: getsimplestyle(
                                            24, FontWeight.w500, b4),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Enter Required Information to Create Your Account",
                                        style: getsimplestyle(
                                            13, FontWeight.w500, b4),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          height: 60,
                                          width: 400,
                                          margin: EdgeInsets.only(
                                              top: 30,
                                              left: 0,
                                              right: 0,
                                              bottom: 0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: usernamefield(),
                                              ),
                                            ],
                                          )),
                                      Container(
                                          height: 60,
                                          width: 400,
                                          margin: EdgeInsets.only(
                                              top: 30,
                                              left: 0,
                                              right: 0,
                                              bottom: 0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: titlefield(),
                                              ),
                                            ],
                                          )),
                                      Container(
                                          height: 50,
                                          width: 400,
                                          padding: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(width: 1, color: b4),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          margin: EdgeInsets.only(
                                              top: 30,
                                              left: 0,
                                              right: 0,
                                              bottom: 0),
                                          alignment: Alignment.centerLeft,
                                          child: buildGenderDropdown()),
                                      Container(
                                        height: 50,
                                        width: 400,
                                        margin: EdgeInsets.only(
                                            top: 30,
                                            left: 0,
                                            right: 0,
                                            bottom: 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: b4),
                                        child: FlatButton(
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                load = true;
                                              });
                                              formKey.currentState!.save();

                                              try {
                                                final credential = await FirebaseAuth
                                                    .instance
                                                    .createUserWithEmailAndPassword(
                                                      email: email!,
                                                      password: password!,
                                                    )
                                                    .then((value) => {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection("studentdata")
                                                              .doc(
                                                                  value.user!.uid)
                                                              .set({
                                                            "name": username,
                                                            "title": title,
                                                            "year": dropdownValuegender,
                                                            "language":[],
                                                            "introvideo":"null",
                                                            "education":[],
                                                            "availability":false,
                                                            "cover":"null",
                                                            "skills":[],
                                                            "works":[],
                                                            "role":"student",
                                                            "uid":FirebaseAuth.instance.currentUser!.uid,
                                                              }),
                                                          studentLoginnow(email,
                                                              password, context)
                                                        });
                                              } on FirebaseAuthException catch (e) {
                                                if (e.code == 'weak-password') {
                                                  setState(() {
                                                    load = false;
                                                  });
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(new SnackBar(
                                                          content: Text(
                                                              "The password provided is too weak.")));
                                                } else if (e.code ==
                                                    'email-already-in-use') {
                                                  setState(() {
                                                    load = false;
                                                  });
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(new SnackBar(
                                                          content: Text(
                                                              "The account already exists for that email.")));
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Text(
                                            "Done",
                                            style: getsimplestyle(15,
                                                FontWeight.normal, Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Already have an account? ",
                                            style: getsimplestyle(
                                                13, FontWeight.w500, Colors.grey),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          studentlogin()));
                                            },
                                            child: Text(
                                              "LogIn",
                                              style: getsimplestyle(
                                                  13, FontWeight.w500, b4),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Responsive.istablet(context)
                      ? Stack(
                          children: [
                            Container(
                              height: 60,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: b1,
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: b2,
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: b3,
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: b4,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            child: Image.asset(
                                                "assets/images/cluster.png"),
                                          ),
                                          Text(
                                            "luster",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.normal),
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  load == true
                      ? Container(
                          color: glass,
                          child: Center(
                            child: Center(
                                child: CircularProgressIndicator(
                              color: b4,
                            )),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //username
  //title
  //year
  //branch

  TextFormField usernamefield() {
    return TextFormField(
      onSaved: (newValue) => username = newValue!,
      controller: _username,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Username';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.account_circle_outlined,
          color: Colors.grey,
          size: 20,
        ),

        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        // errorStyle: TextStyle(fontSize: 12, height: 0.1),
        hintStyle: getsimplestyle(14, FontWeight.normal, Colors.grey),
        hintText: "Username",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }

  TextFormField titlefield() {
    return TextFormField(
      onSaved: (newValue) => title = newValue!,
      controller: _title,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Profile title';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.star,
          color: Colors.grey,
          size: 20,
        ),
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        hintStyle: getsimplestyle(14, FontWeight.normal, Colors.grey),
        hintText: "Title",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }



  Container buildGenderDropdown() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: DropdownButton<String>(
        onTap: removeFocus,
        menuMaxHeight: 200,

        value: dropdownValuegender,
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: b4,
        ),
        iconSize: 24,
        dropdownColor: Colors.white,
        iconEnabledColor: Colors.grey,
        borderRadius: BorderRadius.circular(10),
        elevation: 16,
        itemHeight: 50,
        underline: Container(
          width: double.infinity,
          height: 1,
          color: Colors.transparent,
        ),
        style: const TextStyle(color: Colors.green),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValuegender = newValue!;
          });
        },
        items: <String>['First', 'Sencond', 'Third', 'Fourth']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                value,
                style: getsimplestyle(13, FontWeight.normal, b4),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  removeFocus() {
    FocusScope.of(context).unfocus();
  }
}
