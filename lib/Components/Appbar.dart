import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster/helper/responsive.dart';
import 'package:cluster/screens/faculty/facultyprofile.dart';
import 'package:cluster/screens/student/studentdashboard.dart';
import 'package:cluster/screens/student/studentprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/student/multiimageuploader.dart';

class Appbar extends StatefulWidget {
  bool profile;
  int activeindex;
  Appbar({Key? key,required this.profile,required this.activeindex}) : super(key: key);

  @override
  _AppbarState createState() => _AppbarState(profile: profile,activeindex: activeindex );
}

class _AppbarState extends State<Appbar> {
  String? search;
  TextEditingController? _search;
  int activeindex;

  var stream;
  bool profile;
  List<String> tabs=["Find Work","Work Space","Proposals"];
  List hoverlist=[];

  _AppbarState({required this.profile,required this.activeindex});

  @override
  void initState() {
    super.initState();
    _search=new TextEditingController();
    stream=FirebaseFirestore.instance.collection("studentdata").doc(FirebaseAuth.instance.currentUser!.uid);
    for(int i=0;i<tabs.length;i++){
      hoverlist.add(false);
    }

  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(

      stream: stream.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if(!snapshot.hasData){
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: CircularProgressIndicator(
                    color: b4,
                  )));
        }

        if(snapshot.data!.exists) {

          return Responsive.isdesktop(context) ? Container(

            width: maxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Row(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            height: 40,
                            width: 40,
                            child: Image.asset("assets/images/cluster.png"),
                          ),
                          Text(
                            "luster",
                            style: TextStyle(
                                color: Colors.white, fontStyle: FontStyle.normal),
                            softWrap: true,
                            textAlign: TextAlign.start,
                          )
                        ],),
                    ),
                    Container(
                        height: 40,
                        width: 300,
                        margin: EdgeInsets.only(
                            left: 30, right: 30),

                        alignment: Alignment.centerLeft,

                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: searchfield(),
                            ),
                          ],
                        )),
                  ],
                ),

                Row(
                  children: [

                    Container(
                      height: 50,
                      child: ListView.builder(
                          itemCount: tabs.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                         return Container(
                           margin: EdgeInsets.symmetric(horizontal: 10),
                           child: Row(
                             children: [
                               MouseRegion(
                                 child: GestureDetector(
                                   onTap: () {
                                     setState(() {
                                       activeindex=index;
                                       for(int i=0;i<tabs.length;i++){
                                         hoverlist[i]=false;
                                       }
                                       
                                       Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=>studentdashboard(activeindex: index,)), (route) => false);
                                     });
                                   },
                                   child: Text(
                                     tabs[index], style: activeindex==index?getsimplestyle(
                                       13, FontWeight.w500, Colors.white):getsimplestyle(13, FontWeight.w300,hoverlist[index]?b3: light),
                                   ),
                                 ),
                                 cursor: SystemMouseCursors.click,
                                 onExit: (v){
                                   setState(() {
                                     if(activeindex!=index){
                                       hoverlist[index]=false;
                                     }

                                   });
                                 },
                                 onEnter: (v){
                                   setState(() {
                                     if(activeindex!=index){
                                       hoverlist[index]=true;
                                     }

                                   });

                                 },


                               )
                             ],
                           ),
                         );}),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(

                        children: [
                          IconButton(onPressed: () {},
                              icon: Icon(
                                Icons.notifications_none, color: Colors.white,)),
                          SizedBox(width: 10,),

                          IconButton(onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                    Studentprofile()
                            ));
                          },
                              icon: Icon(Icons.account_circle_outlined,
                                color: Colors.white,)),

                        ],
                      ),
                    ),
                  ],
                ),



              ],
            ),
          ) : Container(
            width: maxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  flex: 8,
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
                          style: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.normal),
                          softWrap: true,
                          textAlign: TextAlign.start,
                        )
                      ],),
                  ),
                ),
                IconButton(onPressed: () {},
                    icon: Icon(Icons.search, color: Colors.white,))


              ],
            ),
          );
        }

        if(!snapshot.data!.exists){
          return Responsive.isdesktop(context) ? Container(

            width: maxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            height: 40,
                            width: 40,
                            child: Image.asset("assets/images/cluster.png"),
                          ),
                          Text(
                            "luster",
                            style: TextStyle(
                                color: Colors.white, fontStyle: FontStyle.normal),
                            softWrap: true,
                            textAlign: TextAlign.start,
                          )
                        ],),
                    ),
                    Container(
                        height: 40,
                        width: 300,
                        margin: EdgeInsets.only(
                            left: 30, right: 30),

                        alignment: Alignment.centerLeft,

                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: searchfield(),
                            ),
                          ],
                        )),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [


                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          InkWell(

                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Find Work", style: getsimplestyle(
                                  14, FontWeight.normal, Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          InkWell(

                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Work Space", style: getsimplestyle(
                                  14, FontWeight.w200, Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          InkWell(

                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Proposals", style: getsimplestyle(
                                  14, FontWeight.w200, Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(

                        children: [
                          IconButton(onPressed: () {},
                              icon: Icon(
                                Icons.notifications_none, color: Colors.white,)),

                          SizedBox(width: 10,),
                          IconButton(onPressed: () {
                           profile?null: Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                    facultyprofile()
                            ));
                          },
                              icon: Icon(Icons.account_circle_outlined,
                                color: Colors.white,)),

                        ],
                      ),
                    ),
                  ],
                )



              ],
            ),
          ) : Container(
            width: maxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  flex: 8,
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
                          style: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.normal),
                          softWrap: true,
                          textAlign: TextAlign.start,
                        )
                      ],),
                  ),
                ),
                IconButton(onPressed: () {},
                    icon: Icon(Icons.search, color: Colors.white,))


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
      }
    );
  }

  TextFormField searchfield() {
    return TextFormField(
      onSaved: (newValue) => search = newValue!,
      controller: _search,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Email';
        } else if (!regExp.hasMatch(value.toString())) {
          return 'Please Enter Valid Email';
        }
        return null;
      },
      cursorColor: Colors.grey,
      style: getsimplestyle(13, FontWeight.normal, Colors.white),
      decoration: InputDecoration(

        prefixIcon: Icon(
          Icons.search,
          color: b4,
          size: 20,
        ),

        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 0.5),
          borderRadius: BorderRadius.circular(50),

        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 0.5),
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 0.5),
          borderRadius: BorderRadius.circular(50),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.5),
          borderRadius: BorderRadius.circular(50),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: b4, width: 0.5),
          borderRadius: BorderRadius.circular(50),
        ),
        // errorStyle: TextStyle(fontSize: 12, height: 0.1),
        hintStyle: getsimplestyle(13, FontWeight.normal, Colors.white),
        hintText: "Search",
        errorStyle: TextStyle(fontSize: 9, height: 0.5),
        contentPadding: EdgeInsets.only(left:11),

      ),
    );
  }
}
