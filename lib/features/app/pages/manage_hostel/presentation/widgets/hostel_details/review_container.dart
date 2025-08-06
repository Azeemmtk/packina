import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/const.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size= MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 17,
              child: Icon(Icons.person,),
            ),
            width5,
            Text(
              'Azeem Ali',
              style: TextStyle(color: headingTextColor,fontSize: 17,),
            ),
            width10,
            Icon(Icons.star,color: CupertinoColors.systemYellow,),
            width5,
            Icon(Icons.star,color: CupertinoColors.systemYellow,),
            width5,
            Icon(Icons.star,color: CupertinoColors.systemYellow,),
            width5,
            Icon(Icons.star,color: CupertinoColors.systemYellow,),
            width5,
          ],
        ),
        Row(
          children: [
            SizedBox(
                width: 35
            ),
            Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: textFieldColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
              ),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Text('Neat rooms, has washing machine, fridge, iron box',
                  style: TextStyle(fontSize: 16),),
              ),
            ),
          ],
        )
      ],
    );
  }
}

