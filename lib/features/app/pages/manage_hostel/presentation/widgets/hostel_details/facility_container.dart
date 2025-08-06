import 'package:flutter/material.dart';

import '../../../../../../../../core/constants/colors.dart';
import '../../../../../../../../core/constants/const.dart';

class FacilityContainer extends StatelessWidget {
  const FacilityContainer({
    super.key,
    required this.facility,
  });

  final String facility;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06,
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Text(facility,style: TextStyle(
          fontSize: 17,
        ),),
      ),
    );
  }
}
