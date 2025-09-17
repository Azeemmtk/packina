import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
      height: kIsWeb ? height * 0.06 : height * 0.04,
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
