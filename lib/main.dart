// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypd/Widgets/Login.dart';

void main()
{
	runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget
{
	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			debugShowCheckedModeBanner: false,
			theme: ThemeData
			(
				cardColor: Colors.white,
				primaryColor: Colors.white,
				fontFamily: "montserrat"
			),
			home: Login(),
		);
	}
}