import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster/Components/Appbar.dart';
import 'package:cluster/Components/Drawerbox.dart';
import 'package:cluster/screens/student/multiimageuploader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:youtube_parser/youtube_parser.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../Components/Corouselitem.dart';
import '../../Components/footer.dart';
import '../../constants.dart';
import '../../helper/responsive.dart';
import 'studentlogin.dart';

class Studentprofile extends StatefulWidget {
  const Studentprofile({Key? key}) : super(key: key);

  @override
  _StudentprofileState createState() => _StudentprofileState();
}

class _StudentprofileState extends State<Studentprofile> {
  var stream;
  String? videourl, language;
  String? school, fromdate, todate, degree;
  String? username, dropdownvalueyear;
  String? title, coverletter, skill;
  String? projecttitle, projectdes, link, tech;
  List screenshots = [];
  List techstack = [];
  TextEditingController? _projecttitle, _projectdes, _link, _tech;
  TextEditingController? _title, _coverletter, _skill;
  bool? availablity;
  TextEditingController? _username;
  TextEditingController? _school, _fromdate, _todate, _degree;
  TextEditingController? _videourl, _language;
  bool disablesave = true;
  bool languagedisablesave = true;
  bool educationdisablesave = true;
  bool load = false;
  bool languageload = false;
  List languages = [];
  List Educations = [];
  List works = [];
  List<bool> workshover = [];
  YoutubePlayerController? _controller;
  List skills = [];
  double perce = 0;
  bool publicview = true;
  RegExp regExp = RegExp(
      r'((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?');

  final formKey = GlobalKey<FormState>();
  final languageformKey = GlobalKey<FormState>();
  final educationformKey = GlobalKey<FormState>();
  final basicprofileformKey = GlobalKey<FormState>();
  final coverprofileformKey = GlobalKey<FormState>();
  final skillformKey = GlobalKey<FormState>();
  final techstackformKey = GlobalKey<FormState>();
  final workhistoryformKey = GlobalKey<FormState>();
  String? dropdownvideotype = 'Me Talking About my skills and Experience';
  String? dropdownlanguage = 'Basic';

  List<Widget> itemPhotosWidgetList = <Widget>[];

