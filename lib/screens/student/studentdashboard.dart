import 'package:cluster/Components/Appbar.dart';
import 'package:cluster/Components/Drawerbox.dart';
import 'package:cluster/constants.dart';
import 'package:cluster/helper/authhandler.dart';
import 'package:cluster/helper/responsive.dart';
import 'package:cluster/screens/student/studentlogin.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pagegrey,
      appBar: AppBar(
        backgroundColor: b2,
        toolbarHeight: Responsive.isdesktop(context)?75:60,
        elevation: 3,
        title: Appbar(),
      ),
      drawer:Responsive.istablet(context)?  Drawerbox():null,

      body: ListView(
        children: [

        ],
      ),
    );
  }


}
