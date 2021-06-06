import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatefulWidget 
{
	@override
	_NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> 
{
	@override
	Widget build(BuildContext context) 
	{
		return Scaffold
		(
			appBar: appBar(),
			body: body(),
		);
	}

	appBar()
	{
		return AppBar
		(
			toolbarHeight: 75.5,
			elevation: 0,
			backgroundColor: Colors.white,
			leading: Container
			(
				margin: EdgeInsets.only(left: 15, top: 5, bottom: 25),
				padding: EdgeInsets.all(5),
				height: 30,
				width: 30,
				decoration: BoxDecoration
				(
					color: Color(int.parse("0xfff2f2f0")),
					borderRadius: BorderRadius.circular(15)
				),
				child: FittedBox
				(
					child:  IconButton
					(
						onPressed: ()
						{
							Navigator.pop(context);
						},
						icon: Icon(Icons.arrow_back_ios),
						color: Colors.black,
					),
				)
			),
			centerTitle: true,
			title: Text
			(
				"NOTIFICATIONS",
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w500,
					fontSize: 20,
					color: Colors.black
				),
			),
		);
	}

	body()
	{
		return Container();
	}
}