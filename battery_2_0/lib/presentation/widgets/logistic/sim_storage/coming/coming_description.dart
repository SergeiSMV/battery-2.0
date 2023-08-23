import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../app_colors.dart';


comingDescription(){
  String funcDescription = 'высоту паллета указывать в миллиметрах';

  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: Container(
      decoration: BoxDecoration(color: mainColor, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 15, top: 8, bottom: 8),
        child: Center(child: Text(funcDescription, textAlign: TextAlign.left, style: white14)),
      )
    ),
  );
}