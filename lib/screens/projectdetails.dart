import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster/Components/footer.dart';
import 'package:cluster/screens/faculty/facultyprofile.dart';
import 'package:cluster/screens/faculty/selectproposal.dart';
import 'package:cluster/screens/profileviewer.dart';
import 'package:cluster/screens/student/createproposal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Components/Appbar.dart';
import '../../Components/Drawerbox.dart';
import '../../constants.dart';
import '../../helper/responsive.dart';
class projectdetails extends StatefulWidget {
  String? projectkey,role;
  projectdetails({Key? key,this.projectkey,this.role}) : super(key: key);

  @override
  _projectdetailsState createState() => _projectdetailsState(projectkey: this.projectkey,role: this.role);
}

class _projectdetailsState extends State<projectdetails> {
  String? projectkey;
  var stream1,stream2,stream3;
  List saved=[];
  String? role;

  _projectdetailsState({this.projectkey,this.role});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream1=FirebaseFirestore.instance.collection("projects").doc(projectkey);
    stream3=FirebaseFirestore.instance.collection("proposals");

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: pagegrey,
      appBar: AppBar(
        backgroundColor: b2,
        toolbarHeight: Responsive.isdesktop(context) ? 75 : 60,
        elevation: 3,
        title: Appbar(profile: false,activeindex: -1,),
      ),
      drawer: Responsive.istablet(context) ? Drawerbox() : null,
      body: StreamBuilder<DocumentSnapshot>(
        stream: stream1.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if(snapshot.hasData && snapshot.data!.exists) {
            DocumentSnapshot doc=snapshot.data!;
            saved.clear();
            saved.addAll(doc["saved"]);
            return ListView(
              children: [
                Container(
                  width: maxWidth,
                  margin: EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(30),
                        width: maxWidth,
                        child: Row(
                          children: [
                            Text("Project details", style: getsimplestyle(
                                20, FontWeight.w500, textcolor),)
                          ],
                        ),
                      ),

                      Responsive.isdesktop(context) ? Container(
                          width: maxWidth,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(width: 0.7, color: finalgrey)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(right: BorderSide(
                                          width: 0.7, color: finalgrey))
                                  ),
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [

                                      Container(
                                        padding: EdgeInsets.all(30),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    doc["projecttitle"],
                                                    style: getsimplestyle(
                                                        18, FontWeight.w500,
                                                        textcolor),),
                                                  doc["status"]=="open"?Chip(label:Text("Open for Proposals",style: getsimplestyle(12, FontWeight.w300, Colors.white)),
                                                    backgroundColor: Colors.green.withOpacity(0.9),
                                                  ):Chip(label:Text("Closed for Proposals",style: getsimplestyle(12, FontWeight.w300, Colors.white)),
                                                    backgroundColor: Colors.red.withOpacity(0.8),
                                                  )
                                                ],
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              ),
                                            ),

                                            SizedBox(height: 10,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on,
                                                      color: b4, size: 20,),
                                                    Text(
                                                      "Indian Institute Technology Roorkee",
                                                      style: getsimplestyle(
                                                          12, FontWeight.w300,
                                                          textcolor),)

                                                  ],
                                                ),

