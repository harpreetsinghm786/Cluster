import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//mains
const b1=Color(0xff1e2b5d);
const b2=Color(0xff015288);
const b3=Color(0xff008abd);
const b4=Color(0xff00a8c2);
const b5=Color(0xffd1f6ff);
const b7=Color(0xff81d8ef);
const b6=Color(0xfffddf8f);

const kTextColor = Color(0xFF757575);
const textcolor = Color(0xFF444444);
const bodytextcolor=Color(0xff888880);
const finalgrey=Color(0xffc9c9c9);
const mapgrey=Color(0xffe3e3e3);

const pagegrey=Color(0xfff1f2f4);

const light=Color(0xffefefef);
const darkglass=Color(0xA6000000);
const glass=Color(0x8B000000);
const glase=Color(0x8BF5F5F5);
const kAnimationDuration = Duration(milliseconds: 200);

const defaultpadding= 20.0;
const defaultduration=Duration(seconds: 1);
const maxWidth=1000.0;

final headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  height: 1.5,
);


List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

String convertToAgo(DateTime input){
  Duration diff = DateTime.now().difference(input);

  if(diff.inDays >= 1){
    return '${diff.inDays} day(s) ago';
  } else if(diff.inHours >= 1){
    return '${diff.inHours} hour(s) ago';
  } else if(diff.inMinutes >= 1){
    return '${diff.inMinutes} minute(s) ago';
  } else if (diff.inSeconds >= 1){
    return '${diff.inSeconds} second(s) ago';
  } else {
    return 'just now';
  }
}



//text style
TextStyle getheadstyle(double size,FontWeight w,Color c1){
  return GoogleFonts.monoton(fontSize: size,fontWeight: w,color: c1);
}

TextStyle getsimplestyle(double size,FontWeight w,Color c1){
  return GoogleFonts.poppins(fontSize: size,fontWeight: w,color: c1, );
}

final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

RegExp regExp=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
