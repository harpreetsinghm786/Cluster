import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/authhandler.dart';

class Drawerbox extends StatefulWidget {
  const Drawerbox({Key? key}) : super(key: key);

  @override
  _DrawerboxState createState() => _DrawerboxState();
}

class _DrawerboxState extends State<Drawerbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: b2,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            children: [
              IconButton(onPressed:(){Navigator.pop(context);}, icon: Icon(Icons.close,color: Colors.white,)),
              Expanded(
                flex: 1,
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
                    ),
                    SizedBox(width: 20,)
                  ],),

              ),

            ],
          ),
          SizedBox(height: 20,),


          Container(
            child: Column(
              children: [
                SizedBox(height: 10,),

                ListTile(
                  title:Text(
                    "Find Work",style: getsimplestyle(14, FontWeight.normal, Colors.white),
                  ),
                  onTap: (){

                  },
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(
                      left: 10, right: 10),
                  height: 0.7,
                  width: double.infinity,
                  color: b4,
                ),

                SizedBox(height: 10,),
                ListTile(
                  title:Text(
                    "My Jobs",style: getsimplestyle(14, FontWeight.normal, Colors.white),
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(
                      left: 10, right: 10),
                  height: 0.7,
                  width: double.infinity,
                  color: b4,
                ),
                SizedBox(height: 10,),
                ListTile(
                  title:Text(
                    "Reports",style: getsimplestyle(14, FontWeight.normal, Colors.white),
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(
                      left: 10, right: 10),
                  height: 0.7,
                  width: double.infinity,
                  color: b4,
                ),
                SizedBox(height: 10,),
                ListTile(
                  title:Text(
                    "Messages",style: getsimplestyle(14, FontWeight.normal, Colors.white),
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(
                      left: 10, right: 10),
                  height: 0.7,
                  width: double.infinity,
                  color: b4,
                ),
                SizedBox(height: 10,),
                ListTile(
                  trailing: Icon(Icons.notifications_none,color: Colors.white,),
                  title:Text(
                    "Notifications",style: getsimplestyle(14, FontWeight.normal, Colors.white),
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(
                      left: 10, right: 10),
                  height: 0.7,
                  width: double.infinity,
                  color: b4,
                ),
                SizedBox(height: 10,),
                ListTile(
                  trailing: Icon(Icons.send_outlined,color: Colors.white,),
                  title:Text(
                    "Direct Links",style: getsimplestyle(14, FontWeight.normal, Colors.white),
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(
                      left: 10, right: 10),
                  height: 0.7,
                  width: double.infinity,
                  color: b4,
                ),
                SizedBox(height: 10,),
                ListTile(
                  trailing: Icon(Icons.account_circle_outlined,color: Colors.white,),
                  title:Text(
                    "Profile",style: getsimplestyle(14, FontWeight.normal, Colors.white),
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(
                      left: 10, right: 10),
                  height: 0.7,
                  width: double.infinity,
                  color: b4,
                ),
                SizedBox(height: 10,),
                ListTile(
                  leading: Icon(Icons.logout,color: Colors.white,),
                  title:Text(
                    "Logout",style: getsimplestyle(14, FontWeight.normal, Colors.white),
                  ),
                  onTap: (){
                    Logoutnow(context);
                  },
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(
                      left: 10, right: 10),
                  height: 0.7,
                  width: double.infinity,
                  color: b4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
