import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
      {Key? key, required this.mobile, required this.mobilelarge, required this.tablet, required this.desktop})
      : super(key: key);
  final Widget mobile;
  final Widget  mobilelarge;
  final Widget tablet;
  final Widget desktop;

  static bool ismobile (BuildContext context) =>
      MediaQuery.of(context).size.width<=500;

  static bool ismobilelarge (BuildContext context) =>
      MediaQuery.of(context).size.width<=700;

  static bool istablet (BuildContext context) =>
      MediaQuery.of(context).size.width<=1027;

  static bool isdesktop (BuildContext context) =>
      MediaQuery.of(context).size.width>=1027;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final _size=MediaQuery.of(context).size;
    if(_size.width>=1024){
      return desktop;
    }else if(_size.width>=700 && tablet!=null){
      return tablet;
    }else if(_size.width>=500 && mobilelarge!=null){
      return mobilelarge;
    }else{
      return mobile;
    }

  }

}


