import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster/screens/profileviewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Components/Appbar.dart';
import '../../Components/Drawerbox.dart';
import '../../Components/footer.dart';
import '../../constants.dart';
import '../../helper/responsive.dart';

class selectproposal extends StatefulWidget {
  String? projectkey;
  selectproposal({Key? key,this.projectkey}) : super(key: key);

  @override
  _selectproposalState createState() => _selectproposalState(projectkey: this.projectkey);
}

class _selectproposalState extends State<selectproposal> {
  var stream1;
  String? projectkey;
  _selectproposalState({this.projectkey});
  bool load=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream1=FirebaseFirestore.instance.collection("proposals").where("projectkey",isEqualTo: projectkey);
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
      body: StreamBuilder<QuerySnapshot>(
          stream: stream1.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if(snapshot.hasData) {
              List docs=snapshot.data!.docs;

              return ListView(
                shrinkWrap: true,
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
                              Text(docs.length==1?"1 Proposal":"${docs.length} Proposals", style: getsimplestyle(
                                  20, FontWeight.w500, textcolor),)
                            ],
                          ),
                        ),

                         Container(

                            width: maxWidth,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(width: 0.7, color: finalgrey)
                            ),
                            child: ListView.builder(
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

                                               padding: EdgeInsets.all(30),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Row(
                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                       Text("Team: ",style: getsimplestyle(14, FontWeight.w500, textcolor),),
                                                       Row(
                                                         children: [
                                                           Text("Posted: ",style: getsimplestyle(13, FontWeight.w300, Colors.grey),),
                                                           Text("${convertToAgo(DateTime.parse(docs[index]["postdate"]))}",style: getsimplestyle(13, FontWeight.w500, b3),),
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
                                                       Text("Starting Date: ",style: getsimplestyle(14, FontWeight.w500, textcolor),),
                                                       Text("${DateFormat('dd-MM-yyyy').format(new DateTime.fromMillisecondsSinceEpoch(docs[index]["startdate"].seconds*1000))}",style: getsimplestyle(13, FontWeight.w500, b3),),
                                                     ],
                                                   ),


                                                   SizedBox(height: 15,),

                                                   Row(
                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                       Text("Commitments",style: getsimplestyle(14, FontWeight.w500, textcolor),),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text("Net Duration: ",style: getsimplestyle(13, FontWeight.w300, Colors.grey),),
                                                           Text(docs[index]["duration"].toString()+" Days" ,style: getsimplestyle(13, FontWeight.w500, textcolor),)
                                                         ],
                                                       ),
                                                     ],
                                                   ),
                                                   SizedBox(height: 10,),

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
                                                                                 14, FontWeight.w500,
                                                                                 textcolor),),
                                                                           Container(
                                                                             alignment: Alignment.topRight,
                                                                             child: Row(
                                                                               mainAxisAlignment: MainAxisAlignment.end,
                                                                               children: [
                                                                                 Icon(Icons.timer,color: Colors.grey,),
                                                                                 SizedBox(width: 10,),
                                                                                 Text(docs[index]["commitments"][ind]["duration"]+" Days",style: getsimplestyle(13, FontWeight.w500, textcolor),)

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
                                                                         docs[index]["commitments"][ind]["description"],
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
                                                               index!=docs[index]["commitments"].length-1?Container(
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
                                                   Text(docs[index]["experiencedes"],style: getsimplestyle(13, FontWeight.w500, Colors.grey),),
                                                   SizedBox(height: 20,),
                                                   Row(
                                                     children: [
                                                       Icon(Icons.link,color: Colors.grey,),
                                                       SizedBox(width: 10,),
                                                       Text(docs[index]["experiencelink"],style: getsimplestyle(13, FontWeight.w500, Colors.grey),),
                                                     ],
                                                   ),

                                                   SizedBox(height: 20,),

                                                   Row(
                                                     mainAxisAlignment: MainAxisAlignment.end,
                                                     children: [
                                                       Container(
                                                         width:170,
                                                         child: FlatButton(
                                                           color: b3,
                                                           shape: RoundedRectangleBorder(
                                                               borderRadius: BorderRadius
                                                                   .circular(100)),

                                                           padding: EdgeInsets.all(20),
                                                           onPressed: () {
                                                             showDialog(
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
                                                                                           "Accept Proposal",
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
                                                                                         "Are you sure you want to Accept this Proposal?",
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
                                                                                             "No, Cancel",
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
                                                                                             setstate(() {
                                                                                               load=true;
                                                                                             });
                                                                                             for(int i=0;i<docs.length;i++){
                                                                                               if(i==index){
                                                                                                 FirebaseFirestore.instance.collection("proposals").doc(docs[i]["key"]).update({
                                                                                                   "status":"selected"
                                                                                                 });
                                                                                               }else{
                                                                                                 FirebaseFirestore.instance.collection("proposals").doc(docs[i]["key"]).update({
                                                                                                   "status":"rejected"
                                                                                                 });
                                                                                               }
                                                                                             }

                                                                                             FirebaseFirestore.instance.collection("projects").doc(projectkey).update({
                                                                                               "status":"closed"
                                                                                             }).then((value) => {
                                                                                             setstate(() {
                                                                                             load=false;
                                                                                             }),
                                                                                               Navigator.pop(context),
                                                                                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Proposal Has been Selected")))
                                                                                               
                                                                                             });

                                                                                           },
                                                                                           shape: RoundedRectangleBorder(
                                                                                             borderRadius: BorderRadius.circular(50),
                                                                                           ),
                                                                                           child: Text(
                                                                                             "Yes, Sure",
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
                                                           },
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment
                                                                 .center,
                                                             children: [
                                                               Text("Accept",
                                                                 style: getsimplestyle(
                                                                     12, FontWeight.normal,
                                                                     Colors.white),),

                                                             ],
                                                           ),
                                                         ),
                                                       ),

                                                     ],
                                                   )





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
            }))

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

  String profilepic(String name){
    List<String> names=name.split(" ");
    if(names.length==1){
      return names[0][0];
    }
    return names[0][0] +names[1][0];
  }
}
