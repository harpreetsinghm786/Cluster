import 'package:cluster/helper/responsive.dart';
import 'package:cluster/screens/student/studentprofile.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/student/multiimageuploader.dart';

class Appbar extends StatefulWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  String? search;
  TextEditingController? _search;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _search=new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Responsive.isdesktop(context)? Container(

      width: maxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal),
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

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                InkWell(

                  child: GestureDetector(
                    onTap: (){},
                    child: Text(
                      "Find Work",style: getsimplestyle(14, FontWeight.normal, Colors.white),
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
                    onTap: (){},
                    child: Text(
                      "My Jobs",style: getsimplestyle(14, FontWeight.w200, Colors.white),
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
                    onTap: (){},
                    child: Text(
                      "Reports",style: getsimplestyle(14, FontWeight.w200, Colors.white),
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
                    onTap: (){},
                    child: Text(
                      "Messages",style: getsimplestyle(14, FontWeight.w200, Colors.white),
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
                IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none,color: Colors.white,)),
                SizedBox(width: 10,),
                IconButton(onPressed: (){}, icon: Icon(Icons.send_outlined,color: Colors.white,)),
                SizedBox(width: 10,),
                IconButton(onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>Studentprofile()));
                }, icon: Icon(Icons.account_circle_outlined,color: Colors.white,)),

              ],
            ),
          ),





        ],
      ),
    ):Container(

      width: maxWidth,
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
          IconButton(onPressed: (){}, icon:Icon(Icons.search,color: Colors.white,))






        ],
      ),
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
