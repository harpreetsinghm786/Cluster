import 'package:cluster/helper/authhandler.dart';
import 'package:cluster/screens/student/studentdashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../helper/responsive.dart';

class studentlogin extends StatefulWidget {
  const studentlogin({Key? key}) : super(key: key);

  @override
  _studentloginState createState() => _studentloginState();
}

class _studentloginState extends State<studentlogin> {
  String? email, password;
  TextEditingController? _email, _password;
  final formKey = GlobalKey<FormState>();
  bool? load=false;


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
                        Responsive.istablet(context)?Container():Stack(
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
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                              style: getheadstyle(40,
                                                  FontWeight.normal, Colors.white),
                                              softWrap: true,
                                              textAlign: TextAlign.start,
                                            )),
                                        Container(
                                            child: Text(
                                              "Project Management System for Students",
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
                                        "Log In",
                                        style: getsimplestyle(24, FontWeight.w500, b4),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Enter Email and Password for Log In",
                                        style: getsimplestyle(13, FontWeight.w500, b4),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          height: 60,
                                          width: 400,
                                          margin: EdgeInsets.only(
                                              top: 30, left: 0, right: 0, bottom: 0),

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
                                              top: 30, left: 0, right: 0, bottom: 0),

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
                                            top: 30, left: 0, right: 0, bottom: 0),

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

                                              try {
                                                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                                    email: email!,
                                                    password: password!
                                                ).then((value) => {
                                                setState(() {
                                                load=false;
                                                }),
                                                  Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=>studentdashboard(activeindex: 0,)), (route) => false),

                                                });
                                              } on FirebaseAuthException catch (e) {
                                                if (e.code == 'user-not-found') {
                                                  setState(() {
                                                    load=false;
                                                  });
                                                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("No user found for that email.")));

                                                } else if (e.code == 'wrong-password') {
                                                  setState(() {
                                                    load=false;
                                                  });
                                                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Wrong password provided for that user.")));

                                                }
                                              }

                                            }


                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: Text(
                                            "Log In",
                                            style: getsimplestyle(
                                                15, FontWeight.normal, Colors.white),
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
                                            "Not having an account? ",
                                            style: getsimplestyle(
                                                13, FontWeight.w500, Colors.grey),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Sign In",
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

                  load==true? Container(
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