                                                Text(" Posted ${convertToAgo(DateFormat("yyyy-MM-dd hh:mm:ss").parse(doc["date"]))}",
                                                  style: getsimplestyle(
                                                      12, FontWeight.w300,
                                                      Colors.grey),),

                                              ],
                                            ),

                                          ],
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                        ),
                                      ),
                                      Container(
                                        height: 0.7,
                                        width: double.infinity,
                                        color: finalgrey,
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(30),
                                        child: Text(
                                          doc["projectdes"],
                                          style: getsimplestyle(
                                              13, FontWeight.w300, textcolor),),

                                      ),

                                      Container(
                                        height: 0.7,
                                        width: double.infinity,
                                        color: finalgrey,
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(30),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(

                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.monetization_on,
                                                          color: textcolor,),
                                                        Text(" Rs ${doc["moneyperhr"]} /Month",
                                                          style: getsimplestyle(
                                                              14,
                                                              FontWeight.w500,
                                                              textcolor),)
                                                      ],
                                                    ),

                                                    Text(doc["cost"]=="Paid"?"         Fixed-price":"         Unpaid",
                                                      style: getsimplestyle(
                                                          12, FontWeight.w300,
                                                          Colors.grey),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.bar_chart,
                                                          color: textcolor,),
                                                        Text(" Entry level",
                                                          style: getsimplestyle(
                                                              14,
                                                              FontWeight.w500,
                                                              textcolor),)
                                                      ],
                                                    ),

                                                    Text(
                                                      "         I am looking for Students \n         from ${doc["entrylevel"]}",
                                                      style: getsimplestyle(
                                                          12, FontWeight.w300,
                                                          Colors.grey),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),


                                      Container(
                                        height: 0.7,
                                        width: double.infinity,
                                        color: finalgrey,
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(30),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text("Skills and Expertise",
                                              style: getsimplestyle(
                                                  16, FontWeight.w500,
                                                  textcolor),),
                                            SizedBox(height: 10,),


                                            Container(
                                                height: 50,
                                                child: ScrollConfiguration(
                                                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                  child: ListView.builder(
                                                      itemCount: doc["techstack"].length,
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      itemBuilder: (context,i){
                                                        return Container(
                                                          margin: EdgeInsets.only(right: 5),
                                                          child: InputChip(
                                                            label:
                                                            Text(
                                                              doc["techstack"][i],
                                                              style: getsimplestyle(
                                                                  12,
                                                                  FontWeight.w200,
                                                                  b1),
                                                            ),
                                                            labelStyle: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color:
                                                                Colors.black),
                                                            onPressed:
                                                                () =>
                                                            null,
                                                            backgroundColor:
                                                            b5.withOpacity(0.6),
                                                          ),
                                                        );
                                                      }),

                                                )
                                            ),
                                          ],
                                        ),

                                      ),
                                      Container(
                                        height: 0.7,
                                        width: double.infinity,
                                        color: finalgrey,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(30),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text("Activity on this job",
                                              style: getsimplestyle(
                                                  16, FontWeight.w500,
                                                  textcolor),),
                                            SizedBox(height: 15,),

                                            StreamBuilder<QuerySnapshot>(
                                                stream: stream3.snapshots(),
                                                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                                  if(snapshot.hasData) {
                                                    List d=snapshot.data!.docs;
                                                    List docs=[];
                                                    for(int i=0;i<d.length;i++){
                                                      if(d[i]["projectkey"]==projectkey){
                                                        docs.add(d[i]);
                                                      }
                                                    }
                                                    return Row(
                                                      children: [
                                                        Text("Proposals:",
                                                          style: getsimplestyle(
                                                              13, FontWeight.w300,
                                                              Colors.grey),),
                                                        Text("  ${docs.length}",
                                                          style: getsimplestyle(
                                                              13, FontWeight.w500,
                                                              textcolor),),
                                                      ],
                                                    );
                                                  }
                                                  return Container(
                                                      margin: EdgeInsets.all(30),
                                                      child: Center(
                                                          child: CircularProgressIndicator(
                                                            color: b4,
                                                          )));
                                                }
                                            ),


                                          ],
                                        ),

                                      ),


                                    ],
                                  ),

                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(7),
                                        bottomRight: Radius.circular(7)),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [


                                      StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance.collection("facultydata").doc(doc["postedby"]).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snap) {
                                          if(snap.hasData && snap.data!.exists){
                                            DocumentSnapshot d=snap.data!;
                                            return Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(30),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [

                                                      role=="faculty" && doc["postedby"]==FirebaseAuth.instance.currentUser!.uid? Container(
                                                        child: FlatButton(
                                                          color: b3,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(100)),

                                                          padding: EdgeInsets.all(20),
                                                          onPressed: () {

                                                            Navigator.push(context, new MaterialPageRoute(builder: (context)=>selectproposal(projectkey: doc["key"])));
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .center,
                                                            children: [

                                                              Text("See all Proposals",
                                                                style: getsimplestyle(
                                                                    12, FontWeight.normal,
                                                                    Colors.white),),

                                                            ],
                                                          ),
                                                        ),
                                                      ):Container(),

                                                      SizedBox(height: role=="faculty" && doc["postedby"]==FirebaseAuth.instance.currentUser!.uid?15:0,),

                                                     role=="faculty" || doc["status"]=="closed"?Container(): Container(
                                                        child: FlatButton(
                                                          color: b3,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(100)),

                                                          padding: EdgeInsets.all(20),
                                                          onPressed: () {

                                                            Navigator.push(context, new MaterialPageRoute(builder: (context)=>proposal(projectkey: projectkey,)));
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .center,
                                                            children: [

                                                              Text("Submit a Proposal",
                                                                style: getsimplestyle(
                                                                    12, FontWeight.normal,
                                                                    Colors.white),),

                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(height: role=="faculty" || doc["status"]=="closed"?0:15,),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(width: 0.7,
                                                                color: finalgrey),
                                                            borderRadius: BorderRadius
                                                                .circular(100)
                                                        ),
                                                        child: FlatButton(
                                                          color: Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(100)),

                                                          padding: EdgeInsets.all(20),
                                                          onPressed: () {
                                                            //print(saved);
                                                            addtosavelist(doc["key"]);
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                saved.contains(FirebaseAuth.instance.currentUser!.uid)?Icons.favorite :Icons.favorite_border,
                                                                size: 20,
                                                                color:
                                                                b4,
                                                              ),
                                                              SizedBox(width: 5,),

                                                              Text(saved.contains(FirebaseAuth.instance.currentUser!.uid)?"Saved":"Save Project",
                                                                style: getsimplestyle(
                                                                    12, FontWeight.normal,
                                                                    b4),),

                                                            ],
                                                          ),
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ),

                                                Container(
                                                  height: 0.7,
                                                  width: double.infinity,
                                                  color: finalgrey,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(30),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text("About the client",
                                                        style: getsimplestyle(
                                                            16, FontWeight.w500,
                                                            textcolor),
                                                        textAlign: TextAlign.start,),
                                                      SizedBox(height: 15,),

                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        children: [

                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [

                                                              Container(
                                                                child: Icon(Icons
                                                                    .account_circle_outlined,
                                                                  color: b3, size: 45,),
                                                              ),
                                                              SizedBox(height: 5,),
                                                              Container(child: Text(
                                                                d["name"],
                                                                style: getsimplestyle(
                                                                    13, FontWeight.w500,
                                                                    textcolor),)),
                                                              SizedBox(height: 3,),
                                                              Row(
                                                                children: [
                                                                  Icon(Icons.school,
                                                                    color: textcolor,
                                                                    size: 15,),
                                                                  SizedBox(width: 5,),
                                                                  Text(
                                                                    "Faculty Electrical Eng. Dep",
                                                                    style: getsimplestyle(
                                                                        12,
                                                                        FontWeight.w300,
                                                                        Colors.grey),),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),

                                                      SizedBox(height: 15,),

                                                      Container(

                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text("75 Job Posted",
                                                              style: getsimplestyle(
                                                                  13, FontWeight.w500,
                                                                  textcolor),),
                                                            Text(
                                                              "47% hire rate, 3 open jobs",
                                                              style: getsimplestyle(
                                                                  12, FontWeight.w300,
                                                                  Colors.grey),),

                                                          ],
                                                        ),
                                                      ),


                                                      SizedBox(height: 30,),

                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(width: 0.7,
                                                                color: finalgrey),
                                                            borderRadius: BorderRadius
                                                                .circular(100)
                                                        ),
                                                        child: FlatButton(
                                                          color: Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(100)),

                                                          padding: EdgeInsets.all(20),
                                                          onPressed: () {
                                                            Navigator.push(context, new MaterialPageRoute(builder: (context)=>profileviewer(uid:d["uid"],role: "faculty",)));
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(Icons.outbond_outlined,
                                                                color: b4, size: 20,),
                                                              SizedBox(width: 5,),

                                                              Text("Visit Profile",
                                                                style: getsimplestyle(
                                                                    12, FontWeight.normal,
                                                                    b4),),

                                                            ],
                                                          ),
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }

                                          return Container(
                                              margin: EdgeInsets.all(30),
                                              child: Center(
                                                  child: CircularProgressIndicator(
                                                    color: b4,
                                                  )));

                                        }
                                      ),


                                    ],
                                  ),


                                ),
                              )
                            ],
                          )
                      ) : Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(width: 0.7, color: finalgrey)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(right: BorderSide(
                                        width: 0.7, color: finalgrey))
                                ),
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                      padding: EdgeInsets.all(30),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              doc["projecttitle"],
                                              style: getsimplestyle(
                                                  18, FontWeight.w500,
                                                  textcolor),),
                                          ),


                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.location_on,
                                                    color: b4, size: 20,),
                                                  Text(
                                                    "Indian Institute Technology Roorkee",
                                                    style: getsimplestyle(
                                                        12, FontWeight.w300,
                                                        textcolor),)

                                                ],
                                              ),
                                              Text(" Posted ${convertToAgo(DateFormat("yyyy-MM-dd hh:mm:ss").parse(doc["date"]))}",
                                                style: getsimplestyle(
                                                    12, FontWeight.w300,
                                                    Colors.grey),),

                                            ],
                                          ),

                                        ],
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                      ),
                                    ),
                                    Container(
                                      height: 0.7,
                                      width: double.infinity,
                                      color: finalgrey,
                                    ),

                                    Container(
                                      padding: EdgeInsets.all(30),
                                      child: Text(
                                        doc["projectdes"],
                                        style: getsimplestyle(
                                            13, FontWeight.w300, textcolor),),

                                    ),

                                    Container(
                                      height: 0.7,
                                      width: double.infinity,
                                      color: finalgrey,
                                    ),

                                    Container(
                                      padding: EdgeInsets.all(30),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.monetization_on,
                                                        color: textcolor,),
                                                      Text(" Rs ${doc["moneyperhr"]}",
                                                        style: getsimplestyle(
                                                            14, FontWeight.w500,
                                                            textcolor),)
                                                    ],
                                                  ),

                                                  Text(doc["cost"]=="Paid"?"         Fixed-price":"         Unpaid",
                                                    style: getsimplestyle(
                                                        12, FontWeight.w300,
                                                        Colors.grey),)
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.bar_chart,
                                                        color: textcolor,),
                                                      Text(" Entry level",
                                                        style: getsimplestyle(
                                                            14, FontWeight.w500,
                                                            textcolor),)
                                                    ],
                                                  ),

                                                  Text(
                                                    "         I am looking for Students \n         of ${doc["entrylevel"]}",
                                                    style: getsimplestyle(
                                                        12, FontWeight.w300,
                                                        Colors.grey),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    Container(
                                      height: 0.7,
                                      width: double.infinity,
                                      color: finalgrey,
                                    ),

                                    Container(
                                      padding: EdgeInsets.all(30),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text("Skills and Expertise",
                                            style: getsimplestyle(
                                                16, FontWeight.w500,
                                                textcolor),),
                                          SizedBox(height: 10,),

                                          Container(
                                              height: 50,
                                              child: ScrollConfiguration(
                                                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                child: ListView.builder(
                                                    itemCount: doc["techstack"].length,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context,i){
                                                      return Container(
                                                        margin: EdgeInsets.only(right: 5),
                                                        child: InputChip(
                                                          label:
                                                          Text(
                                                            doc["techstack"][i],
                                                            style: getsimplestyle(
                                                                12,
                                                                FontWeight.w200,
                                                                b1),
                                                          ),
                                                          labelStyle: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color:
                                                              Colors.black),
                                                          onPressed:
                                                              () =>
                                                          null,
                                                          backgroundColor:
                                                          b5.withOpacity(0.6),
                                                        ),
                                                      );
                                                    }),

                                              )
                                          ),
                                        ],
                                      ),

                                    ),
                                    Container(
                                      height: 0.7,
                                      width: double.infinity,
                                      color: finalgrey,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(30),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text("Activity on this job",
                                            style: getsimplestyle(
                                                16, FontWeight.w500,
                                                textcolor),),
                                          SizedBox(height: 15,),

                                          StreamBuilder<QuerySnapshot>(
                                            stream: stream3.snapshots(),
                                            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if(snapshot.hasData) {
                                                List d=snapshot.data!.docs;
                                                List docs=[];
                                                for(int i=0;i<d.length;i++){
                                                  if(d[i]["projectkey"]==projectkey){
                                                    docs.add(d[i]);
                                                  }
                                                }
                                                return Row(
                                                  children: [
                                                    Text("Proposals:",
                                                      style: getsimplestyle(
                                                          13, FontWeight.w300,
                                                          Colors.grey),),
                                                    Text("  ${docs.length}",
                                                      style: getsimplestyle(
                                                          13, FontWeight.w500,
                                                          textcolor),),
                                                  ],
                                                );
                                              }
                                              return Container(
                                                  margin: EdgeInsets.all(30),
                                                  child: Center(
                                                      child: CircularProgressIndicator(
                                                        color: b4,
                                                      )));
                                            }
                                          ),

                                        ],
                                      ),

                                    ),


                                  ],
                                ),

                              ),

                              Container(
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(7),
                                      bottomRight: Radius.circular(7)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [


                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance.collection("facultydata").doc(doc["postedby"]).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snap) {
                                          if(snap.hasData && snap.data!.exists){
                                            DocumentSnapshot d=snap.data!;
                                            return Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 30, right: 30, bottom: 30),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      role=="faculty"?Container(): Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          child: FlatButton(
                                                            color: b3,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .circular(100)),

                                                            padding: EdgeInsets.all(20),
                                                            onPressed: () {
                                                              Navigator.push(context, new MaterialPageRoute(builder: (context)=>proposal()));
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              children: [

                                                                Text("Submit a Proposal",
                                                                  style: getsimplestyle(
                                                                      12, FontWeight.normal,
                                                                      Colors.white),),

                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(width:role=="faculty"?0: 15,),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(width: 0.7,
                                                                  color: finalgrey),
                                                              borderRadius: BorderRadius
                                                                  .circular(100)
                                                          ),
                                                          child: FlatButton(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .circular(100)),

                                                            padding: EdgeInsets.all(20),
                                                            onPressed: () {
                                                              //print(saved);
                                                              addtosavelist(doc["key"]);
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Icon(
                                                                  saved.contains(FirebaseAuth.instance.currentUser!.uid)?Icons.favorite :Icons.favorite_border,
                                                                  size: 20,
                                                                  color:
                                                                  b4,
                                                                ),
                                                                SizedBox(width: 5,),

                                                                Text(saved.contains(FirebaseAuth.instance.currentUser!.uid)?"Saved":"Save Project",
                                                                  style: getsimplestyle(
                                                                      12, FontWeight.normal,
                                                                      b4),),

                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ),

                                                Container(
                                                  height: 0.7,
                                                  width: double.infinity,
                                                  color: finalgrey,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(30),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text("About the client",
                                                        style: getsimplestyle(
                                                            16, FontWeight.w500,
                                                            textcolor),
                                                        textAlign: TextAlign.start,),
                                                      SizedBox(height: 15,),

                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        children: [

                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [

                                                              Container(
                                                                child: Icon(Icons
                                                                    .account_circle_outlined,
                                                                  color: b3, size: 45,),
                                                              ),
                                                              SizedBox(height: 5,),
                                                              Container(child: Text(
                                                                d["name"],
                                                                style: getsimplestyle(
                                                                    13, FontWeight.w500,
                                                                    textcolor),)),
                                                              SizedBox(height: 3,),
                                                              Row(
                                                                children: [
                                                                  Icon(Icons.school,
                                                                    color: textcolor,
                                                                    size: 15,),
                                                                  SizedBox(width: 5,),
                                                                  Text(
                                                                    "Faculty Electrical Eng. Dep",
                                                                    style: getsimplestyle(
                                                                        12,
                                                                        FontWeight.w300,
                                                                        Colors.grey),),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),

                                                      SizedBox(height: 15,),

                                                      Container(

                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text("75 Job Posted",
                                                              style: getsimplestyle(
                                                                  13, FontWeight.w500,
                                                                  textcolor),),
                                                            Text(
                                                              "47% hire rate, 3 open jobs",
                                                              style: getsimplestyle(
                                                                  12, FontWeight.w300,
                                                                  Colors.grey),),

                                                          ],
                                                        ),
                                                      ),


                                                      SizedBox(height: 30,),

                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(width: 0.7,
                                                                color: finalgrey),
                                                            borderRadius: BorderRadius
                                                                .circular(100)
                                                        ),
                                                        child: FlatButton(
                                                          color: Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(100)),

                                                          padding: EdgeInsets.all(20),
                                                          onPressed: () {
                                                            Navigator.push(context, new MaterialPageRoute(builder: (context)=>profileviewer(uid:d["uid"])));
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(Icons.outbond_outlined,
                                                                color: b4, size: 20,),
                                                              SizedBox(width: 5,),

                                                              Text("Visit Profile",
                                                                style: getsimplestyle(
                                                                    12, FontWeight.normal,
                                                                    b4),),

                                                            ],
                                                          ),
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }

                                          return Container(
                                              margin: EdgeInsets.all(30),
                                              child: Center(
                                                  child: CircularProgressIndicator(
                                                    color: b4,
                                                  )));

                                        }
                                    ),


                                  ],
                                ),


                              ),

                            ],
                          )
                      ),
                    ],
                  ),
                ),


                footer()
              ],
            );
          }

          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: CircularProgressIndicator(
                    color: b4,
                  )));
        }
      ),
    );
  }

  void addtosavelist(String key) {
    if(!saved.contains(FirebaseAuth.instance.currentUser!.uid)) {
      saved.add(FirebaseAuth.instance.currentUser!.uid);
      FirebaseFirestore.instance.collection("projects").doc(key).update({
        "saved": saved
      });
    }else{
      saved.remove(FirebaseAuth.instance.currentUser!.uid);
      FirebaseFirestore.instance.collection("projects").doc(key).update({
        "saved":saved
      });
    }
  }
}
