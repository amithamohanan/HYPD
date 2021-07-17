import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/HomePage.dart';
import 'package:hypd/Widgets/Login.dart';
import 'package:hypd/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';


class Splash extends StatefulWidget 
{
	@override
	_SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> 
{
	var height;
	var width;
	var fontSize;

	bool isLoggedIn = false;

	@override
	void initState()
	{
		super.initState();
		getSharedPreference();
	}

	getSharedPreference() async
	{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		var response = jsonDecode(prefs.getString("isLoggedIn").toString());

		print(response);
		print("SHARED PREFERENCE");

		if(response == null)
		{
			isLoggedIn = false;
		}
		else
		{
			isLoggedIn = true;
		}

		setState(() {
		});
	}

	Widget build(BuildContext context)
	{
		height = getHeight(context);
		width = getWidth(context);
		fontSize = getFontSize(context);

		return Scaffold
		(
			body: splashScreen(),
			bottomSheet: Container
			(
				height: 20,
				alignment: Alignment.bottomCenter,
				margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
				child: Text
				(
					"Designed & Developed by Sapco IOT Pvt Ltd. | 2021",
					style: GoogleFonts.montserrat
					(
						color: Color(int.parse("0xff674094")),
						fontSize: fontSize / 30
					),
					textAlign: TextAlign.center,
				),
			)
		);
	}

	Widget splashScreen()
	{
		return Container
		(
			child: SplashScreen
			(
				imageBackground:  AssetImage("assets/images/splash_bg.jpg"),
				seconds: 3,
				image: Image.asset("assets/images/logo.png"),
				title: Text
				(
					"Search | Watch | Shop",
					style: GoogleFonts.montserrat
					(
						color: Color(int.parse("0xff674094"))
					),
				),
				photoSize: width * .3,
				navigateAfterSeconds: isLoggedIn ? HomePage() : Login(),
				useLoader: false,
			),
		);
	}
}