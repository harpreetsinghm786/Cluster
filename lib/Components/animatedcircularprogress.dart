import 'package:cluster/helper/responsive.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AnimatedCircularProgressbarIndicator extends StatelessWidget {
  const AnimatedCircularProgressbarIndicator(
      {Key? key, required this.percentage, required this.label})
      : super(key: key);

  final double percentage;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: defaultduration,
            builder: (context, double value, child) => Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: value,
                  color: b5,
                  strokeWidth:MediaQuery.of(context).size.width<1436?10: 30,
                  backgroundColor: Colors.transparent,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                          (value * 100).toInt().toString() + "%",
                          style: getsimplestyle(MediaQuery.of(context).size.width<1436?20:50, FontWeight.w200, b1),
                        )),

                 SizedBox(
                      height:  MediaQuery.of(context).size.width<1436?5:20,
                    ),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getsimplestyle(MediaQuery.of(context).size.width<1436?13: 18, FontWeight.w300, b1),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),

      ],
    );
  }
}



class AnimatedLinearProgressbar extends StatelessWidget {
  const AnimatedLinearProgressbar({Key? key, required this.value, required this.title}) : super(key: key);
  final double value;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: defaultpadding),
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: value),
          duration: defaultduration,
          builder: (context,double value, child) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,style: Theme.of(context).textTheme.subtitle2,),
                  Text((value*100).toInt().toString()+"%")
                ],
              ),
              SizedBox(height: defaultpadding/2,),
              LinearProgressIndicator(
                color: b5,
                value: value,
                backgroundColor: Colors.transparent,
              ),
            ],

          )),
    );
  }
}