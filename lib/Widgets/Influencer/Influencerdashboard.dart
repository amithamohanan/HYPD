import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/Influencer/InBottomNavBar.dart';

class InfluenceDashBoard extends StatefulWidget
{
	@override
	_InfluenceDashBoardState createState() => _InfluenceDashBoardState();
}

class _InfluenceDashBoardState extends State<InfluenceDashBoard>
{
	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			body: Container
			(
				child: Center
				(
					child: Text
					(
						"Welcome to home page",
						style: GoogleFonts.montserrat
						(
							fontSize: 25
						),
					),
				)
			),
			bottomNavigationBar: InBottomNavBar(pageInd: 0,),
		);
	}
}