import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 75.0,
  fontWeight: FontWeight.w400,
);


const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kCityNameTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
);

const kWindInfoTextStyle = TextStyle(
  fontSize: 20.0,
);
const kTextFieldDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    filled: true,
    fillColor: Colors.white,
    icon: Icon(Icons.location_city,
      color: Colors.white,),
    hintText: 'Ex. Mumbai',
    hintStyle:TextStyle(
      color: Colors.grey,
    )
);