  final ImagePicker _picker = ImagePicker();
  File? file;
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];

  List<String> downloadUrl = <String>[];

  bool uploading = false;
  List<bool> mouse = [];

  @override
  void dispose() {

    super.dispose();
    _videourl!.dispose();
  }

  @override
  void initState() {

    super.initState();
    stream = FirebaseFirestore.instance
        .collection("studentdata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    _videourl = TextEditingController();
    _language = TextEditingController();
    _school = TextEditingController();
    _fromdate = TextEditingController();
    _todate = TextEditingController();
    _degree = TextEditingController();
    _username = new TextEditingController();
    _title = new TextEditingController();
    _coverletter = new TextEditingController();
    _skill = new TextEditingController();
    _projecttitle = new TextEditingController();
    _projectdes = new TextEditingController();
    _link = new TextEditingController();
    _tech = new TextEditingController();
  }

  createIntrovideoDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {
              _videourl!.addListener(() {
                final disable = _videourl!.value.text.isEmpty;
                setstate(() {
                  this.disablesave = disable;
                });
              });

              return Dialog(
                backgroundColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 420,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7, color: finalgrey),
                          borderRadius: BorderRadius.circular(7)),
                      width: 700,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add video introduction",
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
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "   Link to your YouTube video",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    videolinkfield(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "   What type of video is this?",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        height: 50,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(width: 1, color: b4),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: DropdownButton<String>(
                                            onTap: removeFocus,
                                            menuMaxHeight: 200,
                                            isExpanded: true,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: textcolor,
                                            ),
                                            iconSize: 24,
                                            dropdownColor: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 16,
                                            itemHeight: 50,
                                            underline: Container(
                                              width: double.infinity,
                                              height: 1,
                                              color: Colors.transparent,
                                            ),
                                            style: const TextStyle(
                                                color: Colors.green),
                                            onChanged: (newValue) {
                                              setstate(() {
                                                dropdownvideotype = newValue;
                                              });
                                            },
                                            value: dropdownvideotype,
                                            items: <String>[
                                              'Me Talking About my skills and Experience',
                                              'Visual Samples of my works',
                                              'Something Else'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    value,
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.normal,
                                                        textcolor),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                            mainAxisAlignment: Responsive.istablet(context)
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 160,
                                height: 45,
                                margin: EdgeInsets.only(
                                    top: 10, left: 0, right: 0, bottom: 0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.7, color: finalgrey),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
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
                                    top: 10, left: 0, right: 20, bottom: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: b4),
                                child: FlatButton(
                                  disabledColor: finalgrey,
                                  onPressed: disablesave
                                      ? null
                                      : () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            setstate(() => {load = true});

                                            FirebaseFirestore.instance
                                                .collection("studentdata")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .update({
                                              "introvideo": videourl
                                            }).then((value) => {
                                                      setstate(() => {
                                                            load = false,
                                                          }),
                                                      _videourl!.clear(),
                                                      Navigator.pop(context),
                                                    });
                                          }
                                        },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Save",
                                    style: getsimplestyle(
                                        13, FontWeight.normal, Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    load == true
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

  createDeletepopup(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 420,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7, color: finalgrey),
                          borderRadius: BorderRadius.circular(7)),
                      width: 700,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      "Delete video introduction",
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
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Are you sure you want to delete your video?",
                                    style: getsimplestyle(
                                        13, FontWeight.normal, textcolor),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 0.7,
                                width: double.infinity,
                                color: finalgrey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: Responsive.istablet(context)
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 160,
                                    height: 45,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 0, right: 0, bottom: 0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.7, color: finalgrey),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
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
                                        top: 10, left: 0, right: 20, bottom: 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: b4),
                                    child: FlatButton(
                                      disabledColor: finalgrey,
                                      onPressed: () {
                                        setstate(() => {load = true});
                                        FirebaseFirestore.instance
                                            .collection("studentdata")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          "introvideo": "null"
                                        }).then((value) => {
                                                  setstate(
                                                      () => {load = false}),
                                                  Navigator.pop(context)
                                                });
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        "Delete",
                                        style: getsimplestyle(13,
                                            FontWeight.normal, Colors.white),
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
                    load == true
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

  createplaypopup(BuildContext context, String url) {
    _controller = YoutubePlayerController(
      initialVideoId: getIdFromUrl(url)!,
      params: YoutubePlayerParams(
        startAt: Duration(seconds: 0),
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: Responsive.ismobile(context) ? 400 : 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7, color: finalgrey),
                          borderRadius: BorderRadius.circular(7)),
                      width: 700,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      "Video introduction",
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
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.all(20),
                                child: Container(
                                  child: YoutubePlayerIFrame(
                                    controller: _controller,
                                    aspectRatio: 16 / 9,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    load == true
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

  createaddlanguagepopup(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {
              _language!.addListener(() {
                final disable = _language!.value.text.isEmpty;
                setstate(() {
                  this.languagedisablesave = disable;
                });
              });

              return Dialog(
                backgroundColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 420,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7, color: finalgrey),
                          borderRadius: BorderRadius.circular(7)),
                      width: 700,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add language",
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
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Form(
                                key: languageformKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "   Language",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    languagefield(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "   Proficiency level",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        height: 50,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(width: 1, color: b4),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: DropdownButton<String>(
                                            onTap: removeFocus,
                                            menuMaxHeight: 200,
                                            isExpanded: true,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: textcolor,
                                            ),
                                            iconSize: 24,
                                            dropdownColor: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 16,
                                            itemHeight: 50,
                                            underline: Container(
                                              width: double.infinity,
                                              height: 1,
                                              color: Colors.transparent,
                                            ),
                                            style: const TextStyle(
                                                color: Colors.green),
                                            onChanged: (newValue) {
                                              setstate(() {
                                                dropdownlanguage = newValue;
                                              });
                                            },
                                            value: dropdownlanguage,
                                            items: <String>[
                                              'Basic',
                                              'Coversational',
                                              'Fluent',
                                              'Native or Biligual'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    value,
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.normal,
                                                        textcolor),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                            mainAxisAlignment: Responsive.istablet(context)
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 160,
                                height: 45,
                                margin: EdgeInsets.only(
                                    top: 10, left: 0, right: 0, bottom: 0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.7, color: finalgrey),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: FlatButton(
                                  onPressed: () {
                                    dropdownlanguage = 'Basic';
                                    _language!.clear();
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
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
                                    top: 10, left: 0, right: 20, bottom: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: b4),
                                child: FlatButton(
                                  disabledColor: finalgrey,
                                  onPressed: languagedisablesave
                                      ? null
                                      : () {
                                          if (languageformKey.currentState!
                                              .validate()) {
                                            languageformKey.currentState!
                                                .save();

                                            setstate(
                                                () => {languageload = true});

                                            languages.add({
                                              "name": language,
                                              "proficiency": dropdownlanguage
                                            });

                                            FirebaseFirestore.instance
                                                .collection("studentdata")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .update({
                                              "language": languages
                                            }).then((value) => {
                                                      setstate(() => {
                                                            languageload =
                                                                false,
                                                            dropdownlanguage =
                                                                'Basic'
                                                          }),
                                                      _language!.clear(),
                                                      Navigator.pop(context),
                                                    });
                                          }
                                        },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Save",
                                    style: getsimplestyle(
                                        13, FontWeight.normal, Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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

  createDeletelanguagepopup(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 420,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7, color: finalgrey),
                          borderRadius: BorderRadius.circular(7)),
                      width: 700,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      "Delete Langauge",
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
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Are you sure you want to delete this Language?",
                                    style: getsimplestyle(
                                        13, FontWeight.normal, textcolor),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 0.7,
                                width: double.infinity,
                                color: finalgrey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: Responsive.istablet(context)
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 160,
                                    height: 45,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 0, right: 0, bottom: 0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.7, color: finalgrey),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
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
                                        top: 10, left: 0, right: 20, bottom: 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: b4),
                                    child: FlatButton(
                                      disabledColor: finalgrey,
                                      onPressed: () {
                                        setstate(() => {load = true});

                                        FirebaseFirestore.instance
                                            .collection("studentdata")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          "language": FieldValue.arrayRemove(
                                              [languages[index]])
                                        }).then((value) => {
                                                  setstate(
                                                      () => {load = false}),
                                                  Navigator.pop(context)
                                                });
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        "Delete",
                                        style: getsimplestyle(13,
                                            FontWeight.normal, Colors.white),
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
                    load == true
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

  createaddeducationpopup(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7, color: finalgrey),
                          borderRadius: BorderRadius.circular(7)),
                      width: 700,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add Education",
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
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Form(
                                key: educationformKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "   School",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    schoolfield(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "   Date Attended",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: fromdatefield(),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(flex: 1, child: todatefield())
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "   Degree",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    degreefield()
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                            mainAxisAlignment: Responsive.istablet(context)
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 160,
                                height: 45,
                                margin: EdgeInsets.only(
                                    top: 10, left: 0, right: 0, bottom: 0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.7, color: finalgrey),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: FlatButton(
                                  onPressed: () {
                                    _school!.clear();
                                    _fromdate!.clear();
                                    _todate!.clear();
                                    _degree!.clear();
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
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
                                        Responsive.istablet(context) ? 0 : 20,
                                    bottom: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: b4),
                                child: FlatButton(
                                  disabledColor: finalgrey,
                                  onPressed: () {
                                    if (educationformKey.currentState!
                                        .validate()) {
                                      educationformKey.currentState!.save();

                                      setstate(() => {languageload = true});

                                      Educations.add({
                                        "school": school,
                                        "from": fromdate,
                                        "to": todate,
                                        "degree": degree
                                      });

                                      FirebaseFirestore.instance
                                          .collection("studentdata")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        "education": Educations
                                      }).then((value) => {
                                                setstate(() => {
                                                      languageload = false,
                                                    }),
                                                _school!.clear(),
                                                _fromdate!.clear(),
                                                _todate!.clear(),
                                                _degree!.clear(),
                                                Navigator.pop(context),
                                              });
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Save",
                                    style: getsimplestyle(
                                        13, FontWeight.normal, Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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

  createDeleteeducationpopup(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 420,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7, color: finalgrey),
                          borderRadius: BorderRadius.circular(7)),
                      width: 700,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      "Delete Education",
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
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Are you sure you want to delete this Education?",
                                    style: getsimplestyle(
                                        13, FontWeight.normal, textcolor),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 0.7,
                                width: double.infinity,
                                color: finalgrey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: Responsive.istablet(context)
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 160,
                                    height: 45,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 0, right: 0, bottom: 0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.7, color: finalgrey),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
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
                                        top: 10, left: 0, right: 20, bottom: 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: b4),
                                    child: FlatButton(
                                      disabledColor: finalgrey,
                                      onPressed: () {
                                        setstate(() => {load = true});

                                        FirebaseFirestore.instance
                                            .collection("studentdata")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          "education": FieldValue.arrayRemove(
                                              [Educations[index]])
                                        }).then((value) => {
                                                  setstate(
                                                      () => {load = false}),
                                                  Navigator.pop(context)
                                                });
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        "Delete",
                                        style: getsimplestyle(13,
                                            FontWeight.normal, Colors.white),
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
                    load == true
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

  createbasicprofileeditor(String? name, String? year, bool? availability) {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7, color: finalgrey),
                          borderRadius: BorderRadius.circular(7)),
                      width: 700,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Edit Basic Profile",
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
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Form(
                                key: basicprofileformKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "   Username",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    usernamefield(username),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "   Year",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        height: 50,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(width: 1, color: b4),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: DropdownButton<String>(
                                            onTap: removeFocus,
                                            menuMaxHeight: 200,
                                            isExpanded: true,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: textcolor,
                                            ),
                                            iconSize: 24,
                                            dropdownColor: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 16,
                                            itemHeight: 50,
                                            underline: Container(
                                              width: double.infinity,
                                              height: 1,
                                              color: Colors.transparent,
                                            ),
                                            style: const TextStyle(
                                                color: Colors.green),
                                            onChanged: (newValue) {
                                              setstate(() {
                                                dropdownvalueyear = newValue;
                                              });
                                            },
                                            value: dropdownvalueyear,
                                            items: <String>[
                                              'First',
                                              'Sencond',
                                              'Third',
                                              'Fourth'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    value,
                                                    style: getsimplestyle(
                                                        13,
                                                        FontWeight.normal,
                                                        textcolor),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "   Availability",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            availablity!
                                                ? "Available now"
                                                : "Not Available",
                                            style: getsimplestyle(
                                                13,
                                                FontWeight.normal,
                                                availablity!
                                                    ? b4
                                                    : Colors.grey),
                                          ),
                                          Switch(
                                            onChanged: (value) {
                                              setstate(() {
                                                availablity = !availablity!;
                                              });
                                            },
                                            value: availablity!,
                                            activeColor: b4,
                                            activeTrackColor: finalgrey,
                                            inactiveThumbColor: finalgrey,
                                            inactiveTrackColor: Colors.grey,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                            mainAxisAlignment: Responsive.istablet(context)
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 160,
                                height: 45,
                                margin: EdgeInsets.only(
                                    top: 10, left: 0, right: 0, bottom: 0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.7, color: finalgrey),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
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
                                        Responsive.istablet(context) ? 0 : 20,
                                    bottom: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: b4),
                                child: FlatButton(
                                  disabledColor: finalgrey,
                                  onPressed: () {
                                    if (basicprofileformKey.currentState!
                                        .validate()) {
                                      basicprofileformKey.currentState!.save();

                                      setstate(() => {languageload = true});

                                      FirebaseFirestore.instance
                                          .collection("studentdata")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        "name": username!,
                                        "year": dropdownvalueyear,
                                        "availability": availablity
                                      }).then((value) => {
                                                setstate(() => {
                                                      languageload = false,
                                                    }),
                                                Navigator.pop(context),
                                              });
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Save",
                                    style: getsimplestyle(
                                        13, FontWeight.normal, Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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

  createEditcoverpopup(BuildContext context, String? t, String? c) {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setstate) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7, color: finalgrey),
                          borderRadius: BorderRadius.circular(7)),
                      width: 700,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Edit Cover Letter",
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
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Form(
                                key: coverprofileformKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "   Profile Title",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    titlefield(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "   Cover Letter",
                                      style: getsimplestyle(
                                          13, FontWeight.normal, textcolor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    coverletterfield(coverletter!)
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                            mainAxisAlignment: Responsive.istablet(context)
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 160,
                                height: 45,
                                margin: EdgeInsets.only(
                                    top: 10, left: 0, right: 0, bottom: 0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.7, color: finalgrey),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
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
                                        Responsive.istablet(context) ? 0 : 20,
                                    bottom: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: b4),
                                child: FlatButton(
                                  disabledColor: finalgrey,
                                  onPressed: () {
                                    if (coverprofileformKey.currentState!
                                        .validate()) {
                                      coverprofileformKey.currentState!.save();

                                      setstate(() => {languageload = true});

                                      FirebaseFirestore.instance
                                          .collection("studentdata")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        "title": title,
                                        "cover": coverletter
                                      }).then((value) => {
                                                setstate(() => {
                                                      languageload = false,
                                                    }),
                                                Navigator.pop(context),
                                              });
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Save",
                                    style: getsimplestyle(
                                        13, FontWeight.normal, Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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

  createSkilleditpopup(BuildContext context) {
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
                                            "Edit Skills",
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
                                          padding: EdgeInsets.all(20),
                                          child: Form(
                                            key: basicprofileformKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Skills",
                                                        style: getsimplestyle(
                                                            13,
                                                            FontWeight.w500,
                                                            textcolor),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "Keeping your skills up to date helps you get the jobs you want.",
                                                        style: getsimplestyle(
                                                            13,
                                                            FontWeight.w200,
                                                            textcolor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Form(
                                                    key: skillformKey,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Wrap(
                                                          runSpacing: 4,
                                                          spacing: 4,
                                                          children: skills
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
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black),
                                                                        onDeleted: () =>
                                                                            setstate(() =>
                                                                                {
                                                                                  skills.remove(inputChip),
                                                                                  FirebaseFirestore.instance.collection("studentdata").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                                                                    "skills": skills
                                                                                  })
                                                                                }),
                                                                        deleteIconColor:
                                                                            b2,
                                                                      ))
                                                              .toList(),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        skillfield(),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          " Maximum 15 Skills",
                                                          style: getsimplestyle(
                                                              13,
                                                              FontWeight.normal,
                                                              textcolor),
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ),
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
                                                : () {
                                                    if (skillformKey
                                                        .currentState!
                                                        .validate()) {
                                                      skillformKey.currentState!
                                                          .save();

                                                      setstate(() => {
                                                            languageload = true
                                                          });
                                                      skills.add(skill);

                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              "studentdata")
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .update({
                                                        "skills": skills,
                                                      }).then((value) => {
                                                                setstate(() => {
                                                                      languageload =
                                                                          false,
                                                                      _skill!
                                                                          .clear(),
                                                                    }),
                                                              });
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

  xFileToImage(XFile xFile) async {
    final Uint8List bytes = await xFile.readAsBytes();
    return Image.memory(bytes).image;
  }

  createworkhistorypopup(BuildContext context) {
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
                                            "Add Recent Work",
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
                                                  key: workhistoryformKey,
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
                                                        "   Screen Shots",
                                                        style: getsimplestyle(
                                                            13,
                                                            FontWeight.w500,
                                                            textcolor),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7.0)),
                                                                child: GridView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                            mainAxisSpacing:
                                                                                5,
                                                                            crossAxisSpacing:
                                                                                5,
                                                                            crossAxisCount: Responsive.ismobile(context)
                                                                                ? 4
                                                                                : 5),
                                                                        itemCount:
                                                                            itemPhotosWidgetList.length +
                                                                                1,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return index == 0
                                                                              ? Container(
                                                                                  height: 140,
                                                                                  width: 140,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                    color: finalgrey,
                                                                                  ),
                                                                                  child: FlatButton(
                                                                                    onPressed: () async {
                                                                                      photo = await _picker.pickMultiImage();
                                                                                      if (photo != null) {
                                                                                        setstate(() {
                                                                                          itemImagesList = itemImagesList + photo!;
                                                                                          addImage();
                                                                                          photo!.clear();
                                                                                        });
                                                                                      }
                                                                                    },
                                                                                    child: Center(child: Icon(Icons.add)),
                                                                                  ),
                                                                                )
                                                                              : MouseRegion(
                                                                                  cursor: SystemMouseCursors.click,
                                                                                  onEnter: (value) {
                                                                                    setstate(() {
                                                                                      mouse[index - 1] = true;
                                                                                    });
                                                                                  },
                                                                                  onExit: (value) {
                                                                                    setstate(() {
                                                                                      mouse[index - 1] = false;
                                                                                    });
                                                                                  },
                                                                                  child: Stack(children: [
                                                                                    itemPhotosWidgetList[index - 1],
                                                                                    mouse[index - 1]
                                                                                        ? GestureDetector(
                                                                                            child: Container(
                                                                                              height: 150,
                                                                                              width: 150,
                                                                                              decoration: BoxDecoration(
                                                                                                color: glass,
                                                                                                borderRadius: BorderRadius.circular(7),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Container(
                                                                                                    padding: EdgeInsets.all(5),
                                                                                                    decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.white), borderRadius: BorderRadius.circular(50)),
                                                                                                    child: Icon(
                                                                                                      Icons.delete_forever,
                                                                                                      color: Colors.white,
                                                                                                    )),
                                                                                              ),
                                                                                            ),
                                                                                            onTap: () {
                                                                                              setstate(() {
                                                                                                itemPhotosWidgetList.removeAt(index - 1);
                                                                                              });
                                                                                            },
                                                                                          )
                                                                                        : Container()
                                                                                  ]));
                                                                        })),
                                                          ],
                                                        ),
                                                      ),
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
                                                    if (workhistoryformKey
                                                        .currentState!
                                                        .validate()) {
                                                      workhistoryformKey
                                                          .currentState!
                                                          .save();

                                                      if (itemPhotosWidgetList
                                                          .isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                new SnackBar(
                                                                    content: Text(
                                                                        "Screen Shots are Required")));
                                                      } else if (techstack
                                                          .isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                new SnackBar(
                                                                    content: Text(
                                                                        "Tech Stack is Required")));
                                                      } else {
                                                        setstate(() {
                                                          languageload = true;
                                                        });
                                                        uploading
                                                            ? null
                                                            : upload();
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

  createworkdonepopup(BuildContext context, int index) {
    int activeindex = 0;
    CarouselController carouselController = new CarouselController();

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
                                            works[index]["title"],
                                            style: getsimplestyle(
                                                20, FontWeight.w500, b4),
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
                                                  key: workhistoryformKey,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        height: Responsive
                                                                .isdesktop(
                                                                    context)
                                                            ? 500
                                                            : 200,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: CarouselSlider
                                                            .builder(
                                                          carouselController:
                                                              carouselController,
                                                          itemCount: works[
                                                                      index][
                                                                  "screenshots"]
                                                              .length,
                                                          itemBuilder: (context,
                                                              i, realIndex) {
                                                            return BuildImage(
                                                              image: works[
                                                                          index]
                                                                      [
                                                                      "screenshots"][i]
                                                                  .toString(),
                                                              index: i,
                                                              length: works[
                                                                          index]
                                                                      [
                                                                      "screenshots"]
                                                                  .length,
                                                            );
                                                          },
                                                          options:
                                                              CarouselOptions(
                                                            viewportFraction: 1,
                                                            autoPlay: false,
                                                            enableInfiniteScroll:
                                                                false,
                                                            onPageChanged:
                                                                (ind, reason) {
                                                              setstate(() {
                                                                activeindex =
                                                                    ind;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Project Description",
                                                        style: getsimplestyle(
                                                            18,
                                                            FontWeight.w500,
                                                            b4),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        works[index]
                                                            ["description"],
                                                        style: getsimplestyle(
                                                            13,
                                                            FontWeight.normal,
                                                            textcolor),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Tech stack",
                                                        style: getsimplestyle(
                                                            18,
                                                            FontWeight.w500,
                                                            b4),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Wrap(
                                                        runSpacing: 4,
                                                        spacing: 4,
                                                        children: works[index]
                                                                ["techstack"]
                                                            .map<Widget>(
                                                                (inputChip) =>
                                                                    InputChip(
                                                                      label:
                                                                          Text(
                                                                        inputChip
                                                                            .toString(),
                                                                        style: getsimplestyle(
                                                                            13,
                                                                            FontWeight.w200,
                                                                            Colors.white),
                                                                      ),
                                                                      backgroundColor:
                                                                          b5,
                                                                      labelStyle: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black),
                                                                    ))
                                                            .toList(),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Link To Project",
                                                        style: getsimplestyle(
                                                            18,
                                                            FontWeight.w500,
                                                            b4),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        works[index]["link"],
                                                        style: getsimplestyle(
                                                            13,
                                                            FontWeight.normal,
                                                            textcolor),
                                                      ),
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
        toolbarHeight: Responsive.isdesktop(context) ? 75 : 60,
        elevation: 3,
        title: Appbar(),
      ),
      drawer: Responsive.istablet(context) ? Drawerbox() : null,
      body: ListView(
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  var doc = snapshot.data!;
                  languages.clear();
                  Educations.clear();
                  skills.clear();
                  works.clear();
                  languages.addAll(doc["language"]);
                  Educations.addAll(doc["education"]);
                  skills.addAll(doc["skills"]);
                  works.addAll(doc["works"]);
                  availablity = doc["availability"];

                  workshover.clear();
                  for (int i = 0; i < works.length; i++) {
                    workshover.add(false);
                  }

                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: Responsive.ismobile(context) ? 15 : 30,
                              horizontal:
                                  Responsive.ismobile(context) ? 0 : 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 0.7, color: finalgrey),
                              borderRadius: BorderRadius.circular(
                                  Responsive.ismobile(context) ? 0 : 7)),
                          width: Responsive.isdesktop(context)
                              ? maxWidth
                              : double.infinity,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 30),
                                child: Responsive.isdesktop(context)
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 5,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                          child: Container(
                                                            height: 80,
                                                            width: 80,
                                                            child: Icon(
                                                              Icons
                                                                  .account_circle_outlined,
                                                              size: 80,
                                                              color: b3,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            doc["name"]
                                                                .toString(),
                                                            style:
                                                                getsimplestyle(
                                                                    23,
                                                                    FontWeight
                                                                        .w500,
                                                                    textcolor),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      width:
                                                                          0.7,
                                                                      color:
                                                                          finalgrey),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100)),
                                                              child: publicview
                                                                  ? Container()
                                                                  : IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        username =
                                                                            doc["name"].toString();
                                                                        dropdownvalueyear =
                                                                            doc["year"].toString();

                                                                        createbasicprofileeditor(
                                                                            username,
                                                                            dropdownvalueyear,
                                                                            availablity);
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .edit,
                                                                        size:
                                                                            20,
                                                                        color:
                                                                            textcolor,
                                                                      ),
                                                                    )),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.school,
                                                            color: textcolor,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            " " +
                                                                doc["year"]
                                                                    .toString() +
                                                                " year Electrical Eng.",
                                                            style:
                                                                getsimplestyle(
                                                                    13,
                                                                    FontWeight
                                                                        .normal,
                                                                    textcolor),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Chip(
                                                        label: Text(availablity!
                                                            ? "Available Now"
                                                            : "Not Available"),
                                                        labelStyle: TextStyle(
                                                            color: b1,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                        backgroundColor:
                                                            availablity!
                                                                ? b5
                                                                : light,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: Container()),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 45,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10,
                                                                  left: 0,
                                                                  right: 0,
                                                                  bottom: 0),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 0.7,
                                                                  color:
                                                                      finalgrey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color:
                                                                  Colors.white),
                                                          child: FlatButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                publicview =
                                                                    true;
                                                              });
                                                            },
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: Text(
                                                              "See Public View",
                                                              style: getsimplestyle(
                                                                  13,
                                                                  FontWeight
                                                                      .normal,
                                                                  publicview
                                                                      ? Colors
                                                                          .white
                                                                      : b4),
                                                            ),
                                                            color: publicview
                                                                ? b4
                                                                : Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 45,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10,
                                                                  left: 0,
                                                                  right: 0,
                                                                  bottom: 0),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 0.7,
                                                                  color:
                                                                      finalgrey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color: b4),
                                                          child: FlatButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                publicview =
                                                                    false;
                                                              });
                                                            },
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: Text(
                                                              "Profile Settings",
                                                              style: getsimplestyle(
                                                                  13,
                                                                  FontWeight
                                                                      .normal,
                                                                  publicview
                                                                      ? b4
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                            color: publicview
                                                                ? Colors.white
                                                                : b4,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        height: 80,
                                                        width: 80,
                                                        child: Icon(
                                                          Icons
                                                              .account_circle_outlined,
                                                          size: 80,
                                                          color: b3,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        doc["name"].toString(),
                                                        style: getsimplestyle(
                                                            23,
                                                            FontWeight.w500,
                                                            textcolor),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 0.7,
                                                                  color:
                                                                      finalgrey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                          child: publicview
                                                              ? Container()
                                                              : IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    username = doc[
                                                                            "name"]
                                                                        .toString();
                                                                    dropdownvalueyear =
                                                                        doc["year"]
                                                                            .toString();

                                                                    createbasicprofileeditor(
                                                                        username,
                                                                        dropdownvalueyear,
                                                                        availablity);
                                                                  },
                                                                  icon: Icon(
                                                                    Icons.edit,
                                                                    size: 20,
                                                                    color:
                                                                        textcolor,
                                                                  ),
                                                                )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.school,
                                                        color: textcolor,
                                                        size: 15,
                                                      ),
                                                      Text(
                                                        " " +
                                                            doc["year"]
                                                                .toString() +
                                                            " year Electrical Eng.",
                                                        style: getsimplestyle(
                                                            13,
                                                            FontWeight.normal,
                                                            textcolor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Chip(
                                                    label: Text(availablity!
                                                        ? "Available Now"
                                                        : "Not Available"),
                                                    labelStyle: TextStyle(
                                                        color: b1,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                    backgroundColor:
                                                        availablity!
                                                            ? b5
                                                            : light,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 45,
                                                      margin: EdgeInsets.only(
                                                          top: 10,
                                                          left: 0,
                                                          right: 0,
                                                          bottom: 0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 0.7,
                                                              color: finalgrey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors.white),
                                                      child: FlatButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            publicview = true;
                                                          });
                                                        },
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Text(
                                                          "See Public View",
                                                          style: getsimplestyle(
                                                              13,
                                                              FontWeight.normal,
                                                              publicview
                                                                  ? Colors.white
                                                                  : b4),
                                                        ),
                                                        color: publicview
                                                            ? b4
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 45,
                                                      margin: EdgeInsets.only(
                                                          top: 10,
                                                          left: 0,
                                                          right: 0,
                                                          bottom: 0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 0.7,
                                                              color: finalgrey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: b4),
                                                      child: FlatButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            publicview = false;
                                                          });
                                                        },
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Text(
                                                          "Profile Settings",
                                                          style: getsimplestyle(
                                                            13,
                                                            FontWeight.normal,
                                                            publicview
                                                                ? b4
                                                                : Colors.white,
                                                          ),
                                                        ),
                                                        color: publicview
                                                            ? Colors.white
                                                            : b4,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  child: Container(
                                height: 0.7,
                                width: maxWidth,
                                color: finalgrey,
                              )),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Responsive.isdesktop(context)
                                        ? Expanded(
                                            flex: 3,
                                            child: Wrap(children: [
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        "   All Works",
                                                        style: getsimplestyle(
                                                            13,
                                                            FontWeight.w400,
                                                            textcolor),
                                                      ),
                                                      trailing: Icon(
                                                        Icons.navigate_next,
                                                        color: textcolor,
                                                      ),
                                                      onTap: () {},
                                                    ),
                                                    Container(
                                                      height: 0.7,
                                                      width: double.infinity,
                                                      color: finalgrey,
                                                    ),
                                                    doc["introvideo"]
                                                                .toString() ==
                                                            "null"
                                                        ? Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 25,
                                                                    top: 20),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .video_call,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  "Video introduction",
                                                                  style: getsimplestyle(
                                                                      15,
                                                                      FontWeight
                                                                          .w400,
                                                                      textcolor),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            width:
                                                                                0.7,
                                                                            color:
                                                                                finalgrey),
                                                                        borderRadius:
                                                                            BorderRadius.circular(100)),
                                                                    child: publicview
                                                                        ? Container()
                                                                        : IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              createIntrovideoDialogue(context);
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              Icons.add,
                                                                              size: 20,
                                                                              color: textcolor,
                                                                            ),
                                                                          ))
                                                              ],
                                                            ),
                                                          )
                                                        : Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 25,
                                                                    top: 20),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "Meet " +
                                                                          doc["name"],
                                                                      style: getsimplestyle(
                                                                          15,
                                                                          FontWeight
                                                                              .w400,
                                                                          textcolor),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(width: 0.7, color: finalgrey),
                                                                            borderRadius: BorderRadius.circular(100)),
                                                                        child: publicview
                                                                            ? Container()
                                                                            : IconButton(
                                                                                onPressed: () {
                                                                                  createDeletepopup(context);
                                                                                },
                                                                                icon: Icon(
                                                                                  Icons.delete_forever,
                                                                                  size: 20,
                                                                                  color: textcolor,
                                                                                ),
                                                                              ))
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                MouseRegion(
                                                                  cursor:
                                                                      SystemMouseCursors
                                                                          .click,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      createplaypopup(
                                                                          context,
                                                                          doc["introvideo"]
                                                                              .toString());
                                                                    },
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              150,
                                                                          width:
                                                                              double.infinity,
                                                                          margin:
                                                                              EdgeInsets.only(right: 20),
                                                                          child:
                                                                              ClipRRect(
                                                                            child:
                                                                                Image.network(getYoutubeThumbnail(doc["introvideo"].toString()), fit: BoxFit.cover),
                                                                            borderRadius:
                                                                                BorderRadius.circular(7),
                                                                          ),
                                                                        ),
                                                                        Center(
                                                                            child:
                                                                                Icon(
                                                                          Icons
                                                                              .play_circle_fill,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              40,
                                                                        ))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      height: 0.7,
                                                      width: double.infinity,
                                                      color: finalgrey,
                                                    ),
                                                    Container(
                                                      height:
                                                          doc["introvideo"] ==
                                                                  "null"
                                                              ? 668
                                                              : 508,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      child: ListView(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 25,
                                                                    top: 20),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Languages",
                                                                  style: getsimplestyle(
                                                                      15,
                                                                      FontWeight
                                                                          .w400,
                                                                      textcolor),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            width:
                                                                                0.7,
                                                                            color:
                                                                                finalgrey),
                                                                        borderRadius:
                                                                            BorderRadius.circular(100)),
                                                                    child: publicview
                                                                        ? Container()
                                                                        : IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              createaddlanguagepopup(context);
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              Icons.add,
                                                                              size: 20,
                                                                              color: textcolor,
                                                                            ),
                                                                          )),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            child: ListView
                                                                .builder(
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            20,
                                                                        top: 0),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              8,
                                                                          child:
                                                                              ListTile(
                                                                            subtitle:
                                                                                Text(
                                                                              languages[index]["proficiency"],
                                                                              style: getsimplestyle(12, FontWeight.normal, textcolor),
                                                                            ),
                                                                            title:
                                                                                Text(
                                                                              languages[index]["name"],
                                                                              style: getsimplestyle(14, FontWeight.w500, b3),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(width: 0.7, color: finalgrey), borderRadius: BorderRadius.circular(100)),
                                                                            child: publicview
                                                                                ? Container()
                                                                                : IconButton(
                                                                                    onPressed: () {
                                                                                      createDeletelanguagepopup(context, index);
                                                                                    },
                                                                                    icon: Icon(
                                                                                      Icons.delete_forever,
                                                                                      size: 20,
                                                                                      color: textcolor,
                                                                                    ),
                                                                                  ))
                                                                      ],
                                                                    ));
                                                              },
                                                              itemCount:
                                                                  languages
                                                                      .length,
                                                              shrinkWrap: true,
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 25,
                                                                    top: 20,
                                                                    bottom: 0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Education",
                                                                  style: getsimplestyle(
                                                                      15,
                                                                      FontWeight
                                                                          .w400,
                                                                      textcolor),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            width:
                                                                                0.7,
                                                                            color:
                                                                                finalgrey),
                                                                        borderRadius:
                                                                            BorderRadius.circular(100)),
                                                                    child: publicview
                                                                        ? Container()
                                                                        : IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              createaddeducationpopup(context);
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              Icons.add,
                                                                              size: 20,
                                                                              color: textcolor,
                                                                            ),
                                                                          )),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            child: ListView
                                                                .builder(
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            25,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            20),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              8,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                Educations[index]["degree"],
                                                                                style: getsimplestyle(14, FontWeight.w500, b3),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Text(
                                                                                Educations[index]["school"],
                                                                                style: getsimplestyle(12, FontWeight.normal, textcolor),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Text(
                                                                                Educations[index]["from"] + " - " + Educations[index]["to"],
                                                                                style: getsimplestyle(12, FontWeight.normal, textcolor),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(width: 0.7, color: finalgrey), borderRadius: BorderRadius.circular(100)),
                                                                            child: publicview
                                                                                ? Container()
                                                                                : IconButton(
                                                                                    onPressed: () {
                                                                                      createDeleteeducationpopup(context, index);
                                                                                    },
                                                                                    icon: Icon(
                                                                                      Icons.delete_forever,
                                                                                      size: 20,
                                                                                      color: textcolor,
                                                                                    ),
                                                                                  ))
                                                                      ],
                                                                    ));
                                                              },
                                                              itemCount:
                                                                  Educations
                                                                      .length,
                                                              shrinkWrap: true,
                                                            ),
                                                          ),
                                                        ],
                                                        shrinkWrap: true,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]))
                                        : Container(),
                                    Responsive.istablet(context)
                                        ? Container()
                                        : Column(
                                            children: [
                                              Container(
                                                height: 800,
                                                width: 0.7,
                                                color: finalgrey,
                                              ),
                                            ],
                                          ),
                                    Expanded(
                                      flex:
                                          Responsive.istablet(context) ? 1 : 6,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 30,
                                                  right: 30,
                                                  top: 30,
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        doc["title"].toString(),
                                                        style: getsimplestyle(
                                                            22,
                                                            FontWeight.w500,
                                                            textcolor),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 0.7,
                                                              color: finalgrey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100)),
                                                      child: publicview
                                                          ? Container()
                                                          : IconButton(
                                                              onPressed: () {
                                                                title = doc[
                                                                    "title"];
                                                                coverletter =
                                                                    doc["cover"];
                                                                createEditcoverpopup(
                                                                    context,
                                                                    title,
                                                                    coverletter);
                                                              },
                                                              icon: Icon(
                                                                Icons.edit,
                                                                size: 20,
                                                                color:
                                                                    textcolor,
                                                              ),
                                                            )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 30,
                                                  right: 30,
                                                  bottom: 30),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      flex: 8,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              doc["cover"],
                                                              style: getsimplestyle(
                                                                  13,
                                                                  FontWeight
                                                                      .normal,
                                                                  textcolor),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 0.7,
                                              width: double.infinity,
                                              color: finalgrey,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 30,
                                                        right: 30,
                                                        left: 30),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Portfolio",
                                                          style: getsimplestyle(
                                                              16,
                                                              FontWeight.w500,
                                                              textcolor),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    width: 0.7,
                                                                    color:
                                                                        finalgrey),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            child: publicview
                                                                ? Container()
                                                                : IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      createworkhistorypopup(
                                                                          context);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons.add,
                                                                      size: 20,
                                                                      color:
                                                                          textcolor,
                                                                    ),
                                                                  )),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: works.isNotEmpty
                                                        ? 20
                                                        : 0,
                                                  ),
                                                  works.isNotEmpty
                                                      ? Container(
                                                          height: 180,
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child:
                                                              ListView.builder(
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Container(
                                                                padding: EdgeInsets.only(
                                                                    left: index ==
                                                                            0
                                                                        ? 30
                                                                        : 10,
                                                                    right: index ==
                                                                            works.length -
                                                                                1
                                                                        ? 20
                                                                        : 5),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        GestureDetector(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                130,
                                                                            width:
                                                                                250,
                                                                            decoration: BoxDecoration(
                                                                                border: Border.all(width: 0.7, color: finalgrey),
                                                                                borderRadius: BorderRadius.circular(5),
                                                                                image: DecorationImage(image: NetworkImage(works[index]["screenshots"][0]), fit: BoxFit.cover)),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            createworkdonepopup(context,
                                                                                index);
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      " " +
                                                                          works[index]
                                                                              [
                                                                              "title"],
                                                                      style: getsimplestyle(
                                                                          13,
                                                                          FontWeight
                                                                              .w600,
                                                                          b4),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                works.length,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                          ))
                                                      : Container(
                                                          child: Text(
                                                            "No Portfolio has been added yet.",
                                                            style:
                                                                getsimplestyle(
                                                                    13,
                                                                    FontWeight
                                                                        .normal,
                                                                    textcolor),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  30),
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
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 30,
                                                        right: 30,
                                                        left: 30),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Skills",
                                                          style: getsimplestyle(
                                                              16,
                                                              FontWeight.w500,
                                                              textcolor),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    width: 0.7,
                                                                    color:
                                                                        finalgrey),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            child: publicview
                                                                ? Container()
                                                                : IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      createSkilleditpopup(
                                                                          context);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      size: 20,
                                                                      color:
                                                                          textcolor,
                                                                    ),
                                                                  )),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                    child: skills.length == 0
                                                        ? Text(
                                                            "No skill has been added yet.",
                                                            style:
                                                                getsimplestyle(
                                                                    13,
                                                                    FontWeight
                                                                        .normal,
                                                                    textcolor),
                                                          )
                                                        : Wrap(
                                                            runSpacing: 4,
                                                            spacing: 4,
                                                            children: skills
                                                                .map((inputChip) =>
                                                                    InputChip(
                                                                      label:
                                                                          Text(
                                                                        inputChip,
                                                                        style: getsimplestyle(
                                                                            13,
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
                                                                          light,
                                                                    ))
                                                                .toList(),
                                                          ),
                                                    padding: EdgeInsets.only(
                                                        left: 25, right: 20),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Responsive.istablet(context)
                            ? Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    doc["introvideo"].toString() == "null"
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                left: 25, top: 0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.video_call,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Video introduction",
                                                  style: getsimplestyle(
                                                      15,
                                                      FontWeight.w400,
                                                      textcolor),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.7,
                                                            color: finalgrey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                    child: publicview
                                                        ? Container()
                                                        : IconButton(
                                                            onPressed: () {
                                                              createIntrovideoDialogue(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                              Icons.add,
                                                              size: 20,
                                                              color: textcolor,
                                                            ),
                                                          ))
                                              ],
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.only(
                                                left: 25, top: 20),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Meet " + doc["name"],
                                                      style: getsimplestyle(
                                                          15,
                                                          FontWeight.w400,
                                                          textcolor),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 0.7,
                                                                color:
                                                                    finalgrey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                        child: publicview
                                                            ? Container()
                                                            : IconButton(
                                                                onPressed: () {
                                                                  createDeletepopup(
                                                                      context);
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .delete_forever,
                                                                  size: 20,
                                                                  color:
                                                                      textcolor,
                                                                ),
                                                              ))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      createplaypopup(
                                                          context,
                                                          doc["introvideo"]
                                                              .toString());
                                                    },
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          height: 200,
                                                          width:
                                                              double.infinity,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 20),
                                                          child: ClipRRect(
                                                            child: Image.network(
                                                                getYoutubeThumbnail(
                                                                    doc["introvideo"]
                                                                        .toString()),
                                                                fit: BoxFit
                                                                    .cover),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                          ),
                                                        ),
                                                        Center(
                                                            child: Icon(
                                                          Icons
                                                              .play_circle_fill,
                                                          color: Colors.white,
                                                          size: 40,
                                                        ))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 0.7,
                                      width: double.infinity,
                                      color: finalgrey,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: ListView(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 25, top: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Languages",
                                                  style: getsimplestyle(
                                                      15,
                                                      FontWeight.w400,
                                                      textcolor),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.7,
                                                            color: finalgrey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                    child: publicview
                                                        ? Container()
                                                        : IconButton(
                                                            onPressed: () {
                                                              createaddlanguagepopup(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                              Icons.add,
                                                              size: 20,
                                                              color: textcolor,
                                                            ),
                                                          )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: ListView.builder(
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 20,
                                                        top: 0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 8,
                                                          child: ListTile(
                                                            subtitle: Text(
                                                              languages[index][
                                                                  "proficiency"],
                                                              style: getsimplestyle(
                                                                  12,
                                                                  FontWeight
                                                                      .normal,
                                                                  textcolor),
                                                            ),
                                                            title: Text(
                                                              languages[index]
                                                                  ["name"],
                                                              style:
                                                                  getsimplestyle(
                                                                      14,
                                                                      FontWeight
                                                                          .w500,
                                                                      b3),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    width: 0.7,
                                                                    color:
                                                                        finalgrey),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            child: publicview
                                                                ? Container()
                                                                : IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      createDeletelanguagepopup(
                                                                          context,
                                                                          index);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete_forever,
                                                                      size: 20,
                                                                      color:
                                                                          textcolor,
                                                                    ),
                                                                  ))
                                                      ],
                                                    ));
                                              },
                                              itemCount: languages.length,
                                              shrinkWrap: true,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 25, top: 20, bottom: 0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Education",
                                                  style: getsimplestyle(
                                                      15,
                                                      FontWeight.w400,
                                                      textcolor),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.7,
                                                            color: finalgrey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                    child: publicview
                                                        ? Container()
                                                        : IconButton(
                                                            onPressed: () {
                                                              createaddeducationpopup(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                              Icons.add,
                                                              size: 20,
                                                              color: textcolor,
                                                            ),
                                                          )),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: ListView.builder(
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 25,
                                                        right: 20,
                                                        bottom: 20),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 8,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                Educations[
                                                                        index]
                                                                    ["degree"],
                                                                style: getsimplestyle(
                                                                    14,
                                                                    FontWeight
                                                                        .w500,
                                                                    b3),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                Educations[
                                                                        index]
                                                                    ["school"],
                                                                style: getsimplestyle(
                                                                    12,
                                                                    FontWeight
                                                                        .normal,
                                                                    textcolor),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                Educations[index]
                                                                        [
                                                                        "from"] +
                                                                    " - " +
                                                                    Educations[
                                                                            index]
                                                                        ["to"],
                                                                style: getsimplestyle(
                                                                    12,
                                                                    FontWeight
                                                                        .normal,
                                                                    textcolor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    width: 0.7,
                                                                    color:
                                                                        finalgrey),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            child: publicview
                                                                ? Container()
                                                                : IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      createDeleteeducationpopup(
                                                                          context,
                                                                          index);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete_forever,
                                                                      size: 20,
                                                                      color:
                                                                          textcolor,
                                                                    ),
                                                                  ))
                                                      ],
                                                    ));
                                              },
                                              itemCount: Educations.length,
                                              shrinkWrap: true,
                                            ),
                                          ),
                                        ],
                                        shrinkWrap: true,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                         footer()
                      ],
                    ),
                  );
                }

                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: b4,
                    )));
              }),
        ],
      ),
    );
  }

  TextFormField videolinkfield() {
    return TextFormField(
      onSaved: (newValue) => videourl = newValue!,
      controller: _videourl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Link to Introduction Video';
        } else if (regExp.stringMatch(value) == null) {
          return 'Invalid Youtube Link';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
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
        hintText: "Ex: https://www.youtube.com/watch?v=FGfhnS6s",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }

  TextFormField languagefield() {
    return TextFormField(
      onSaved: (newValue) => language = newValue!,
      controller: _language,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Language';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
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
        hintText: "Language",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }

  TextFormField schoolfield() {
    return TextFormField(
      onSaved: (newValue) => school = newValue!,
      controller: _school,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter School name';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
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
        hintText: "Ex: Northwestern University",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }

  TextFormField fromdatefield() {
    return TextFormField(
      onSaved: (newValue) => fromdate = newValue!,
      controller: _fromdate,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter From Year';
        } else if (value.length > 4) {
          return "Invalid Year";
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
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
        hintText: "From",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }

  TextFormField todatefield() {
    return TextFormField(
      onSaved: (newValue) => todate = newValue!,
      controller: _todate,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter To year';
        }
        if (value.length > 4) {
          return "Invalid Year";
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
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
        hintText: "To",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }

  TextFormField degreefield() {
    return TextFormField(
      onSaved: (newValue) => degree = newValue!,
      controller: _degree,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Degree name';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
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
        hintText: "Ex: Btech",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left: 11),
      ),
    );
  }

  TextFormField usernamefield(String? name) {
    return TextFormField(
      maxLength: 20,
      onSaved: (newValue) => username = newValue!,
      controller: _username!..text = name!,
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
      controller: _title!..text = title!,
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

  TextFormField coverletterfield(String cover) {
    return TextFormField(
      onSaved: (newValue) => coverletter = newValue!,
      controller: _coverletter!..text = cover,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Cover Letter';
        }
        return null;
      },
      cursorColor: Colors.grey,
      maxLines: 6,
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
        hintText: "Cover Letter (100 words max)",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.all(11),
      ),
    );
  }

  TextFormField skillfield() {
    return TextFormField(
      onSaved: (newValue) => skill = newValue!,
      controller: _skill!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Skill name';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(14, FontWeight.normal, Colors.grey),
      decoration: InputDecoration(
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
        hintText: "New Skill",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.all(11),
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

  removeFocus() {
    FocusScope.of(context).unfocus();
  }

  String getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return "";
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }

  String getImageName(PickedFile image) {
    return image.path.split("/").last;
  }

  addImage() {
    for (var bytes in photo!) {
      itemPhotosWidgetList.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.network(File(bytes.path).path, fit: BoxFit.cover)),
          height: 150,
          width: 150,
        ),
      );
    }
    mouse.clear();
    for (int i = 0; i < itemPhotosWidgetList.length; i++) {
      mouse.add(false);
    }
  }

  upload() async {
    if (itemPhotosWidgetList.isNotEmpty) {
      String productId = await uplaodImageAndSaveItemInfo();
    }

    setState(() {
      uploading = false;
    });
    setState(() {
      languageload = false;
    });

    works.add({
      "title": projecttitle,
      "screenshots": downloadUrl,
      "description": projectdes,
      "techstack": techstack,
      "link": link
    });

    FirebaseFirestore.instance
        .collection("studentdata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"works": works}).then((value) => {
              _title!.clear(),
              itemPhotosWidgetList = [],
              techstack = [],
              _projectdes!.clear(),
              _tech!.clear(),
              _link!.clear(),
              Navigator.of(context).pop(),
              ScaffoldMessenger.of(context).showSnackBar(
                  new SnackBar(content: Text("Image Uploaded Successfully")))
            });
  }

  Future<String> uplaodImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    PickedFile? pickedFile;
    String? productId = FirebaseAuth.instance.currentUser!.uid;
    for (int i = 0; i < itemImagesList.length; i++) {
      file = File(itemImagesList[i].path);
      pickedFile = PickedFile(file!.path);

      await uploadImageToStorage(pickedFile, productId);
    }
    return productId;
  }

  uploadImageToStorage(PickedFile? pickedFile, String productId) async {
    String? pId = getImageName(pickedFile!);
    Reference reference =
        FirebaseStorage.instance.ref().child('workhistory/$productId/$pId');
    await reference.putData(
      await pickedFile.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );

    String value = await reference.getDownloadURL();
    downloadUrl.add(value);
  }
}
