import 'package:flutter/material.dart';


import '../model/threemodel.dart';

class Nearbyprovider extends ChangeNotifier {
  List<Threemodel> nearby = [
    Threemodel(
        image: 'assets/images/care.png',
        date: DateTime.now(),
        title: "Polio Vaccine",
        venue: "bargachhi,biratnagar"),
    Threemodel(
        image: 'assets/images/contact.png',
        title: "Aalu Vaccine",
        date: DateTime.now(),
        venue: "Sundar morang"),
    Threemodel(
        image: 'assets/images/logo.png',
        name: "Aalu Vaccine",
        date: DateTime.now(),
        venue: "Sundar morang"),
  ];
}
