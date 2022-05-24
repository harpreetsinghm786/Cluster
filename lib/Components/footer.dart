import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/responsive.dart';

class footer extends StatefulWidget {
  const footer({Key? key}) : super(key: key);

  @override
  _footerState createState() => _footerState();
}

class _footerState extends State<footer> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(
          top: Responsive.ismobile(context) ? 15 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.7, color: finalgrey),
      ),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(40),
            width: maxWidth,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About us",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Feedback",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Comunity",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About us",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Feedback",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Comunity",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About us",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Feedback",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Comunity",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About us",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Feedback",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Comunity",
                      style: getsimplestyle(12,
                          FontWeight.normal, Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: maxWidth,
            height: 0.7,
            color: finalgrey,
          ),
          Container(
            padding: EdgeInsets.only(
                left: 30, top: 10, bottom: 10, right: 30),
            width: maxWidth,
            child: Row(
              children: [
                Text(
                  "Follow us",
                  style: getsimplestyle(
                      12, FontWeight.normal, textcolor),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: light,
                        border: Border.all(
                            width: 0.7, color: finalgrey),
                        borderRadius:
                        BorderRadius.circular(100)),
                    child: ImageIcon(
                      AssetImage(
                          "assets/icons/facebook.png"),
                      size: 18,
                      color: Colors.grey,
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: light,
                        border: Border.all(
                            width: 0.7, color: finalgrey),
                        borderRadius:
                        BorderRadius.circular(100)),
                    child: ImageIcon(
                      AssetImage("assets/icons/insta.png"),
                      size: 18,
                      color: Colors.grey,
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: light,
                        border: Border.all(
                            width: 0.7, color: finalgrey),
                        borderRadius:
                        BorderRadius.circular(100)),
                    child: ImageIcon(
                      AssetImage(
                          "assets/icons/linkedin.png"),
                      size: 18,
                      color: Colors.grey,
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: light,
                        border: Border.all(
                            width: 0.7, color: finalgrey),
                        borderRadius:
                        BorderRadius.circular(100)),
                    child: ImageIcon(
                      AssetImage(
                          "assets/icons/twitter.png"),
                      size: 18,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
          Container(
            height: 0.7,
            width: maxWidth,
            color: finalgrey,
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "© 2022 - 2023 EE IITR®",
                  style: getsimplestyle(
                      12, FontWeight.normal, textcolor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
