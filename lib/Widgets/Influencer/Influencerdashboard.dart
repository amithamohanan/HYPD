import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
				child: Text("Welcome to home page"),
			),
			bottomNavigationBar: InBottomNavBar(pageInd: 0,),
		);
	}
}