import 'package:flutter/material.dart';

import '../model/threemodel.dart';

class Publicprovider extends ChangeNotifier {
  List<Threemodel> publiccomplaint = [
    Threemodel(
        image: 'assets/images/care.png',
        date: DateTime.now(),
        name: "Prasanna Poudel"),
    Threemodel(
      image: 'assets/images/contact.png',
      name: "Suman Shrestha",
      date: DateTime.now(),
    ),
    Threemodel(
      image: 'assets/images/logo.png',
      name: "Mahesh neupane",
      date: DateTime.now(),
    ),
  ];
}
