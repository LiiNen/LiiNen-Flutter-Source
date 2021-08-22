import 'package:flutter/material.dart';
import 'package:my_flutter_source/functionCollection.dart';

Text loginTitle(String title) {
  return Text(title,
    style: textStyle(weight: 700, size: 20.0),
    textAlign: TextAlign.left,
  );
}

Text loginSubtitle(String subtitle) {
  return Text(subtitle,
    style: textStyle(weight: 700, size: 14.0),
    textAlign: TextAlign.left,
  );
}
