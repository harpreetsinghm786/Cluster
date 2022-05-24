import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/responsive.dart';

class BuildImage extends StatefulWidget {
  String? image; int? index; int? length;
   BuildImage({Key? key,this.image,this.index,this.length}) : super(key: key);

  @override
  _BuildImageState createState() => _BuildImageState(image: this.image,index: this.index,length: this.length);
}

class _BuildImageState extends State<BuildImage> {
  String? image; int? index; int? length;
  _BuildImageState({this.image,this.index,this.length});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height:Responsive.isdesktop(context)?500:200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image!), fit: BoxFit.cover)),
        ),



      ],
    );
  }
}
