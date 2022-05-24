import 'package:cluster/Components/footer.dart';
import 'package:cluster/helper/responsive.dart';
import 'package:cluster/screens/faculty/facultysignin.dart';
import 'package:cluster/screens/student/studentsignin.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../Components/animatedcircularprogress.dart';
import '../constants.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  double pageheight=820;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                          child: Container(
                            height: pageheight,
                            color: b1,
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: pageheight,
                            color: b2,
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: pageheight,
                            color: b3.withOpacity(0.90),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: pageheight,
                            color: b4.withOpacity(0.90),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: pageheight,
                            color: b7.withOpacity(0.90),
                          )),
                    ],
                  ),

                  MediaQuery.of(context).size.width<1436?Column(
                    children: [


                      SizedBox(height: 70,),

                      Stack(
                        alignment: Alignment.center,
                        children: [


                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right:  MediaQuery.of(context).size.width<1436? 30:0),
                            child: Image.asset("assets/images/cluster.png",height:  MediaQuery.of(context).size.width<1436?320: pageheight,),
                          ),

                          Container(
                              height:   MediaQuery.of(context).size.width<1436?130: 300,
                              width:   MediaQuery.of(context).size.width<1436?130: 300,
                              alignment:MediaQuery.of(context).size.width<1436?Alignment.center: Alignment.centerRight,
                              margin: EdgeInsets.only(right:   MediaQuery.of(context).size.width<1436?0: 200),
                              child: AnimatedCircularProgressbarIndicator(
                                percentage: 1,
                                label: "Free and Relaible",
                              ))
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30,),

                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(

                                "Pick Your Project",
                                style: getheadstyle(35,
                                    FontWeight.normal, Colors.white),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(height: 20,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Clsuter is the Project Mangement and Distribution system for Both Students and Faculty of Electrical Engineering Department IIT Roorkee. ",
                                style: getsimplestyle(13,
                                    FontWeight.w400, b5),

                                softWrap: true,
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(height: 10,),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Get Ready to select a project or Find a team according to your skill sets and Experties.",
                                style: getsimplestyle(13,
                                    FontWeight.w400, b5),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(height: 10,),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Cluster is Completely free and Available for both",
                                style: getsimplestyle(13,
                                    FontWeight.w400, b5),
                                softWrap: true,
                                textAlign: TextAlign.start,
                              )),

                          SizedBox(height: 40,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                decoration: BoxDecoration( borderRadius: BorderRadius.circular(50),
                                    border: Border.all(width: 0.7,color: Colors.white)),
                                child: FlatButton(
                                    padding: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),),

                                    onPressed: (){
                                      Navigator.push(context, new MaterialPageRoute(builder: (context)=>facultysignin()));
                                    }, child:  Text("Faculty",style: getsimplestyle(14, FontWeight.normal, Colors.white),)),
                              ),
                              SizedBox(width: 20,),

                              Container(
                                width: 200,
                                decoration: BoxDecoration( borderRadius: BorderRadius.circular(50),
                                    border: Border.all(width: 0.7,color: finalgrey)),
                                child: FlatButton(
                                    color: b4,
                                    padding: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),),

                                    onPressed: (){
                                      Navigator.push(context, new MaterialPageRoute(builder: (context)=>studentsignin()));
                                    }, child:  Text("Student",style: getsimplestyle(14, FontWeight.normal,Colors.white),)),
                              ),
                            ],
                          ),



                        ],
                      )

                    ],
                  ): Row(
                    children: [

                      Expanded(
                          flex: 1,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 100,right: 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                        child: Text(
                                          "Pick Your Project",
                                          style: getheadstyle(60,
                                              FontWeight.normal, Colors.white),
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                        )),
                                    SizedBox(height: 20,),
                                    Container(
                                        child: Text(
                                          "Clsuter is the Project Mangement and Distribution system for Both Students and Faculty of Electrical Engineering Department IIT Roorkee. ",
                                          style: getsimplestyle(14,
                                              FontWeight.w400, b5),
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                        )),
                                    SizedBox(height: 10,),
                                    Container(
                                        child: Text(
                                          "Get Ready to select a project or Find a team according to your skill sets and Experties.",
                                          style: getsimplestyle(14,
                                              FontWeight.w400, b5),
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                        )),
                                    SizedBox(height: 10,),
                                    Container(
                                        child: Text(
                                          "Cluster is Completely free and Available for both",
                                          style: getsimplestyle(14,
                                              FontWeight.w400, b5),
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                        )),

                                    SizedBox(height: 40,),

                                    Row(
                                      children: [
                                        Container(
                                          width: 200,
                                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(50),
                                              border: Border.all(width: 0.7,color: Colors.white)),
                                          child: FlatButton(
                                              padding: EdgeInsets.all(20),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50),),

                                              onPressed: (){
                                                Navigator.push(context, new MaterialPageRoute(builder: (context)=>facultysignin()));
                                              }, child:  Text("Faculty",style: getsimplestyle(14, FontWeight.normal, b4),)),
                                        ),
                                        SizedBox(width: 20,),

                                        Container(
                                          width: 200,
                                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(50),
                                              border: Border.all(width: 0.7,color: finalgrey)),
                                          child: FlatButton(
                                            color: b4,
                                              padding: EdgeInsets.all(20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50),),

                                              onPressed: (){
                                                Navigator.push(context, new MaterialPageRoute(builder: (context)=>studentsignin()));
                                              }, child:  Text("Student",style: getsimplestyle(14, FontWeight.normal,Colors.white),)),
                                        ),
                                      ],
                                    ),



                                  ],
                                ),
                              ),

                              Container(
                                alignment: Alignment.topLeft,
                                height: pageheight,
                                margin: EdgeInsets.only(left: 100),
                               child: Container(
                                 width: 180,

                                  padding: EdgeInsets.only(top: 30),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset("assets/images/cluster.png"),
                                      ),
                                      Text(
                                        "luster",
                                        style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal,fontSize: 25),
                                        softWrap: true,
                                        textAlign: TextAlign.start,
                                      )
                                    ],),
                                ),
                              )

                            ],
                          )),

                      Expanded(
                          flex: 1,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [


                               Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset("assets/images/cluster.png",height: pageheight,),
                                ),

                              Container(
                                height: 300,
                                  width: 300,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 140),
                                  child: AnimatedCircularProgressbarIndicator(
                                    percentage: 1,
                                    label: "Free and Relaible",
                                  ))
                            ],
                          )),

                    ],
                  )
                ],
              ),

              footer()
            ],
          ),


        ],
      ),
    );
  }
}
