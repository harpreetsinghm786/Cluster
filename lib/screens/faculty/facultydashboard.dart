import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster/Components/Appbar.dart';
import 'package:cluster/Components/footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/Drawerbox.dart';
import '../../constants.dart';
import '../../helper/responsive.dart';
import '../projectdetails.dart';


class facultydashboard extends StatefulWidget {
  const facultydashboard({Key? key}) : super(key: key);

  @override
  _facultydashboardState createState() => _facultydashboardState();
}

class _facultydashboardState extends State<facultydashboard> {
  String? search;
  TextEditingController? _search;
  var stream1,stream2;
  final newprojectform = GlobalKey<FormState>();
  final techstackformKey = GlobalKey<FormState>();
  List techstack = [];
  String dropdownValueyear = 'Under Graduation';
  String cost="Unpaid";
  String? projecttitle, projectdes, link, tech;
  TextEditingController? _projecttitle, _projectdes, _link, _tech,_moneyperhr;

  List documents=[];
  List filtereddocs=[];
  List<bool> tabs=[true,false,false];
  List skills = [];
  List<String> tabnames=["Most Recent","My Works","Saved Posts"];
  int activeindex=0;
  int moneyperhr=0;
  bool languageload = false;
  List<List<dynamic>> saved=[];


  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    _search = new TextEditingController();
    stream1=FirebaseFirestore.instance.collection("facultydata").doc(FirebaseAuth.instance.currentUser!.uid);
    stream2=FirebaseFirestore.instance.collection("projects").orderBy("date",descending: true);
    _projecttitle = new TextEditingController();
    _projectdes = new TextEditingController();
    _link = new TextEditingController();
    _tech = new TextEditingController();
  }

  createcomposeprojectpopup(BuildContext context) {
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
                                        "Compose New Project",
                                        style: getsimplestyle(
                                            20, FontWeight.w500, textcolor),
                                      ),
                                      Container(
                                          child: IconButton(
                                            onPressed: () {
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
                                              key: newprojectform,
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
                                                  projecttitlefield(),



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
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  projectdesfield(),
                                                  SizedBox(
                                                    height: 20,
                                                  ),


                                                  Text(
                                                    "   Cost",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.w500,
                                                        textcolor),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),

                                                  Container(
                                                      height: 50,
                                                      padding: EdgeInsets.only(right: 10),
                                                      decoration: BoxDecoration(
                                                          border:
                                                          Border.all(width: 1, color: b4),
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.circular(50)),
                                                      margin: EdgeInsets.only(
                                                          left: 0,
                                                          right: 0,
                                                          bottom: 0),
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        width: double.infinity,
                                                        child: DropdownButton<String>(
                                                          onTap: removeFocus,
                                                          menuMaxHeight: 200,

                                                          value: cost,
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
                                                            setstate(() {
                                                              cost = newValue!;
                                                            });
                                                          },
                                                          items: <String>['Unpaid', 'Paid']
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
                                                      )),

                                                  SizedBox(height: 20,),


                                                  cost=="Paid"?Column(

                                                    children: [
                                                      Text(
                                                        "   Monthly Stipend",
                                                        style: getsimplestyle(
                                                            13,
                                                            FontWeight.w500,
                                                            textcolor),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      projectmoneyperhrfield(),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                    ],
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                  ):Container(),

                                                  Text(
                                                    "   Entry Level",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.w500,
                                                        textcolor),
                                                  ),

                                                  Text(
                                                    "   I am looking for students from",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.normal,
                                                        Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),

                                                  Container(
                                                      height: 50,
                                                      padding: EdgeInsets.only(right: 10),
                                                      decoration: BoxDecoration(
                                                          border:
                                                          Border.all(width: 1, color: b4),
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.circular(50)),
                                                      margin: EdgeInsets.only(
                                                          left: 0,
                                                          right: 0,
                                                          bottom: 0),
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        width: double.infinity,
                                                        child: DropdownButton<String>(
                                                          onTap: removeFocus,
                                                          menuMaxHeight: 200,

                                                          value: dropdownValueyear,
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
                                                            setstate(() {
                                                              dropdownValueyear = newValue!;
                                                            });
                                                          },
                                                          items: <String>['Under Graduation', 'Post Graduation', 'PHD','Any Course']
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
                                                      )),


                                                  SizedBox(height: 20,),
                                                  Text(
                                                    "   Tech Stack",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.w500,
                                                        textcolor),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Wrap(
                                                    runSpacing: 4,
                                                    spacing: 4,
                                                    children: techstack
                                                        .map(
                                                            (inputChip) =>
                                                            InputChip(
                                                              label:
                                                              Text(
                                                                inputChip,
                                                                style: getsimplestyle(
                                                                    13,
                                                                    FontWeight.w200,
                                                                    b1),
                                                              ),
                                                              backgroundColor:
                                                              light,
                                                              labelStyle: TextStyle(
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color:
                                                                  Colors.black),
                                                              onDeleted: () =>
                                                                  setstate(() =>
                                                                  {
                                                                    techstack.remove(inputChip),
                                                                    // FirebaseFirestore.instance.collection("studentdata").doc(FirebaseAuth.instance.currentUser!.uid).update({"skills":skills})
                                                                  }),
                                                              deleteIconColor:
                                                              b2,
                                                            ))
                                                        .toList(),
                                                  ),
                                                  techstack.length > 0
                                                      ? SizedBox(
                                                    height: 20,
                                                  )
                                                      : Container(),
                                                  Form(
                                                    key: techstackformKey,
                                                    child: TextFormField(
                                                      onFieldSubmitted:
                                                          (value) {
                                                        if (techstackformKey
                                                            .currentState!
                                                            .validate()) {
                                                          techstackformKey
                                                              .currentState!
                                                              .save();

                                                          setstate(() {
                                                            techstack
                                                                .add(value);
                                                            _tech!.clear();
                                                          });
                                                        }
                                                      },
                                                      onSaved: (newValue) =>
                                                      {
                                                        tech = newValue!
                                                      },
                                                      controller: _tech,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Enter Project Technology';
                                                        }
                                                        return null;
                                                      },
                                                      cursorColor:
                                                      Colors.grey,
                                                      style: getsimplestyle(
                                                          14,
                                                          FontWeight.normal,
                                                          Colors.grey),
                                                      decoration:
                                                      InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons.settings,
                                                          color:
                                                          Colors.grey,
                                                          size: 20,
                                                        ),
                                                        border:
                                                        new OutlineInputBorder(
                                                          borderSide:
                                                          new BorderSide(
                                                              color: b4,
                                                              width:
                                                              1.0),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              50),
                                                        ),
                                                        focusedBorder:
                                                        new OutlineInputBorder(
                                                          borderSide:
                                                          new BorderSide(
                                                              color: b4,
                                                              width:
                                                              1.0),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              50),
                                                        ),
                                                        enabledBorder:
                                                        new OutlineInputBorder(
                                                          borderSide:
                                                          new BorderSide(
                                                              color: b4,
                                                              width:
                                                              1.0),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              50),
                                                        ),
                                                        errorBorder:
                                                        new OutlineInputBorder(
                                                          borderSide:
                                                          new BorderSide(
                                                              color: Colors
                                                                  .red,
                                                              width:
                                                              1.0),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              50),
                                                        ),
                                                        disabledBorder:
                                                        new OutlineInputBorder(
                                                          borderSide:
                                                          new BorderSide(
                                                              color: b4,
                                                              width:
                                                              1.0),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              50),
                                                        ),
                                                        hintStyle:
                                                        getsimplestyle(
                                                            14,
                                                            FontWeight
                                                                .normal,
                                                            Colors
                                                                .grey),
                                                        hintText:
                                                        "Technology",
                                                        errorStyle:
                                                        TextStyle(
                                                            fontSize: 9,
                                                            height:
                                                            0.5),
                                                        contentPadding:
                                                        EdgeInsets.only(
                                                            left: 11),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "   Link",
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.w500,
                                                        textcolor),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  projectlinkfield()
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
                                        onPressed: skills.length == 15
                                            ? null
                                            : () async {
                                          if (newprojectform
                                              .currentState!
                                              .validate()) {
                                            newprojectform
                                                .currentState!
                                                .save();

                                            if(techstack.isEmpty){
                                              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Tech Stack is Required")));
                                            }else{
                                              setstate(() {
                                                languageload=true;
                                              });
                                              String key=FirebaseFirestore.instance.collection("tmp").doc().id;
                                              String datetime = DateTime.now().toString();
                                              FirebaseFirestore.instance.collection("projects").doc(key).set({
                                                "projecttitle":projecttitle,
                                                "projectdes":projectdes,
                                                "cost":cost,
                                                "moneyperhr":moneyperhr,
                                                "entrylevel":dropdownValueyear,
                                                "techstack":techstack,
                                                "link":link,
                                                "postedby":FirebaseAuth.instance.currentUser!.uid,
                                                "key":key,
                                                "date":datetime,
                                                "saved":[],
                                                "proposals":[],
                                                "status":"open"
                                              }).then((value) => {
                                                setstate(() {
                                                  languageload=false;
                                                }),
                                                ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Project has been successfully posted"))),

                                                Navigator.of(context).pop()
                                              });
                                            }




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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pagegrey,
      appBar: AppBar(
        backgroundColor: b2,
        centerTitle: true,
        toolbarHeight: Responsive.isdesktop(context) ? 75 : 60,
        elevation: 3,
        title: Appbar(profile: false,activeindex: 0,),
      ),

      drawer: Responsive.istablet(context) ? Drawerbox() : null,
      floatingActionButton:Responsive.istablet(context)? Container(

        margin: EdgeInsets.symmetric(
            horizontal: Responsive.ismobile(context)
                ? 0
                : 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 0.7, color: finalgrey),
            borderRadius: BorderRadius.circular(100)),
        width: 140,

        child: FlatButton(
          color: b3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),

          padding: EdgeInsets.all(20),
          onPressed: () {
            createcomposeprojectpopup(context);

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white,),

              Text("Compose", style: getsimplestyle(
                  12, FontWeight.normal, Colors.white),),

            ],
          ),
        ),

      ):null,

      body: Container(
        child: StreamBuilder<DocumentSnapshot>(
            stream: stream1.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {

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
                                  : MediaQuery.of(context).size.width-30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${now.day} ${months[now.month]} ${now.year}",
                                        style: getsimplestyle(
                                            14, FontWeight.w500, b5),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Good ${greeting()},\n${doc["name"]}",
                                          style: getsimplestyle(
                                              26, FontWeight.w500, Colors.white)),
                                    ],
                                  ),
                                  Container(
                                    child: Stack(
                                      children: [
                                        Container(
                                            child: Icon(
                                              Icons.message,
                                              size:Responsive.istablet(context)?50: 60,
                                              color: b2.withOpacity(0.7),
                                            ),
                                            margin:
                                            EdgeInsets.only(left: 0, bottom: 20)),
                                        Container(
                                            child: Icon(
                                              Icons.message,
                                              size: Responsive.istablet(context)?60:80,
                                              color: b4.withOpacity(1),
                                            ),
                                            margin:
                                            EdgeInsets.only(
                                                left: 100, bottom: 20)),
                                        Container(
                                            child: Icon(Icons.message_outlined,
                                                size: Responsive.istablet(context)?90: 110, color: Colors.white),
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
                                    : MediaQuery.of(context).size.width-30,
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
                                  : MediaQuery.of(context).size.width-30,
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
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                100),
                                            border: Border.all(
                                                width: 0.7, color: finalgrey),
                                          ),
                                          child: Icon(Icons.more_horiz),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(width: 20,),

                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        height: 33,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 3,
                                          shrinkWrap: true,

                                          itemBuilder: (context,index){
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      for(int i=0;i<tabs.length;i++){
                                                        tabs[i]=false;
                                                      }
                                                      tabs[index]=!tabs[index];
                                                      activeindex=index;

                                                    });
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Text(tabnames[index],
                                                        style: getsimplestyle(
                                                          13, FontWeight.w400, tabs[index]?b3:Colors.grey,),),

                                                      Container(
                                                        margin: EdgeInsets.only(top: 10),
                                                        height: 3, width: 120, color: tabs[index]?b3:Colors.transparent,)
                                                    ],
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
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                                        if(snapshot.hasData ){
                                          List docs=snapshot.data!.docs;

                                          documents=[];
                                          documents.addAll(docs);

                                          if(_search!.value.text==""){
                                            filtereddocs=[];
                                            filtereddocs.addAll(docs);
                                          }
                                          saved.clear();
                                          for(int i=0;i<docs.length;i++){
                                            saved.add(docs[i]["saved"]);
                                          }


                                          if(filtereddocs.length==0){
                                            return Container(
                                              padding: EdgeInsets.all(20),
                                              child: Text("No data",style: getsimplestyle(13, FontWeight.normal,textcolor),),
                                            );
                                          }

                                          return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: filtereddocs.length,
                                              itemBuilder: (context, index) {

                                                if(activeindex==1){

                                                  return filtereddocs[index]["postedby"]==FirebaseAuth.instance.currentUser!.uid? FlatButton(

                                                    hoverColor: glase,
                                                    splashColor: Colors.white,
                                                    onPressed: (){
                                                      Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>projectdetails(projectkey: filtereddocs[index]["key"].toString(),role:doc["role"])));
                                                    },
                                                    padding: EdgeInsets.all(0),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.all(20),
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
                                                                        14, FontWeight.w500,
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
                                                                              addtosavelist(docs[index]["key"],index);
                                                                            },
                                                                            icon: Icon(
                                                                              saved[index].contains(FirebaseAuth.instance.currentUser!.uid)?Icons.favorite :Icons.favorite_border,
                                                                              size: 20,
                                                                              color:
                                                                              textcolor,
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(height: 10,),

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Project is "+ filtereddocs[index]["cost"]+" - "+" Open for "+filtereddocs[index]["entrylevel"]+" Posted - "
                                                                          +convertToAgo(DateTime.parse(filtereddocs[index]["date"])),
                                                                      style: getsimplestyle(
                                                                          12,
                                                                          FontWeight.normal,
                                                                          Colors.grey)),

                                                                ],
                                                              ),
                                                              SizedBox(height: 10,),

                                                              Container(
                                                                child: Text(
                                                                  filtereddocs[index]["projectdes"],
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
                                                                  height: 50,
                                                                  child: ScrollConfiguration(
                                                                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                    child: ListView.builder(
                                                                        itemCount: filtereddocs[index]["techstack"].length,
                                                                        shrinkWrap: true,
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemBuilder: (context,i){
                                                                          return Container(
                                                                            margin: EdgeInsets.only(right: 5),
                                                                            child: InputChip(
                                                                              label:
                                                                              Text(
                                                                                filtereddocs[index]["techstack"][i],
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


                                                              SizedBox(height: 10,),

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text("Proposals : ",
                                                                      style: getsimplestyle(
                                                                          12,
                                                                          FontWeight.normal,
                                                                          Colors.grey)),

                                                                  Text(filtereddocs[index]["proposals"].length.toString(),
                                                                      style: getsimplestyle(
                                                                          12,
                                                                          FontWeight.normal,
                                                                          textcolor)),


                                                                ],
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
                                                      ],


                                                    ),
                                                  ):Container();

                                                }else if(activeindex==2){

                                                  return saved[index].contains(FirebaseAuth.instance.currentUser!.uid)?FlatButton(

                                                    hoverColor: glase,
                                                    splashColor: Colors.white,
                                                    onPressed: (){
                                                      Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>projectdetails(projectkey: filtereddocs[index]["key"].toString(),role:doc["role"])));
                                                    },
                                                    padding: EdgeInsets.all(0),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.all(20),
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
                                                                        14, FontWeight.w500,
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
                                                                              addtosavelist(filtereddocs[index]["key"],index);
                                                                            },
                                                                            icon: Icon(
                                                                              saved[index].contains(FirebaseAuth.instance.currentUser!.uid)?Icons.favorite :Icons.favorite_border,
                                                                              size: 20,
                                                                              color:
                                                                              textcolor,
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(height: 10,),

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Project is "+ filtereddocs[index]["cost"]+" - "+" Open for "+filtereddocs[index]["entrylevel"]+" Posted - "
                                                                          +convertToAgo(DateTime.parse(filtereddocs[index]["date"])),
                                                                      style: getsimplestyle(
                                                                          12,
                                                                          FontWeight.normal,
                                                                          Colors.grey)),

                                                                ],
                                                              ),
                                                              SizedBox(height: 10,),

                                                              Container(
                                                                child: Text(
                                                                  filtereddocs[index]["projectdes"],
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
                                                                  height: 50,
                                                                  child: ScrollConfiguration(
                                                                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                    child: ListView.builder(
                                                                        itemCount: filtereddocs[index]["techstack"].length,
                                                                        shrinkWrap: true,
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemBuilder: (context,i){
                                                                          return Container(
                                                                            margin: EdgeInsets.only(right: 5),
                                                                            child: InputChip(
                                                                              label:
                                                                              Text(
                                                                                filtereddocs[index]["techstack"][i],
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


                                                              SizedBox(height: 10,),

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text("Proposals : ",
                                                                      style: getsimplestyle(
                                                                          12,
                                                                          FontWeight.normal,
                                                                          Colors.grey)),

                                                                  Text(filtereddocs[index]["proposals"].length.toString(),
                                                                      style: getsimplestyle(
                                                                          12,
                                                                          FontWeight.normal,
                                                                          textcolor)),


                                                                ],
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
                                                      ],


                                                    ),
                                                  ):Container();

                                                }
                                                return  filtereddocs[index]["status"]=="open"? FlatButton(

                                                  hoverColor: glase,
                                                  splashColor: Colors.white,
                                                  onPressed: (){
                                                    Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>projectdetails(projectkey: filtereddocs[index]["key"].toString(),role:doc["role"])));
                                                  },
                                                  padding: EdgeInsets.all(0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(20),
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
                                                                      14, FontWeight.w500,
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
                                                                            addtosavelist(filtereddocs[index]["key"],index);
                                                                          },
                                                                          icon: Icon(
                                                                            saved[index].contains(FirebaseAuth.instance.currentUser!.uid)?Icons.favorite :Icons.favorite_border,
                                                                            size: 20,
                                                                            color:
                                                                            textcolor,
                                                                          ),
                                                                        )),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(height: 10,),

                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(
                                                                    "Project is "+ filtereddocs[index]["cost"]+" - "+" Open for "+filtereddocs[index]["entrylevel"]+" Posted - "
                                                                        +convertToAgo(DateTime.parse(filtereddocs[index]["date"])),
                                                                    style: getsimplestyle(
                                                                        12,
                                                                        FontWeight.normal,
                                                                        Colors.grey)),

                                                              ],
                                                            ),
                                                            SizedBox(height: 10,),

                                                            Container(
                                                              child: Text(
                                                                filtereddocs[index]["projectdes"],
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
                                                                height: 50,
                                                                child: ScrollConfiguration(
                                                                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                  child: ListView.builder(
                                                                      itemCount: filtereddocs[index]["techstack"].length,
                                                                      shrinkWrap: true,
                                                                      scrollDirection: Axis.horizontal,
                                                                      itemBuilder: (context,i){
                                                                        return Container(
                                                                          margin: EdgeInsets.only(right: 5),
                                                                          child: InputChip(
                                                                            label:
                                                                            Text(
                                                                              filtereddocs[index]["techstack"][i],
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


                                                            SizedBox(height: 10,),

                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text("Proposals : ",
                                                                    style: getsimplestyle(
                                                                        12,
                                                                        FontWeight.normal,
                                                                        Colors.grey)),

                                                                Text(filtereddocs[index]["proposals"].length.toString(),
                                                                    style: getsimplestyle(
                                                                        12,
                                                                        FontWeight.normal,
                                                                        textcolor)),


                                                              ],
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
                                                    ],


                                                  ),
                                                ):Container();

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
                        MediaQuery.of(context).size.width>1160? Column(
                          children: [
                            Container(

                              margin: EdgeInsets.only(top: 30,right: 10,left: 10,bottom: 20),
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
                                    padding: EdgeInsets.only(bottom: 30,top: 10),
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

                            Container(

                              margin: EdgeInsets.symmetric(
                                  horizontal: Responsive.ismobile(context)
                                      ? 0
                                      : 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 0.7, color: finalgrey),
                                  borderRadius: BorderRadius.circular(
                                      Responsive.ismobile(context) ? 0 : 7)),
                              width: Responsive.isdesktop(context)
                                  ? maxWidth * 0.26
                                  : double.infinity,

                              child: FlatButton(
                                color: b3,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),

                                padding: EdgeInsets.all(20),
                                onPressed: () {
                                  createcomposeprojectpopup(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add, color: Colors.white,),

                                    Text("Compose Project", style: getsimplestyle(
                                        12, FontWeight.normal, Colors.white),),

                                  ],
                                ),
                              ),

                            ),


                          ],
                        ):Container(),
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

  TextFormField projecttitlefield() {
    return TextFormField(
      onSaved: (newValue) => projecttitle = newValue!,
      controller: _projecttitle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Project title';
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
        hintText: "Project Title",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }

  TextFormField projectdesfield() {
    return TextFormField(
      maxLines: 6,
      onSaved: (newValue) => projectdes = newValue!,
      controller: _projectdes,
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
        hintText: "Project Description",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.all(11),
      ),
    );
  }

  TextFormField projectlinkfield() {
    return TextFormField(
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
        hintText: "Project Link",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }

  TextFormField projectmoneyperhrfield() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],

      onSaved: (newValue) => moneyperhr = int.parse(newValue!),
      controller: _moneyperhr,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Monthly Stipend';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.monetization_on,
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
        hintText: "Monthly Stipend (In Rs)",
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




}

