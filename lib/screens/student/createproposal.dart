import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Components/Appbar.dart';
import '../../Components/Drawerbox.dart';
import '../../Components/footer.dart';
import '../../constants.dart';
import '../../helper/responsive.dart';
import '../profileviewer.dart';

class proposal extends StatefulWidget {
  String? projectkey;
  proposal({Key? key,this.projectkey}) : super(key: key);

  @override
  _proposalState createState() => _proposalState(projectkey: projectkey);
}

class _proposalState extends State<proposal> {
  int activeindex=0;
  String? projectkey;
  List flow=["Make a Team","Commitments","Relevant Experiences","Preview"];
  String? search;
  TextEditingController? _search;
  var stream1;
  List students=[];
  List selectedmembers=[];
  List hoverlist=[];
  List filterstudents=[];
  double duration=0;
  List selectedbools=[];
  String? description="";
  String? link="";
  bool languageload=false,load=false;
  List commits=[];
  final commitmentformkey = GlobalKey<FormState>();
  final proposalformkey = GlobalKey<FormState>();
  TextEditingController?_description,_link,_days;
  String? committitle="";
  String? commitdes="";
  String? days="";
  var groupleader;
  DateTime date=DateTime.now();

  TextEditingController? _committitle,_commitdes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _search=new TextEditingController();
    stream1=FirebaseFirestore.instance.collection("studentdata").snapshots();
    selectedmembers.clear();
    _description=new TextEditingController();
    _link=new TextEditingController();
    _committitle=new TextEditingController();
    _commitdes=new TextEditingController();
    _days=new TextEditingController();

  }

  _proposalState({this.projectkey});

  editcommitpopup(BuildContext context,String des,String title,String day,int index) {
    setState(() {
      _committitle!.text=title;
      _commitdes!.text=des;
      _days!.text=day;

    });
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {


          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 700,
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                            Border.all(width: 0.7, color: finalgrey),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Add Commitment",
                                        style: getsimplestyle(
                                            20, FontWeight.w500, textcolor),
                                      ),
                                      Container(
                                          child: IconButton(
                                            onPressed: () {
                                              _committitle!.clear();
                                              _commitdes!.clear();
                                              _days!.clear();
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              size: 18,
                                              color: textcolor,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 0.7,
                                  width: double.infinity,
                                  color: finalgrey,
                                ),
                                ListView(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                            EdgeInsets.only(left: 5),
                                            child: Form(
                                              key: commitmentformkey,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "   Title",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.w500,
                                                        textcolor),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  committitlefield(),


                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "   Description",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.w500,
                                                        textcolor),
                                                  ),
                                                  SizedBox(height: 5,),

                                                  commitdesfield(),
                                                  SizedBox(
                                                    height: 20,
                                                  ),

                                                  Text(
                                                    "   Duration",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.w500,
                                                        textcolor),
                                                  ),
                                                  SizedBox(height: 5,),

                                                  daysfield(),

                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  shrinkWrap: true,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 0.7,
                                  width: double.infinity,
                                  color: finalgrey,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  Responsive.istablet(context)
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 45,
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          left: 0,
                                          right: 0,
                                          bottom: 0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.7, color: finalgrey),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: FlatButton(
                                        onPressed: () {
                                          _committitle!.clear();
                                          _commitdes!.clear();
                                          _days!.clear();
                                          Navigator.pop(context);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          "Cancel",
                                          style: getsimplestyle(
                                              13, FontWeight.normal, b4),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 160,
                                      height: 45,
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          left: 0,
                                          right:
                                          Responsive.istablet(context)
                                              ? 0
                                              : 20,
                                          bottom: 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          color: b4),
                                      child: FlatButton(
                                        disabledColor: finalgrey,
                                        onPressed: () async {
                                          if (commitmentformkey
                                              .currentState!
                                              .validate()) {
                                            commitmentformkey
                                                .currentState!
                                                .save();

                                            setState(() {
                                              commits[index]={"title":committitle,
                                                "description":commitdes,
                                              "duration":days};
                                              print(commits.length);
                                            });

                                            Navigator.of(context).pop();

                                            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Commitment Updated Successfully")));


                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          "Save",
                                          style: getsimplestyle(
                                              13,
                                              FontWeight.normal,
                                              Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    shrinkWrap: true,
                  ),
                ),
                languageload == true
                    ? Container(
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
          );
        }));
  }

  createcommitpopup(BuildContext context) {

    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {


          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 700,
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                            Border.all(width: 0.7, color: finalgrey),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Add Commitment",
                                        style: getsimplestyle(
                                            20, FontWeight.w500, textcolor),
                                      ),
                                      Container(
                                          child: IconButton(
                                            onPressed: () {
                                              _committitle!.clear();
                                              _commitdes!.clear();
                                              _days!.clear();
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              size: 18,
                                              color: textcolor,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 0.7,
                                  width: double.infinity,
                                  color: finalgrey,
                                ),
                                ListView(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                            EdgeInsets.only(left: 5),
                                            child: Form(
                                              key: commitmentformkey,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "   Title",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.w500,
                                                        textcolor),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  committitlefield(),


                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "   Description",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.w500,
                                                        textcolor),
                                                  ),
                                                  SizedBox(height: 5,),

                                                  commitdesfield(),
                                                  SizedBox(
                                                    height: 20,
                                                  ),

                                                  Text(
                                                    "   Duration",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.w500,
                                                        textcolor),
                                                  ),
                                                  SizedBox(height: 5,),

                                                  daysfield(),

                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  shrinkWrap: true,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 0.7,
                                  width: double.infinity,
                                  color: finalgrey,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  Responsive.istablet(context)
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 45,
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          left: 0,
                                          right: 0,
                                          bottom: 0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.7, color: finalgrey),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: FlatButton(
                                        onPressed: () {
                                          _committitle!.clear();
                                          _commitdes!.clear();
                                          _days!.clear();
                                          Navigator.pop(context);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          "Cancel",
                                          style: getsimplestyle(
                                              13, FontWeight.normal, b4),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 160,
                                      height: 45,
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          left: 0,
                                          right:
                                          Responsive.istablet(context)
                                              ? 0
                                              : 20,
                                          bottom: 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          color: b4),
                                      child: FlatButton(
                                        disabledColor: finalgrey,
                                        onPressed: () async {
                                          if (commitmentformkey
                                              .currentState!
                                              .validate()) {
                                            commitmentformkey
                                                .currentState!
                                                .save();

                                            setState(() {
                                              commits.add({"title":committitle,
                                                "description":commitdes,
                                                "duration":days});
                                              print(commits.length);
                                            });
                                            _committitle!.clear();
                                            _commitdes!.clear();
                                            _days!.clear();
                                            Navigator.of(context).pop();

                                            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Commitment Added Successfully")));


                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          "Save",
                                          style: getsimplestyle(
                                              13,
                                              FontWeight.normal,
                                              Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    shrinkWrap: true,
                  ),
                ),
                languageload == true
                    ? Container(
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
          );
        }));
  }


   buildGenderDropdown() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Group Leader",style: getsimplestyle(13, FontWeight.w300, Colors.grey),),
        Container(
          alignment: Alignment.centerLeft,
          width: 170,
          child: DropdownButton<dynamic>(
            onTap: removeFocus,
            menuMaxHeight: 200,

            value: groupleader,
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down_circle,
              color: b3,
            ),
            iconSize: 24,
            dropdownColor: Colors.white,
            iconEnabledColor: glase,
            borderRadius: BorderRadius.circular(6),
            elevation: 8,

            underline: Container(
              width: double.infinity,
              height: 1,
              color: Colors.transparent,
            ),
            style: const TextStyle(color: Colors.green),
            onChanged: (dynamic newValue) {
              setState(() {
                groupleader = newValue;
              });
            },
            items: selectedmembers
                .map((m) {
              return DropdownMenuItem<dynamic>(
                value: m,
                child: Container(
                  child: Text(
                    m["name"],
                    style: getsimplestyle(13, FontWeight.w500, textcolor),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  removeFocus() {
    FocusScope.of(context).unfocus();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pagegrey,
      appBar: AppBar(
        backgroundColor: b2,
        toolbarHeight: Responsive.isdesktop(context) ? 75 : 60,
        elevation: 3,
        title: Appbar(profile:false,activeindex:0),
      ),
      drawer: Responsive.istablet(context) ? Drawerbox() : null,
      body:ListView(
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
                              Text("Submit a proposal", style: getsimplestyle(
                                  20, FontWeight.w500, textcolor),)
                            ],
                          ),
                        ),

                        Container(
                          width: maxWidth,
                          height: maxWidth/2,
                          margin: EdgeInsets.symmetric(horizontal: Responsive.istablet(context)? 10:0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.7,color: finalgrey,),
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white
                          ),
                          child: Row(
                            children: [
                              Responsive.istablet(context)?Container():Expanded(
                                flex:1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7),bottomLeft: Radius.circular(7)),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(color: finalgrey,spreadRadius: 1.2,blurRadius: 1.2)],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20,),
                                      Container(
                                        width: maxWidth/4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(7),topLeft: Radius.circular(7)),
                                            color: Colors.white

                                        ),

                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: 4,
                                            itemBuilder: (context,index){
                                          return  Container(

                                            child: Row(
                                              children: [
                                                Container(
                                                    height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(topRight:Radius.circular(7),bottomRight: Radius.circular(7)),
                                                      color:index==activeindex? b3:Colors.white,
                                                  ),
                                                    width: 4,
                                                  ),
                                               Container(
                                                    width: (maxWidth/4)-5,
                                                    height: 50,
                                                    alignment: Alignment.centerLeft,
                                                    color:index==activeindex? b5.withOpacity(0.3):Colors.white,
                                                   padding: EdgeInsets.only(left: 20),
                                                 child:Text(flow[index],style: getsimplestyle(13, FontWeight.w500,index==activeindex? b3:finalgrey),)
                                                  ),


                                              ],
                                            ),
                                          );})
                                      ),


                                    ],
                                  ),
                                ),
                              ),

                              Expanded(
                                flex:3,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: maxWidth/2-2,
                                      color: glase,

                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          Form(
                                          key:proposalformkey,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                activeindex==0? StreamBuilder<QuerySnapshot>(
                                                        stream: stream1,
                                                        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                                          students.clear();
                                                          

                                                          if(snapshot.hasData) {

                                                            List docs=snapshot.data!.docs;

                                                            for(int i=0;i<docs.length;i++) {
                                                              if(docs[i]["uid"]!=FirebaseAuth.instance.currentUser!.uid) {
                                                                students.add(docs[i]);
                                                              }else{
                                                                if(selectedmembers.length==0) {
                                                                  selectedmembers.add(docs[i]);
                                                                  groupleader=docs[i];
                                                                  for(int i=0;i<selectedmembers.length;i++){
                                                                    hoverlist.add(false);
                                                                  }

                                                                }
                                                              }
                                                            }

                                                            if(_search!.value.text.isEmpty){
                                                                filterstudents.clear();
                                                                filterstudents.addAll(students);

                                                            }
                                                            if(selectedbools.isEmpty) {
                                                              for (int i = 0; i <
                                                                  students.length; i++) {
                                                                selectedbools.add(false);
                                                              }
                                                            }

                                                            return Stack(
                                                              alignment: Alignment.bottomCenter,
                                                              children: [
                                                                Container(
                                                                  height: maxWidth/2-2,


                                                                  child: ListView(
                                                                    shrinkWrap: true,
                                                                    scrollDirection: Axis.vertical,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.all(30),
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text("Add Team Members",style: getsimplestyle(18, FontWeight.w500, textcolor),),
                                                                                    Text("Maximum 5 members",style: getsimplestyle(13, FontWeight.w300, Colors.grey),),

                                                                                  ],
                                                                                ),
                                                                                buildGenderDropdown()
                                                                              ],
                                                                            ),


                                                                            SizedBox(height: 15,),
                                                                            Container(
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                    border: Border.all(
                                                                                        width: 0.7, color: finalgrey)),
                                                                                height: 45,

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
                                                                            SizedBox(height: 20,),
                                                                            Container(
                                                                              child: ListView.builder(
                                                                                  itemCount: filterstudents.length,
                                                                                  shrinkWrap: true,
                                                                                  itemBuilder: (
                                                                                      context, index) {

                                                                                    int inm=0;
                                                                                    for(int i=0;i<students.length;i++){
                                                                                      if(students[i]["uid"]==filterstudents[index]["uid"]){
                                                                                        inm=i;
                                                                                      }
                                                                                    }
                                                                                    return  Container(
                                                                                      padding: EdgeInsets
                                                                                          .all(10),
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                          border: Border
                                                                                              .all(
                                                                                            width: 0.7,
                                                                                            color: finalgrey,),
                                                                                          borderRadius: BorderRadius
                                                                                              .only(
                                                                                              topLeft: Radius
                                                                                                  .circular(
                                                                                                  index ==
                                                                                                      0
                                                                                                      ? 7
                                                                                                      : 0),
                                                                                              topRight: Radius
                                                                                                  .circular(
                                                                                                  index ==
                                                                                                      0
                                                                                                      ? 7
                                                                                                      : 0),
                                                                                              bottomRight: Radius
                                                                                                  .circular(
                                                                                                  index ==
                                                                                                      filterstudents.length-1
                                                                                                      ? 7
                                                                                                      : 0),
                                                                                              bottomLeft: Radius
                                                                                                  .circular(
                                                                                                  index ==
                                                                                                      filterstudents.length-1
                                                                                                      ? 7
                                                                                                      : 0))),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Row(
                                                                                            children: [
                                                                                              Container(
                                                                                                child: Icon(Icons.account_circle_outlined,color: b3,size: 40,),
                                                                                              ),
                                                                                              SizedBox(width: 10,),
                                                                                              Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(filterstudents[index]["name"],style: getsimplestyle(13, FontWeight.w500,textcolor),),
                                                                                                  Text(filterstudents[index]["title"],style: getsimplestyle(12, FontWeight.w300, Colors.grey),)
                                                                                                ],
                                                                                              ),

                                                                                            ],
                                                                                          ),
                                                                                          Container(
                                                                                            child: IconButton(
                                                                                              onPressed:(){



                                                                                               if(selectedbools[inm]==false){
                                                                                                 setState(() {
                                                                                                   selectedmembers.add(students[inm]);
                                                                                                   selectedbools[inm]=true;

                                                                                                   hoverlist.clear();
                                                                                                   for(int i=0;i<selectedmembers.length;i++){
                                                                                                     hoverlist.add(false);
                                                                                                   }
                                                                                                 });
                                                                                               }



                                                                                              },
                                                                                                icon: Icon(selectedbools[inm]?Icons.check:Icons.add,color:selectedbools[inm]?Colors.green: textcolor)),
                                                                                            decoration: BoxDecoration(
                                                                                                border: Border.all(width: 0.7,color:selectedbools[inm]?Colors.green: finalgrey),
                                                                                            borderRadius: BorderRadius.circular(100)),
                                                                                          )
                                                                                           ],
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 70,),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 70,
                                                                  padding: EdgeInsets.only(top: 10,bottom: 10,right: 30),

                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      boxShadow: [BoxShadow(color: finalgrey,spreadRadius: 0.9,blurRadius: 0.9)],
                                                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(7),bottomLeft: Radius.circular(Responsive.istablet(context)? 7:0))),

                                                                  child:  Row(
                                                                    children: [

                                                                      Expanded(
                                                                        flex:1,
                                                                        child: Container(
                                                                          height: 55,

                                                                          margin: EdgeInsets.only(left: 30),
                                                                          color: Colors.white,
                                                                          child: ListView.builder(
                                                                            scrollDirection: Axis.horizontal,
                                                                            shrinkWrap: true,
                                                                              itemCount: selectedmembers.length,
                                                                              itemBuilder: (context,index){



                                                                              int inm=0;
                                                                              for(int i=0;i<students.length;i++){
                                                                                if(students[i]["uid"]==selectedmembers[index]["uid"]){
                                                                                  inm=i;
                                                                                }
                                                                              }

                                                                            return  MouseRegion(
                                                                              onEnter: (value){
                                                                                setState(() {
                                                                                  hoverlist[index]=true;
                                                                                });
                                                                              },
                                                                              onExit: (value){
                                                                                setState(() {
                                                                                  hoverlist[index]=false;
                                                                                });

                                                                              },
                                                                              cursor:index!=0? SystemMouseCursors.click:SystemMouseCursors.basic,

                                                                              child: Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: 3),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Container(
                                                                                      padding: EdgeInsets.all(10),
                                                                                      height: 53,
                                                                                      width: 53,
                                                                                      decoration: BoxDecoration(
                                                                                        color: b3,
                                                                                        borderRadius: BorderRadius.circular(100),
                                                                                        border: Border.all(width: 0.7,color: b4,),

                                                                                      ),

                                                                                      child: Center(child: Text(profilepic(selectedmembers[index]["name"]),style: getsimplestyle(18, FontWeight.w600, Colors.white),)),
                                                                                    ),
                                                                                   hoverlist[index] && index!=0?Container(
                                                                                      height: 53,
                                                                                      width: 53,
                                                                                      decoration: BoxDecoration(
                                                                                        color: glass.withOpacity(0.3),
                                                                                        borderRadius: BorderRadius.circular(100),
                                                                                        border: Border.all(width: 0.7,color: b4,),

                                                                                      ),
                                                                                      child: IconButton(
                                                                                          onPressed: (){
                                                                                            setState(() {
                                                                                              groupleader=selectedmembers[0];
                                                                                              selectedmembers.removeAt(index);
                                                                                              selectedbools[inm]=false;
                                                                                            });

                                                                                          },icon:Icon(Icons.clear,color: Colors.white,)),

                                                                                    ):Container(),

                                                                                    groupleader["uid"]==selectedmembers[index]["uid"]?Container(
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
                                                                            );
                                                                          }),

                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 10,),

                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: BorderRadius.circular(100),
                                                                          border: Border.all(width: 1,color:selectedmembers.length<=5 && selectedmembers.length>1?b3:Colors.grey,),

                                                                        ),
                                                                        child: IconButton(
                                                                            onPressed: selectedmembers.length<=5 && selectedmembers.length>1?(){
                                                                          if(activeindex==3){
                                                                            setState(() {
                                                                              activeindex=0;
                                                                            });
                                                                          }else {
                                                                            setState(() {
                                                                              activeindex++;
                                                                            });
                                                                          }
                                                                        }:null, icon:Icon(Icons.arrow_forward,color:selectedmembers.length<=5 && selectedmembers.length>1?b3:Colors.grey,)),
                                                                        padding: EdgeInsets.all(4),

                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          }

                                                          return Container(

                                                              child: Center(
                                                                  child: CircularProgressIndicator(
                                                                    color: b4,
                                                                  )));
                                                        }
                                                      ):Container(),

                                                activeindex==1? Stack(
                                                  alignment: Alignment.bottomCenter,
                                                  children: [
                                                    Container(
                                                      height: maxWidth/2-2,
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        children: [
                                                          Container(

                                                            padding: EdgeInsets.all(30),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text("Starting Date",style: getsimplestyle(18, FontWeight.w500, textcolor),textAlign: TextAlign.start,),
                                                                        SizedBox(height:5),
                                                                        
                                                                        Row(
                                                                          children: [
                                                                            Text("${date.day} ${months[date.month]} ${date.year}",style: getsimplestyle(20, FontWeight.w500, b3),),
                                                                            SizedBox(width: 10,),
                                                                            IconButton(icon:Icon(Icons.calendar_today_rounded,color: textcolor,),onPressed: () async{
                                                                              DateTime? d= await showDatePicker(
                                                                                  context:context,
                                                                                  initialDate:date,
                                                                                  firstDate:DateTime.now(),
                                                                                  lastDate:DateTime(2100),
                                                                                builder: (context,child){
                                                                                    return Theme(
                                                                                      data:Theme.of(context).copyWith(
                                                                                      colorScheme: ColorScheme.light(
                                                                                        primary: b3,
                                                                                        onPrimary: Colors.white,
                                                                                        onSurface: Colors.black
                                                                                      ),
                                                                                      textButtonTheme: TextButtonThemeData(
                                                                                        style: TextButton.styleFrom(
                                                                                          primary: b3
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                      child: child!,
                                                                                    )

                                                                                }

                                                                              );

                                                                              if(d==null) return;

                                                                              setState(() {
                                                                                date=d;
                                                                              });

                                                                            }),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height:5),])


                                                                  ],
                                                                ),

                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text("Add Commitments",style: getsimplestyle(18, FontWeight.w500, textcolor),textAlign: TextAlign.start,),
                                                                        Text("minimum 3 are required",style: getsimplestyle(12,FontWeight.w300,Colors.grey),
                                                                        )
                                                                      ],
                                                                    ),




                                                                        Container(

                                                                          child: IconButton(onPressed: (){
                                                                            createcommitpopup(context);
                                                                          }, icon: Icon(Icons.add),color: textcolor,),
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(width: 0.7,color: finalgrey)),),

                                                                  ],
                                                                ),

                                                                SizedBox(height: 20,),

                                                                commits.length==0?Container(
                                                                  alignment: Alignment.center,
                                                                  margin: EdgeInsets.only(top: 100),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Container(
                                                                          child: Icon(Icons.hourglass_empty,color: Colors.grey,size: 30,),
                                                                      padding: EdgeInsets.all(20),decoration: BoxDecoration(border: Border.all(width: 0.7,color: Colors.grey),borderRadius: BorderRadius.circular(100)),),
                                                                      SizedBox(height: 10,),
                                                                      Text("No Commitment has been added yet",style: getsimplestyle(13, FontWeight.w300, Colors.grey),)
                                                                    ],
                                                                  ),

                                                                ):Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.circular(7),

                                                                    border: Border.all(width: 0.7,color: finalgrey),
                                                                  ),
                                                                  child: ListView.builder(
                                                                      shrinkWrap: true,
                                                                      itemCount: commits.length,
                                                                      itemBuilder: (context, index){
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
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Text(
                                                                                      commits[index]["title"],
                                                                                      style: getsimplestyle(
                                                                                          14, FontWeight.w500,
                                                                                          textcolor),),

                                                                                    Row(
                                                                                      children: [

                                                                                        Container(

                                                                                          child: IconButton(onPressed: (){
                                                                                           editcommitpopup(context, commits[index]["description"], commits[index]["title"], commits[index]["duration"],index);

                                                                                          }, icon: Icon(Icons.edit),color: textcolor,),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(width: 0.7,color: finalgrey)),),
                                                                                        SizedBox(width: 10,),
                                                                                        Container(

                                                                                            child: IconButton(onPressed: (){
                                                                                              setState(() {
                                                                                                commits.removeAt(index);
                                                                                              });

                                                                                            }, icon: Icon(Icons.delete_forever),color: textcolor,),
                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(width: 0.7,color: finalgrey)),),
                                                                                      ],
                                                                                    )
                                                                                  ],

                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10,),

                                                                              Container(
                                                                                child: Text(
                                                                                  commits[index]["description"],
                                                                                  style: getsimplestyle(
                                                                                      13,
                                                                                      FontWeight
                                                                                          .w300,
                                                                                      textcolor),
                                                                                  textAlign: TextAlign.left,
                                                                                  maxLines: null,

                                                                                ),
                                                                              ),

                                                                              SizedBox(height: 10,),

                                                                              Container(
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(Icons.timer,color: Colors.grey,),
                                                                                    SizedBox(width: 10,),
                                                                                    Text(commits[index]["duration"]+" Days",style: getsimplestyle(13, FontWeight.w500, textcolor),)

                                                                                  ],
                                                                                ),
                                                                              )



                                                                            ],
                                                                          ),

                                                                        ),
                                                                        index!=commits.length-1?Container(
                                                                            child: Container(
                                                                              height: 0.7,
                                                                              width: maxWidth,
                                                                              color: finalgrey,
                                                                            )):Container(),
                                                                      ],
                                                                    );
                                                                  }),
                                                                ),
                                                                SizedBox(height: 70,)
                                                              ],
                                                            ),

                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      height: 70,
                                                      padding: EdgeInsets.only(top: 10,bottom: 10,right: 30,left: 30),

                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [BoxShadow(color: finalgrey,spreadRadius: 0.9,blurRadius: 0.9)],
                                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(7),bottomLeft: Radius.circular(Responsive.istablet(context)? 7:0))),

                                                      child:  Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [

                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(100),
                                                              border: Border.all(width: 1,color:selectedmembers.length<=5 && selectedmembers.length>1?b3:Colors.grey,),

                                                            ),
                                                            child: IconButton(
                                                                onPressed: (){

                                                                    setState(() {
                                                                      activeindex--;
                                                                    });

                                                                }, icon:Icon(Icons.arrow_back,color:selectedmembers.length<=5 && selectedmembers.length>1?b3:Colors.grey,)),
                                                            padding: EdgeInsets.all(4),

                                                          ),

                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(100),
                                                              border: Border.all(width: 1,color:commits.length>=3?b3:Colors.grey,),

                                                            ),
                                                            child: IconButton(
                                                                onPressed: commits.length>=3?(){
                                                                  if(activeindex==3){
                                                                    setState(() {
                                                                      activeindex=0;
                                                                    });
                                                                  }else {
                                                                    setState(() {
                                                                      activeindex++;
                                                                    });
                                                                  }
                                                                }:null, icon:Icon(Icons.arrow_forward,color:commits.length>=3?b3:Colors.grey,)),
                                                            padding: EdgeInsets.all(4),

                                                          ),


                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ):Container(),

                                                activeindex==2? Stack(
                                                  alignment: Alignment.bottomCenter,
                                                  children: [
                                                    Container(
                                                      height: maxWidth/2-2,
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        children: [
                                                          Container(

                                                            padding: EdgeInsets.all(30),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text("Add Relevant Experiences",style: getsimplestyle(18, FontWeight.w500, textcolor),textAlign: TextAlign.start,),

                                                                  ],
                                                                ),

                                                                SizedBox(height: 20,),

                                                                Container(
                                                                  color: Colors.white,
                                                                    child: projectdesfield()),

                                                                SizedBox(height: 10,),

                                                                Container(
                                                                  color: Colors.white,
                                                                    child: projectlinkfield()),

                                                                SizedBox(height: 70,)
                                                              ],
                                                            ),

                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      height: 70,
                                                      padding: EdgeInsets.only(top: 10,bottom: 10,right: 30,left: 30),

                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [BoxShadow(color: finalgrey,spreadRadius: 0.9,blurRadius: 0.9)],
                                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(7),bottomLeft: Radius.circular(Responsive.istablet(context)? 7:0))),

                                                      child:  Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [

                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(100),
                                                              border: Border.all(width: 1,color:b3),

                                                            ),
                                                            child: IconButton(
                                                                onPressed: (){

                                                                  setState(() {
                                                                    activeindex--;
                                                                  });

                                                                }, icon:Icon(Icons.arrow_back,color: b3)),
                                                            padding: EdgeInsets.all(4),

                                                          ),

                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(100),
                                                              border: Border.all(width: 1,color:description!="" && link!=""?b3:Colors.grey,),

                                                            ),
                                                            child: IconButton(
                                                                onPressed: description!="" && link!=""?(){
                                                                  if(activeindex==3){
                                                                    setState(() {
                                                                      activeindex=0;
                                                                    });
                                                                  }else {
                                                                    duration=0;
                                                                    for(int i=0;i<commits.length;i++){
                                                                      duration+=double.parse(commits[i]["duration"]);
                                                                    }
                                                                    setState(() {

                                                                      activeindex++;
                                                                    });
                                                                  }
                                                                }:null, icon:Icon(Icons.arrow_forward,color:description!="" && link!=""?b3:Colors.grey,)),
                                                            padding: EdgeInsets.all(4),

                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ):Container(),

                                                activeindex==3? Stack(
                                                  alignment: Alignment.bottomCenter,
                                                  children: [
                                                    Container(
                                                      height: maxWidth/2-2,
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                        padding: EdgeInsets.all(30),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text("Preview",style: getsimplestyle(18, FontWeight.w500, textcolor),textAlign: TextAlign.start,),

                                                                          Text("Duration: "+duration.toString()+" Days" )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        child: Container(
                                                                          height: 0.7,
                                                                          width: double.infinity,
                                                                          color: finalgrey,
                                                                        ))
                                                                  ],
                                                                ),



                                                                Container(
                                                                  padding: EdgeInsets.all(30),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text("Team",style: getsimplestyle(14, FontWeight.w500, textcolor),),
                                                                      SizedBox(height: 10,),
                                                                      Container(
                                                                        height: 55,
                                                                        color: Colors.transparent,
                                                                        child: ListView.builder(
                                                                            scrollDirection: Axis.horizontal,
                                                                            shrinkWrap: true,
                                                                            itemCount: selectedmembers.length,
                                                                            itemBuilder: (context,index){


                                                                              int inm=0;
                                                                              for(int i=0;i<students.length;i++){
                                                                                if(students[i]["uid"]==selectedmembers[index]["uid"]){
                                                                                  inm=i;
                                                                                }
                                                                              }

                                                                              return  Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: 3),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Container(
                                                                                      padding: EdgeInsets.all(10),
                                                                                      height: 53,
                                                                                      width: 53,
                                                                                      decoration: BoxDecoration(
                                                                                        color: b3,
                                                                                        borderRadius: BorderRadius.circular(100),
                                                                                        border: Border.all(width: 0.7,color: b4,),

                                                                                      ),

                                                                                      child: Center(child: Text(profilepic(selectedmembers[index]["name"]),style: getsimplestyle(18, FontWeight.w600, Colors.white),)),
                                                                                    ),

                                                                                    groupleader["uid"]==selectedmembers[index]["uid"]?Container(
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
                                                                              );
                                                                            }),

                                                                      ),
                                                                      SizedBox(height: 20,),
                                                                      Row(
                                                                        children: [
                                                                          Text("Starting Date: ",style: getsimplestyle(14, FontWeight.w500, textcolor),),
                                                                          Text("${date.day} ${months[date.month]} ${date.year}",style: getsimplestyle(13, FontWeight.w500, b3),),
                                                                        ],
                                                                      ),


                                                                      SizedBox(height: 20,),

                                                                      Text("Commitments",style: getsimplestyle(14, FontWeight.w500, textcolor),),
                                                                      SizedBox(height: 10,),

                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: BorderRadius.circular(7),

                                                                          border: Border.all(width: 0.7,color: finalgrey),
                                                                        ),
                                                                        child: ListView.builder(
                                                                            shrinkWrap: true,
                                                                            itemCount: commits.length,
                                                                            itemBuilder: (context, index){
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
                                                                                                commits[index]["title"],
                                                                                                style: getsimplestyle(
                                                                                                    14, FontWeight.w500,
                                                                                                    textcolor),),
                                                                                              Container(
                                                                                                alignment: Alignment.topRight,
                                                                                                child: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                                  children: [
                                                                                                    Icon(Icons.timer,color: Colors.grey,),
                                                                                                    SizedBox(width: 10,),
                                                                                                    Text(commits[index]["duration"]+" Days",style: getsimplestyle(13, FontWeight.w500, textcolor),)

                                                                                                  ],
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(height: 10,),

                                                                                        Container(
                                                                                          child: Text(
                                                                                            commits[index]["description"],
                                                                                            style: getsimplestyle(
                                                                                                13,
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
                                                                                  index!=commits.length-1?Container(
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
                                                                      Text("Experiences",style: getsimplestyle(14, FontWeight.w500, textcolor),),
                                                                      SizedBox(height: 10,),
                                                                      Text(description!,style: getsimplestyle(13, FontWeight.w500, Colors.grey),),
                                                                      SizedBox(height: 20,),
                                                                      Row(
                                                                        children: [
                                                                          Icon(Icons.link,color: Colors.grey,),
                                                                          SizedBox(width: 10,),
                                                                          Text(link!,style: getsimplestyle(13, FontWeight.w500, Colors.grey),),
                                                                        ],
                                                                      ),

                                                                      SizedBox(height: 70,)
                                                                    ],
                                                                  ),
                                                                ),


                                                              ],
                                                            ),

                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      height: 70,
                                                      padding: EdgeInsets.only(top: 10,bottom: 10,right: 30,left: 30),

                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [BoxShadow(color: finalgrey,spreadRadius: 0.9,blurRadius: 0.9)],
                                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(7),
                                                              bottomLeft: Radius.circular(Responsive.istablet(context)? 7:0))),

                                                      child:  Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(100),
                                                              border: Border.all(width: 1,color:b3),

                                                            ),
                                                            child: IconButton(
                                                                onPressed: (){

                                                                  setState(() {
                                                                    activeindex--;
                                                                  });

                                                                }, icon:Icon(Icons.arrow_back,color: b3)),
                                                            padding: EdgeInsets.all(4),

                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(100),
                                                              border: Border.all(width: 1,color:b3,),

                                                            ),
                                                            child: IconButton(
                                                                onPressed: (){
                                                                  print(selectedmembers.toString());

                                                                  List group=[];
                                                                  for(int i=0;i<selectedmembers.length;i++){
                                                                    group.add({"name":selectedmembers[i]["name"],
                                                                               "uid":selectedmembers[i]["uid"]});
                                                                  }
                                                                  if(proposalformkey.currentState!.validate()){
                                                                    proposalformkey.currentState!.save();
                                                                    setState(() {
                                                                      load=true;
                                                                    });


                                                                    String? proposalkey=FirebaseFirestore.instance.collection("temp").doc().id;
                                                                    String datetime = DateTime.now().toString();
                                                                    FirebaseFirestore.instance.collection("proposals").doc(proposalkey).set({
                                                                      "key":proposalkey,
                                                                      "groupleader":groupleader["uid"],
                                                                      "postdate":datetime,
                                                                      "startdate":date,
                                                                      "projectkey":projectkey,
                                                                      "team":group,
                                                                      "commitments":commits,
                                                                      "duration":duration.toString(),
                                                                      "experiencedes":description,
                                                                      "experiencelink":link,
                                                                      "status":"pending"
                                                                    }).then((value) => {
                                                                    setState(() {
                                                                    load=false;
                                                                    }),
                                                                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Proposal Submitted Successfully"))),
                                                                      Navigator.pop(context)

                                                                   });
                                                                  }}, icon:Icon(Icons.check,color:b3,)),
                                                            padding: EdgeInsets.all(4),

                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ):Container()


                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    load?Container(
                                        child:Center(
                                            child:CircularProgressIndicator(color:b3)
                                        )
                                    ):Container()
                                  ],
                                ),




                              )
                            ],
                          ),
                        )

                      ],
                    ),
                  ),

                  footer()
                ],
              )


    );
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

  String profilepic(String name){
    List<String> names=name.split(" ");
    if(names.length==1){
      return names[0][0];
    }
    return names[0][0] +names[1][0];
  }

  searchProject(String ery) {
    setState(() {
      filterstudents.clear();
      filterstudents.addAll(students.where((element) => element["name"].toString().toLowerCase().contains(ery.toLowerCase())).toList());
    });


  }

  TextFormField projectdesfield() {
    return TextFormField(
      maxLines: 8,
      onChanged: (value){setState(() {
        description=value;
      });},
      onSaved: (newValue) => description = newValue!,
      controller: _description,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Project Description';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: finalgrey, width: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: finalgrey, width: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        enabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: finalgrey, width: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: finalgrey, width: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        hintStyle: getsimplestyle(14, FontWeight.normal, Colors.grey),
        hintText: "Project Description",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 7,top: 20),
      ),
    );
  }


  TextFormField projectlinkfield() {
    return TextFormField(
      onChanged: (value){setState(() {
        link=value;
      });},
      onSaved: (newValue) => link = newValue!,
      controller: _link,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Project Link';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),

      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.link,
          color: Colors.grey,
          size: 20,
        ),
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: finalgrey, width: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: finalgrey, width: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        enabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: finalgrey, width: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: finalgrey, width: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        hintStyle: getsimplestyle(14, FontWeight.normal, Colors.grey),
        hintText: "Project Link",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 7),
      ),
    );
  }

  TextFormField committitlefield() {
    return TextFormField(
      onSaved: (newValue) => committitle = newValue!,
      controller: _committitle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Commitment title';
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
        hintText: "Commitment Title",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }

  TextFormField commitdesfield() {
    return TextFormField(
      maxLines: 6,
      onSaved: (newValue) => commitdes = newValue!,
      controller: _commitdes,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Commitment Description';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(7),
        ),
        enabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(7),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(7),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 1.0),
          borderRadius: BorderRadius.circular(7),
        ),
        hintStyle: getsimplestyle(14, FontWeight.normal, Colors.grey),
        hintText: "Commitment Description",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.all(11),
      ),
    );
  }

  TextFormField daysfield() {
    return TextFormField(
      onSaved: (newValue) => days= newValue.toString(),
      controller: _days,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Days';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.timer,
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
        hintText: "Days",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }



}

