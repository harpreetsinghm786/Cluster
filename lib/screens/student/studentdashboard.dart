import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster/Components/Appbar.dart';
import 'package:cluster/Components/footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Components/Drawerbox.dart';
import '../../constants.dart';
import '../../helper/responsive.dart';
import '../profileviewer.dart';
import '../projectdetails.dart';


class studentdashboard extends StatefulWidget {
  int activeindex;
  studentdashboard({Key? key,required this.activeindex}) : super(key: key);

  @override
  _studentdashboardState createState() => _studentdashboardState(active: activeindex);
}

class _studentdashboardState extends State<studentdashboard> {
  String? search;
  TextEditingController? _search;
  var stream1,stream2,stream3;
  final newprojectform = GlobalKey<FormState>();
  final techstackformKey = GlobalKey<FormState>();
  List techstack = [];
  bool load=false;
  String dropdownValueyear = 'First Year';
  String cost="Unpaid";
  String? projecttitle, projectdes, link, tech;
  int active;

  List documents=[];
  List filtereddocs=[];
  List<bool> tabs=[true,false];
  List skills = [];
  List<String> tabnames=["Most Recent","Saved Posts"];
  int activeindex=0;
  int moneyperhr=0;
  bool languageload = false;
  List<List<dynamic>> saved=[];


  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    _search = new TextEditingController();
    stream1=FirebaseFirestore.instance.collection("studentdata").doc(FirebaseAuth.instance.currentUser!.uid);
    stream2=FirebaseFirestore.instance.collection("projects").orderBy("date",descending: true);
    stream3=FirebaseFirestore.instance.collection("proposals");

  }
  _studentdashboardState({required this.active});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pagegrey,
      appBar: AppBar(
        backgroundColor: b2,
        toolbarHeight: Responsive.isdesktop(context) ? 75 : 60,
        elevation: 3,
        title: Appbar(profile: false,activeindex: active,),
      ),

      drawer: Responsive.istablet(context) ? Drawerbox() : null,

      body: Container(
        child: StreamBuilder<DocumentSnapshot>(
            stream: stream1.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {

              if(active==0) {
                if (snapshot.hasData) {
                  DocumentSnapshot doc = snapshot.data!;
                  DateTime now = DateTime.now();
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(30),
                                margin: EdgeInsets.symmetric(
                                    vertical: Responsive.ismobile(context)
                                        ? 15
                                        : 30,
                                    horizontal: Responsive.istablet(context)
                                        ? 0
                                        : 10),
                                decoration: BoxDecoration(
                                    color: b3,
                                    border: Border.all(
                                        width: 0.7, color: finalgrey),
                                    borderRadius: BorderRadius.circular(7)),
                                width: Responsive.isdesktop(context)
                                    ? maxWidth * 0.85
                                    : MediaQuery
                                    .of(context)
                                    .size
                                    .width - 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          "${now.day} ${months[now.month]} ${now
                                              .year}",
                                          style: getsimplestyle(
                                              14, FontWeight.w500, b5),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Good ${greeting()},\n${doc["name"]}",
                                            style: getsimplestyle(
                                                26, FontWeight.w500,
                                                Colors.white)),
                                      ],
                                    ),
                                    Container(
                                      child: Stack(
                                        children: [
                                          Container(
                                              child: Icon(
                                                Icons.message,
                                                size: Responsive.istablet(
                                                    context) ? 50 : 60,
                                                color: b2.withOpacity(0.7),
                                              ),
                                              margin:
                                              EdgeInsets.only(
                                                  left: 0, bottom: 20)),
                                          Container(
                                              child: Icon(
                                                Icons.message,
                                                size: Responsive.istablet(
                                                    context) ? 60 : 80,
                                                color: b4.withOpacity(1),
                                              ),
                                              margin:
                                              EdgeInsets.only(
                                                  left: 100, bottom: 20)),
                                          Container(
                                              child: Icon(
                                                  Icons.message_outlined,
                                                  size: Responsive.istablet(
                                                      context) ? 90 : 110,
                                                  color: Colors.white),
                                              margin: EdgeInsets.only(
                                                  left: 35, top: 20)),
                                        ],
                                      ),
                                      margin: EdgeInsets.only(left: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                          width: 0.7, color: finalgrey)),
                                  height: 50,
                                  width: Responsive.isdesktop(context)
                                      ? maxWidth * 0.85
                                      : MediaQuery
                                      .of(context)
                                      .size
                                      .width - 30,
                                  margin: EdgeInsets.only(right: 0, bottom: 0),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: searchfield(),
                                      ),
                                    ],
                                  )),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: Responsive.ismobile(context)
                                        ? 15
                                        : 30,
                                    horizontal: Responsive.ismobile(context)
                                        ? 0
                                        : 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 0.7, color: finalgrey),
                                    borderRadius: BorderRadius.circular(7)),
                                width: Responsive.isdesktop(context)
                                    ? maxWidth * 0.85
                                    : MediaQuery
                                    .of(context)
                                    .size
                                    .width - 30,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            "Jobs you might like",
                                            style: getsimplestyle(
                                                18, FontWeight.w500, textcolor),
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end,
                                      children: [
                                        SizedBox(width: 20,),

                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          height: 33,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 2,
                                            shrinkWrap: true,

                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        for (int i = 0; i <
                                                            tabs.length; i++) {
                                                          tabs[i] = false;
                                                        }
                                                        tabs[index] =
                                                        !tabs[index];
                                                        activeindex = index;
                                                      });
                                                    },
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Text(tabnames[index],
                                                            style: getsimplestyle(
                                                              13,
                                                              FontWeight.w400,
                                                              tabs[index]
                                                                  ? b3
                                                                  : Colors
                                                                  .grey,),),

                                                          Container(
                                                            margin: EdgeInsets
                                                                .only(top: 10),
                                                            height: 3,
                                                            width: 120,
                                                            color: tabs[index]
                                                                ? b3
                                                                : Colors
                                                                .transparent,)
                                                        ],
                                                      ),
                                                    ),
                                                  ),


                                                ],
                                              );
                                            },

                                          ),
                                        ),


                                      ],
                                    ),

                                    Container(
                                        child: Container(
                                          height: 0.7,
                                          width: maxWidth,
                                          color: finalgrey,
                                        )),

                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        "Browse projects that match your experience to a client's hiring preferences. Ordered by most relevant.",
                                        style: getsimplestyle(
                                            12, FontWeight.normal, textcolor),),
                                    ),

                                    Container(
                                        child: Container(
                                          height: 0.7,
                                          width: maxWidth,
                                          color: finalgrey,
                                        )),


                                    StreamBuilder<QuerySnapshot>(
                                        stream: stream2.snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                QuerySnapshot> snapshot) {
                                          if (snapshot.hasData) {
                                            List docs = snapshot.data!.docs;

                                            documents = [];
                                            documents.addAll(docs);

                                            if (_search!.value.text == "") {
                                              filtereddocs = [];
                                              filtereddocs.addAll(docs);
                                            }
                                            saved.clear();
                                            for (int i = 0; i <
                                                docs.length; i++) {
                                              saved.add(docs[i]["saved"]);
                                            }


                                            if (filtereddocs.length == 0) {
                                              return Container(
                                                padding: EdgeInsets.all(20),
                                                child: Text("No data",
                                                  style: getsimplestyle(
                                                      13, FontWeight.normal,
                                                      textcolor),),
                                              );
                                            }

                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: filtereddocs.length,
                                                itemBuilder: (context, index) {
                                                  if (activeindex == 1) {
                                                    return saved[index]
                                                        .contains(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid)
                                                        ? FlatButton(

                                                      hoverColor: glase,
                                                      splashColor: Colors.white,
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                            new MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    projectdetails(
                                                                      projectkey: filtereddocs[index]["key"]
                                                                          .toString(),)));
                                                      },
                                                      padding: EdgeInsets.all(
                                                          0),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .all(20),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      filtereddocs[index]["projecttitle"],
                                                                      style: getsimplestyle(
                                                                          14,
                                                                          FontWeight
                                                                              .w500,
                                                                          textcolor),),

                                                                    Row(
                                                                      children: [

                                                                        Container(
                                                                            decoration: BoxDecoration(
                                                                                border: Border
                                                                                    .all(
                                                                                    width: 0.7,
                                                                                    color:
                                                                                    finalgrey),
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    100)),
                                                                            child: IconButton(
                                                                              onPressed:
                                                                                  () {
                                                                                addtosavelist(
                                                                                    filtereddocs[index]["key"],
                                                                                    index);
                                                                              },
                                                                              icon: Icon(
                                                                                saved[index]
                                                                                    .contains(
                                                                                    FirebaseAuth
                                                                                        .instance
                                                                                        .currentUser!
                                                                                        .uid)
                                                                                    ? Icons
                                                                                    .favorite
                                                                                    : Icons
                                                                                    .favorite_border,
                                                                                size: 20,
                                                                                color:
                                                                                textcolor,
                                                                              ),
                                                                            )),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,),

                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        "Project is " +
                                                                            filtereddocs[index]["cost"] +
                                                                            " - " +
                                                                            " Open for " +
                                                                            filtereddocs[index]["entrylevel"] +
                                                                            " Posted - "
                                                                            +
                                                                            convertToAgo(
                                                                                DateTime
                                                                                    .parse(
                                                                                    filtereddocs[index]["date"])),
                                                                        style: getsimplestyle(
                                                                            12,
                                                                            FontWeight
                                                                                .normal,
                                                                            Colors
                                                                                .grey)),

                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,),

                                                                Container(
                                                                  child: Text(
                                                                    filtereddocs[index]["projectdes"],
                                                                    style: getsimplestyle(
                                                                        13,
                                                                        FontWeight
                                                                            .w300,
                                                                        textcolor),
                                                                    textAlign: TextAlign
                                                                        .left,
                                                                    maxLines: null,


                                                                  ),
                                                                ),

                                                                SizedBox(
                                                                  height: 10,),

                                                                Container(
                                                                    height: 50,
                                                                    child: ScrollConfiguration(
                                                                      behavior: ScrollConfiguration
                                                                          .of(
                                                                          context)
                                                                          .copyWith(
                                                                          scrollbars: false),
                                                                      child: ListView
                                                                          .builder(
                                                                          itemCount: filtereddocs[index]["techstack"]
                                                                              .length,
                                                                          shrinkWrap: true,
                                                                          scrollDirection: Axis
                                                                              .horizontal,
                                                                          itemBuilder: (
                                                                              context,
                                                                              i) {
                                                                            return Container(
                                                                              margin: EdgeInsets
                                                                                  .only(
                                                                                  right: 5),
                                                                              child: InputChip(
                                                                                label:
                                                                                Text(
                                                                                  filtereddocs[index]["techstack"][i],
                                                                                  style: getsimplestyle(
                                                                                      12,
                                                                                      FontWeight
                                                                                          .w200,
                                                                                      b1),
                                                                                ),
                                                                                labelStyle: TextStyle(
                                                                                    fontWeight: FontWeight
                                                                                        .bold,
                                                                                    color:
                                                                                    Colors
                                                                                        .black),
                                                                                onPressed:
                                                                                    () =>
                                                                                null,
                                                                                backgroundColor:
                                                                                b5
                                                                                    .withOpacity(
                                                                                    0.6),
                                                                              ),
                                                                            );
                                                                          }),

                                                                    )
                                                                ),


                                                                SizedBox(
                                                                  height: 10,),

                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                        "Proposals : ",
                                                                        style: getsimplestyle(
                                                                            12,
                                                                            FontWeight
                                                                                .normal,
                                                                            Colors
                                                                                .grey)),

                                                                    Text(
                                                                        filtereddocs[index]["proposals"]
                                                                            .length
                                                                            .toString(),
                                                                        style: getsimplestyle(
                                                                            12,
                                                                            FontWeight
                                                                                .normal,
                                                                            textcolor)),


                                                                  ],
                                                                ),


                                                              ],
                                                            ),
                                                          ),

                                                          index == filtereddocs
                                                              .length - 1
                                                              ? Container()
                                                              : Container(
                                                              child: Container(
                                                                height: 0.7,
                                                                width: maxWidth,
                                                                color: finalgrey,
                                                              )),
                                                        ],


                                                      ),
                                                    )
                                                        : Container();
                                                  }
                                                  return filtereddocs[index]["status"] ==
                                                      "open" ? FlatButton(

                                                    hoverColor: glase,
                                                    splashColor: Colors.white,
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                          new MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  projectdetails(
                                                                    projectkey: filtereddocs[index]["key"]
                                                                        .toString(),)));
                                                    },
                                                    padding: EdgeInsets.all(0),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .all(20),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    filtereddocs[index]["projecttitle"],
                                                                    style: getsimplestyle(
                                                                        14,
                                                                        FontWeight
                                                                            .w500,
                                                                        textcolor),),

                                                                  Row(
                                                                    children: [

                                                                      Container(
                                                                          decoration: BoxDecoration(
                                                                              border: Border
                                                                                  .all(
                                                                                  width: 0.7,
                                                                                  color:
                                                                                  finalgrey),
                                                                              borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                                  100)),
                                                                          child: IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              addtosavelist(
                                                                                  filtereddocs[index]["key"],
                                                                                  index);
                                                                            },
                                                                            icon: Icon(
                                                                              saved[index]
                                                                                  .contains(
                                                                                  FirebaseAuth
                                                                                      .instance
                                                                                      .currentUser!
                                                                                      .uid)
                                                                                  ? Icons
                                                                                  .favorite
                                                                                  : Icons
                                                                                  .favorite_border,
                                                                              size: 20,
                                                                              color:
                                                                              textcolor,
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,),

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Project is " +
                                                                          filtereddocs[index]["cost"] +
                                                                          " - " +
                                                                          " Open for " +
                                                                          filtereddocs[index]["entrylevel"] +
                                                                          " Posted - "
                                                                          +
                                                                          convertToAgo(
                                                                              DateTime
                                                                                  .parse(
                                                                                  filtereddocs[index]["date"])),
                                                                      style: getsimplestyle(
                                                                          12,
                                                                          FontWeight
                                                                              .normal,
                                                                          Colors
                                                                              .grey)),

                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,),

                                                              Container(
                                                                child: Text(
                                                                  filtereddocs[index]["projectdes"],
                                                                  style: getsimplestyle(
                                                                      13,
                                                                      FontWeight
                                                                          .w300,
                                                                      textcolor),
                                                                  textAlign: TextAlign
                                                                      .left,
                                                                  maxLines: null,


                                                                ),
                                                              ),

                                                              SizedBox(
                                                                height: 10,),

                                                              Container(
                                                                  height: 50,
                                                                  child: ScrollConfiguration(
                                                                    behavior: ScrollConfiguration
                                                                        .of(
                                                                        context)
                                                                        .copyWith(
                                                                        scrollbars: false),
                                                                    child: ListView
                                                                        .builder(
                                                                        itemCount: filtereddocs[index]["techstack"]
                                                                            .length,
                                                                        shrinkWrap: true,
                                                                        scrollDirection: Axis
                                                                            .horizontal,
                                                                        itemBuilder: (
                                                                            context,
                                                                            i) {
                                                                          return Container(
                                                                            margin: EdgeInsets
                                                                                .only(
                                                                                right: 5),
                                                                            child: InputChip(
                                                                              label:
                                                                              Text(
                                                                                filtereddocs[index]["techstack"][i],
                                                                                style: getsimplestyle(
                                                                                    12,
                                                                                    FontWeight
                                                                                        .w200,
                                                                                    b1),
                                                                              ),
                                                                              labelStyle: TextStyle(
                                                                                  fontWeight: FontWeight
                                                                                      .bold,
                                                                                  color:
                                                                                  Colors
                                                                                      .black),
                                                                              onPressed:
                                                                                  () =>
                                                                              null,
                                                                              backgroundColor:
                                                                              b5
                                                                                  .withOpacity(
                                                                                  0.6),
                                                                            ),
                                                                          );
                                                                        }),

                                                                  )
                                                              ),


                                                              SizedBox(
                                                                height: 10,),

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                      "Proposals : ",
                                                                      style: getsimplestyle(
                                                                          12,
                                                                          FontWeight
                                                                              .normal,
                                                                          Colors
                                                                              .grey)),

                                                                  Text(
                                                                      filtereddocs[index]["proposals"]
                                                                          .length
                                                                          .toString(),
                                                                      style: getsimplestyle(
                                                                          12,
                                                                          FontWeight
                                                                              .normal,
                                                                          textcolor)),


                                                                ],
                                                              ),


                                                            ],
                                                          ),
                                                        ),

                                                        index == filtereddocs
                                                            .length - 1
                                                            ? Container()
                                                            : Container(
                                                            child: Container(
                                                              height: 0.7,
                                                              width: maxWidth,
                                                              color: finalgrey,
                                                            )),
                                                      ],


                                                    ),
                                                  ) : Container();
                                                });
                                          }

                                          return Container(
                                              padding: EdgeInsets.all(20),

                                              child: Center(
                                                  child: CircularProgressIndicator(
                                                    color: b4,
                                                  )));
                                        }
                                    )


                                  ],
                                ),
                              ),
                            ],
                          ),
                          MediaQuery
                              .of(context)
                              .size
                              .width > 1160 ? Column(
                            children: [
                              Container(

                                margin: EdgeInsets.only(
                                    top: 30, right: 10, left: 10, bottom: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 0.7, color: finalgrey),
                                    borderRadius: BorderRadius.circular(7)),
                                width: maxWidth * 0.26,


                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 30),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons
                                                .account_circle_outlined,
                                            size: 80,
                                            color: b3,
                                          ),
                                          SizedBox(height: 10,),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Text(doc["name"],
                                                style: getsimplestyle(
                                                    15, FontWeight.w500,
                                                    textcolor),),
                                            ],
                                          ),
                                          SizedBox(height: 3,),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Text(doc["title"],
                                                style: getsimplestyle(
                                                    12, FontWeight.normal,
                                                    Colors.grey),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: 30, top: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white
                                      ),
                                      child: Column(
                                        children: [

                                          Chip(
                                            label: Text(doc["availability"]
                                                ? "Available Now"
                                                : "Not Available"),
                                            labelStyle: TextStyle(
                                                color: b1,
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight
                                                    .w300),
                                            backgroundColor:
                                            doc["availability"]
                                                ? b5
                                                : light,
                                          )
                                        ],
                                      ),
                                    )

                                  ],
                                ),

                              ),


                            ],
                          ) : Container(),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),

                      footer()
                    ],
                    shrinkWrap: true,
                  );
                }
              }else if(active==1){
                return Text("workspace");

              }else if(active==2){

                  if(snapshot.hasData) {
                    DocumentSnapshot doc=snapshot.data!;
                    DateTime now = DateTime.now();
                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(30),
                                  margin: EdgeInsets.symmetric(
                                      vertical: Responsive.ismobile(context)
                                          ? 15
                                          : 30,
                                      horizontal: Responsive.istablet(context)
                                          ? 0
                                          : 10),
                                  decoration: BoxDecoration(
                                      color: b3,
                                      border: Border.all(
                                          width: 0.7, color: finalgrey),
                                      borderRadius: BorderRadius.circular(7)),
                                  width: Responsive.isdesktop(context)
                                      ? maxWidth * 0.85
                                      : MediaQuery
                                      .of(context)
                                      .size
                                      .width - 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "${now.day} ${months[now.month]} ${now
                                                .year}",
                                            style: getsimplestyle(
                                                14, FontWeight.w500, b5),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "Good ${greeting()},\n${doc["name"]}",
                                              style: getsimplestyle(
                                                  26, FontWeight.w500,
                                                  Colors.white)),
                                        ],
                                      ),
                                      Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                                child: Icon(
                                                  Icons.send,
                                                  size: Responsive.istablet(
                                                      context) ? 50 : 60,
                                                  color: b2.withOpacity(0.7),
                                                ),
                                                margin:
                                                EdgeInsets.only(
                                                    left: 0, bottom: 20)),
                                            Container(
                                                child: Icon(
                                                  Icons.send,
                                                  size: Responsive.istablet(
                                                      context) ? 60 : 80,
                                                  color: b4.withOpacity(1),
                                                ),
                                                margin:
                                                EdgeInsets.only(
                                                    left: 100, bottom: 20)),
                                            Container(
                                                child: Icon(
                                                    Icons.send_outlined,
                                                    size: Responsive.istablet(
                                                        context) ? 90 : 110,
                                                    color: Colors.white),
                                                margin: EdgeInsets.only(
                                                    left: 35, top: 20)),
                                          ],
                                        ),
                                        margin: EdgeInsets.only(left: 20),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 30,left: 10,right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 0.7, color: finalgrey),
                                      borderRadius: BorderRadius.circular(7)),
                                  width: Responsive.isdesktop(context)
                                      ? maxWidth * 0.85
                                      : MediaQuery
                                      .of(context)
                                      .size
                                      .width - 30,
                                  child: Column(
                                    children: [






                                      StreamBuilder<QuerySnapshot>(
                                          stream: stream3.snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<
                                                  QuerySnapshot> snap) {
                                            if (snap.hasData) {
                                              List temp = snap.data!.docs;
                                              List docs=[];
                                              for(int i=0;i<temp.length;i++){
                                                for(int j=0;j<temp[i]["team"].length;j++){
                                                   if(temp[i]["team"][j]["uid"]==FirebaseAuth.instance.currentUser!.uid){
                                                     docs.add(temp[i]);
                                                   }
                                                }
                                              }
                                              return Container(
                                                  width: maxWidth,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(7),
                                                      border: Border.all(width: 0.7, color: finalgrey)
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(20),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "${docs.length} Proposals",
                                                              style: getsimplestyle(
                                                                  18, FontWeight.w500, textcolor),
                                                            ),

                                                          ],
                                                        ),
                                                      ),


                                                      Container(
                                                          child: Container(
                                                            height: 0.7,
                                                            width: maxWidth,
                                                            color: finalgrey,
                                                          )),


                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        padding: EdgeInsets.all(20),
                                                        child: Text(
                                                          "Status of your Sended proposals will be shown here, checkout the list.",
                                                          style: getsimplestyle(
                                                              12, FontWeight.normal, textcolor),),
                                                      ),

                                                      Container(
                                                          child: Container(
                                                            height: 0.7,
                                                            width: maxWidth,
                                                            color: finalgrey,
                                                          )),
                                                     docs.length==0?Container(child: Text("No Data",style: getsimplestyle(13,FontWeight.w300,textcolor),),padding: EdgeInsets.all(10),): ListView.builder(
                                                          itemCount: docs.length,
                                                          shrinkWrap: true,

                                                          itemBuilder: (context, index){
                                                            return Container(
                                                              child: Column(

                                                                children: [


                                                                  Stack(
                                                                    alignment: Alignment.bottomCenter,
                                                                    children: [
                                                                      Container(
                                                                        child: ListView(
                                                                          shrinkWrap: true,
                                                                          scrollDirection: Axis.vertical,
                                                                          children: [
                                                                            Container(

                                                                              padding: EdgeInsets.all(20),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Icon(Icons.group_add,color: b3,size: 20,),
                                                                                          SizedBox(width: 5,),
                                                                                          Text("Team: ",style: getsimplestyle(13, FontWeight.w500, textcolor),),
                                                                                        ],
                                                                                      ),
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                                                        children: [

                                                                                          Row(
                                                                                            children: [

                                                                                              docs[index]["status"]!="pending"?
                                                                                              docs[index]["status"]=="selected"?Chip(label:Text("Selected",style: getsimplestyle(12, FontWeight.w300, Colors.white)),
                                                                                                backgroundColor: Colors.green.withOpacity(0.9),
                                                                                              ):Chip(label:Text("Rejected",style: getsimplestyle(12, FontWeight.w300, Colors.white)),
                                                                                                backgroundColor: Colors.red.withOpacity(0.8),
                                                                                              )
                                                                                                  :

                                                                                              Chip(label:Text("Pending",style: getsimplestyle(12, FontWeight.w300, textcolor)),
                                                                                                backgroundColor: b5,
                                                                                              ),

                                                                                              SizedBox(width: 10,),
                                                                                              Text("Posted: ",style: getsimplestyle(12, FontWeight.w300, Colors.grey),),
                                                                                              Text("${convertToAgo(DateTime.parse(docs[index]["postdate"]))}",style: getsimplestyle(12, FontWeight.w500, Colors.grey),),
                                                                                            ],
                                                                                          ),



                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 5,),
                                                                                  Container(
                                                                                    height: 70,
                                                                                    padding: EdgeInsets.only(top: 10,bottom: 10,right: 30),
                                                                                    child:  Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                          flex:1,
                                                                                          child: Container(
                                                                                            height: 53,
                                                                                            child: ListView.builder(
                                                                                                scrollDirection: Axis.horizontal,
                                                                                                shrinkWrap: true,
                                                                                                itemCount: docs[index]["team"].length,
                                                                                                itemBuilder: (context,ind){



                                                                                                  return  MouseRegion(
                                                                                                    cursor: SystemMouseCursors.click,
                                                                                                    child: GestureDetector(
                                                                                                      onTap: (){
                                                                                                        Navigator.push(context, new MaterialPageRoute(builder: (context)=>profileviewer(uid: docs[index]["team"][ind]["uid"],role: "student",)));
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        margin: EdgeInsets.symmetric(horizontal: 3),
                                                                                                        child: Stack(
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              padding: EdgeInsets.all(10),
                                                                                                              height: 53,
                                                                                                              width: 52,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: b3,
                                                                                                                borderRadius: BorderRadius.circular(100),
                                                                                                                border: Border.all(width: 0.7,color: b4,),

                                                                                                              ),

                                                                                                              child: Center(child: Text(profilepic(docs[index]["team"][ind]["name"]),style: getsimplestyle(18, FontWeight.w600, Colors.white),)),
                                                                                                            ),

                                                                                                            docs[index]["groupleader"]==docs[index]["team"][ind]["uid"]?Container(
                                                                                                              alignment: Alignment.bottomRight,
                                                                                                              height: 57,
                                                                                                              width: 57,
                                                                                                              child: Container(
                                                                                                                height: 20,
                                                                                                                width: 20,
                                                                                                                decoration: BoxDecoration(
                                                                                                                    color: b5,
                                                                                                                    borderRadius: BorderRadius.circular(20)
                                                                                                                ),
                                                                                                                child: Center(
                                                                                                                  child: Text("GL",style: getsimplestyle(12,FontWeight.w500,b1),),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ):Container()

                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                }),

                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),

                                                                                  SizedBox(height: 15,),
                                                                                  Row(
                                                                                    children: [
                                                                                      Icon(Icons.calendar_today_rounded,color: b3,size: 20,),
                                                                                      SizedBox(width: 5,),
                                                                                      Text("Starting:  ",style: getsimplestyle(13, FontWeight.w500, textcolor),),
                                                                                      Text("${DateFormat('dd-MM-yyyy').format(new DateTime.fromMillisecondsSinceEpoch(docs[index]["startdate"].seconds*1000))}",style: getsimplestyle(13, FontWeight.w500, b3),),
                                                                                    ],
                                                                                  ),

                                                                                  SizedBox(height: 15,),

                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [

                                                                                      Row(
                                                                                        children: [
                                                                                          Icon(Icons.check_circle,color: b3,size: 20,),
                                                                                          SizedBox(width: 5,),
                                                                                          Text("Commitments",style: getsimplestyle(13, FontWeight.w500, textcolor),),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Text("Net Duration: ",style: getsimplestyle(13, FontWeight.w300, Colors.grey),),
                                                                                          Text(docs[index]["duration"].toString()+" Days" ,style: getsimplestyle(13, FontWeight.w500, textcolor),)
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 20,),

                                                                                  Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.white,
                                                                                      borderRadius: BorderRadius.circular(7),

                                                                                      border: Border.all(width: 0.7,color: finalgrey),
                                                                                    ),
                                                                                    child: ListView.builder(
                                                                                        shrinkWrap: true,
                                                                                        itemCount: docs[index]["commitments"].length,
                                                                                        itemBuilder: (context, ind){
                                                                                          return Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(

                                                                                                decoration: BoxDecoration(
                                                                                                  color: Colors.white,
                                                                                                  borderRadius: BorderRadius.circular(7),

                                                                                                ),

                                                                                                padding: EdgeInsets.all(20),
                                                                                                child: Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Container(
                                                                                                      child: Row(
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            docs[index]["commitments"][ind]["title"],
                                                                                                            style: getsimplestyle(
                                                                                                                13, FontWeight.w500,
                                                                                                                textcolor),),
                                                                                                          Container(
                                                                                                            alignment: Alignment.topRight,
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                                              children: [
                                                                                                                Icon(Icons.timer,color: Colors.grey,size: 20,),
                                                                                                                SizedBox(width: 5,),
                                                                                                                Text(docs[index]["commitments"][ind]["duration"]+" Days",style: getsimplestyle(12, FontWeight.w300, Colors.grey),)

                                                                                                              ],
                                                                                                            ),
                                                                                                          )
                                                                                                        ],
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      ),
                                                                                                    ),
                                                                                                    SizedBox(height: 5,),

                                                                                                    Container(
                                                                                                      child: Text(
                                                                                                        docs[index]["commitments"][ind]["description"],
                                                                                                        style: getsimplestyle(
                                                                                                            12,
                                                                                                            FontWeight
                                                                                                                .w300,
                                                                                                            textcolor),
                                                                                                        textAlign: TextAlign.left,
                                                                                                        maxLines: null,

                                                                                                      ),
                                                                                                    ),


                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              ind!=docs[index]["commitments"].length-1?Container(
                                                                                                  child: Container(
                                                                                                    height: 0.7,
                                                                                                    width: maxWidth,
                                                                                                    color: finalgrey,
                                                                                                  )):Container(),
                                                                                            ],
                                                                                          );
                                                                                        }),
                                                                                  ),

                                                                                  SizedBox(height: 20,),
                                                                                  Row(
                                                                                    children: [
                                                                                      Icon(Icons.grade_outlined,color: b3,size: 20,),
                                                                                      SizedBox(width: 5,),
                                                                                      Text("Experiences",style: getsimplestyle(13, FontWeight.w500, textcolor),),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 10,),
                                                                                  Text(docs[index]["experiencedes"],style: getsimplestyle(13, FontWeight.w300, textcolor),textAlign: TextAlign
                                                                                      .left,
                                                                                    maxLines: null,),
                                                                                  SizedBox(height: 20,),
                                                                                  Row(
                                                                                    children: [
                                                                                      Icon(Icons.link,color: b3,size: 20,),
                                                                                      SizedBox(width: 5,),
                                                                                      Text(docs[index]["experiencelink"],style: getsimplestyle(12, FontWeight.w300, textcolor),),
                                                                                    ],
                                                                                  ),


                                                                                ],
                                                                              ),

                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),


                                                                    ],
                                                                  ),

                                                                  index==docs.length-1?Container():Container(
                                                                      child: Container(
                                                                        height: 0.7,
                                                                        width: maxWidth,
                                                                        color: finalgrey,
                                                                      )),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ],
                                                  ));

                                            }

                                            return Container(
                                                padding: EdgeInsets.all(20),

                                                child: Center(
                                                    child: CircularProgressIndicator(
                                                      color: b4,
                                                    )));
                                          }
                                      )


                                    ],
                                  ),
                                ),
                              ],
                            ),
                            MediaQuery
                                .of(context)
                                .size
                                .width > 1160 ? Column(
                              children: [
                                Container(

                                  margin: EdgeInsets.only(
                                      top: 30, right: 10, left: 10, bottom: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 0.7, color: finalgrey),
                                      borderRadius: BorderRadius.circular(7)),
                                  width: maxWidth * 0.26,


                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 30),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons
                                                  .account_circle_outlined,
                                              size: 80,
                                              color: b3,
                                            ),
                                            SizedBox(height: 10,),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Text(doc["name"],
                                                  style: getsimplestyle(
                                                      15, FontWeight.w500,
                                                      textcolor),),
                                              ],
                                            ),
                                            SizedBox(height: 3,),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Text(doc["title"],
                                                  style: getsimplestyle(
                                                      12, FontWeight.normal,
                                                      Colors.grey),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.only(
                                            bottom: 30, top: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                        ),
                                        child: Column(
                                          children: [

                                            Chip(
                                              label: Text(doc["availability"]
                                                  ? "Available Now"
                                                  : "Not Available"),
                                              labelStyle: TextStyle(
                                                  color: b1,
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight
                                                      .w300),
                                              backgroundColor:
                                              doc["availability"]
                                                  ? b5
                                                  : light,
                                            )
                                          ],
                                        ),
                                      )

                                    ],
                                  ),

                                ),


                              ],
                            ) : Container(),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),

                        footer()
                      ],
                      shrinkWrap: true,
                    );
                  }

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
      ),
    );
  }

  searchProject(String ery) {
    setState(() {
      filtereddocs.clear();
      filtereddocs.addAll(documents.where((element) => element["projecttitle"].toString().toLowerCase().contains(ery.toLowerCase())).toList());
    });

    print(filtereddocs);

  }

  TextFormField searchfield() {
    return TextFormField(
      onSaved: (newValue) => search = newValue!,
      controller: _search,
      onChanged: searchProject,
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
        suffixIcon: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 50,
          decoration: BoxDecoration(
              color: b3 ,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7))),
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: 20,
          ),
        ),

        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.circular(50),
        ),
        // errorStyle: TextStyle(fontSize: 12, height: 0.1),
        hintStyle: getsimplestyle(14, FontWeight.normal, Colors.grey),
        hintText: "Search",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }


  void addtosavelist(String key,int i) {
    if(!saved[i].contains(FirebaseAuth.instance.currentUser!.uid)) {
      saved[i].add(FirebaseAuth.instance.currentUser!.uid);
      FirebaseFirestore.instance.collection("projects").doc(key).update({
        "saved": saved[i]
      });
    }else{
      saved[i].remove(FirebaseAuth.instance.currentUser!.uid);
      FirebaseFirestore.instance.collection("projects").doc(key).update({
        "saved":saved[i]
      });
    }


  }

  removeFocus() {
    FocusScope.of(context).unfocus();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  String profilepic(String name){
    List<String> names=name.split(" ");
    if(names.length==1){
      return names[0][0];
    }
    return names[0][0] +names[1][0];
  }



}

