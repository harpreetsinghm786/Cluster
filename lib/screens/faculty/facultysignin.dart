import 'package:cluster/screens/faculty/facultycreateprofile.dart';
import 'package:cluster/screens/faculty/facultylogin.dart';
import 'package:cluster/screens/student/studentcreateProfile.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../helper/responsive.dart';
import '../student/studentlogin.dart';

class facultysignin extends StatefulWidget {
  const facultysignin({Key? key}) : super(key: key);

  @override
  _facultysigninState createState() => _facultysigninState();
}

class _facultysigninState extends State<facultysignin> {

  String? email, password;
  TextEditingController? _email, _password;
  final formKey = GlobalKey<FormState>();
  bool load=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email=new TextEditingController();
    _password=new TextEditingController();
  }
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
                  Row(
                    children: [
                      Responsive.istablet(context)?Container(): Expanded(
                        flex: 1,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
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
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              child:FadeInImage.assetNetwork(

                                                image: 'assets/images/cluster.png',
                                                height: 200,
                                                width: 200,
                                                placeholder:'assets/images/cluster.png',
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              child: Text(
                                                "Cluster",
                                                style: getheadstyle(40,
                                                    FontWeight.normal, Colors.white),
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                              )),
                                          Container(
                                              child: Text(
                                                "Project Management System for Faculty",
                                                style: getsimplestyle(10,
                                                    FontWeight.normal, Colors.white),
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
                                            style: getsimplestyle(10,
                                                FontWeight.normal, Colors.white),
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                          )),
                                    ),

                                    //9417636424
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
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
                                      "Sign Up",
                                      style:
                                      getsimplestyle(24, FontWeight.w500, b4),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Enter Email and Password to create your account",
                                      style:
                                      getsimplestyle(13, FontWeight.w500, b4),
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
                                            right: 0,
                                            bottom: 0),

                                        alignment: Alignment.centerLeft,

                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: emailfield(),
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
                                              child: passfield(),
                                            ),
                                          ],
                                        )),
                                    Container(
                                      height: 50,
                                      width: 400,
                                      margin: EdgeInsets.only(
                                          top: 30, left:0, right: 0, bottom: 0),

                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: b4),
                                      child: FlatButton(
                                        onPressed: () async {
                                          if (formKey.currentState!.validate()) {
                                            setState(() {
                                              load=true;
                                            });
                                            formKey.currentState!.save();

                                            setState(() {
                                              load=false;
                                            });
                                            //print(password);
                                            Navigator.push(context, new MaterialPageRoute(builder: (context)=>facultycreateprofile(email: email!,password: password!,)));


                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          "Sign Up",
                                          style: getsimplestyle(
                                              14, FontWeight.normal, Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                                    builder: (context) => facultylogin()));
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
                  Responsive.istablet(context)?Stack(
                    children: [
                      Container(
                        height: 60,
                        child:   Row(
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
                              flex:8,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      child: Image.asset("assets/images/cluster.png"),
                                    ),
                                    Text(
                                      "luster",
                                      style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal),
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                    )
                                  ],),
                              ),
                            ),






                          ],
                        ),
                      ),
                    ],
                  ):Container(),
                  load? Container(
                    color: glass,
                    child: Center(
                      child: Center(
                          child: CircularProgressIndicator(
                            color: b4,
                          )),
                    ),
                  ):Container()
                ],

              ),
            ),
          ],
        ),
      ),
    );


  }


  TextFormField emailfield() {
    return TextFormField(
      onSaved: (newValue) => email = newValue!,
      controller: _email,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Email';
        } else if (!regExp.hasMatch(value.toString())) {
          return 'Please Enter Valid Email';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(

        suffixIcon: Icon(
          Icons.email,
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
        hintText: "Email",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left:11),

      ),
    );
  }

  TextFormField passfield() {
    return TextFormField(

      onSaved: (newValue) => password = newValue!,
      controller: _password,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Password';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(

        suffixIcon: Icon(
          Icons.lock,
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
        hintText: "Password",

        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left:11),
      ),
    );
  }
}
