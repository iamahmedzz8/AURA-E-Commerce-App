import 'package:flutter/material.dart';

void NavigateTo({required context, required screen}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

void NavigateAndFinish({required context, required screen}) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen),(Route<dynamic> route) => false,);