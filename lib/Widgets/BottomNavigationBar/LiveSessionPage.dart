import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/BottomNavBar.dart';
import 'package:hypd/Widgets/MyBag.dart';
import 'package:hypd/Widgets/MyWishlist.dart';
import 'package:hypd/Widgets/Notifications.dart';

class LiveSession extends StatefulWidget 
{
	@override
	_LiveSessionState createState() => _LiveSessionState();
}

class _LiveSessionState extends State<LiveSession> 
{
	var height;
	var width;

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return SafeArea
		(
			top: false,
			child: Scaffold
			(
				backgroundColor: Colors.white,
				appBar: appBar(),
				body: body(),
				bottomNavigationBar: BottomNavBar(pageInd: 1,),
			)
		);
	}

	appBar()
	{
		return AppBar
		(
			automaticallyImplyLeading: false,
			elevation: 0,
			backgroundColor: Colors.white,
			centerTitle: false,
          	titleSpacing: 0.0,
          	title:  Transform
			(
            	transform:  Matrix4.translationValues(9.0, 0.0, 0.0),
              	child: Text
				(
					"Live Shopping",
					style: GoogleFonts.montserrat
					(
						fontSize: 18,
						color: Colors.black,
						fontWeight: FontWeight.bold
					),
                ),
            ),
			actions: 
			[
				Container
				(
					margin: EdgeInsets.all(5),
					height: 10,
					width: 45,
					decoration: BoxDecoration
					(
						color: Color(int.parse("0xfff2f2f0")),
						borderRadius: BorderRadius.circular(20)
					),
					child: IconButton
					(
						onPressed: ()
						{
							Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
						},
						icon: Icon(Icons.notifications_none_outlined),
						color: Colors.black,
					),
				),
				Container
				(
					margin: EdgeInsets.all(5),
					height: 10,
					width: 45,
					decoration: BoxDecoration
					(
						color: Color(int.parse("0xfff2f2f0")),
						borderRadius: BorderRadius.circular(20)
					),
					child: IconButton
					(
						onPressed: ()
						{
							Navigator.push(context, MaterialPageRoute(builder: (context) => MyWishlist()));
						},
						icon: Icon(Icons.favorite_border),
						color: Colors.black,
					),
				),
				Container
				(
					margin: EdgeInsets.all(5),
					height: 10,
					width: 45,
					decoration: BoxDecoration
					(
						color: Color(int.parse("0xfff2f2f0")),
						borderRadius: BorderRadius.circular(20)
					),
					child: IconButton
					(
						onPressed: ()
						{
							Navigator.push(context, MaterialPageRoute(builder: (context) => MyBag()));
						},
						icon: Icon(Icons.shopping_bag_outlined),
						color: Colors.black,
					)
				)
			],
		);
	}

	Widget body()
	{
		return Container
		(
			padding: EdgeInsets.only(top: height / 4),
			child: Column
			(
				children: 
				[
					Center
					(
						child:Text
						(
							"More live coming soon!",
							style: GoogleFonts.montserrat
							(
								color: Color(int.parse("0xffC6C6C6")),
								fontSize: 20,
								fontWeight: FontWeight.bold
							),
						)
					),
					Center
					(
						child:Text
						(
							"We are bringing more exciting live sessions soon!!",
							style: GoogleFonts.montserrat
							(
								color: Color(int.parse("0xffC6C6C6")),
								fontSize: 12,
								fontWeight: FontWeight.w400
							),
							textAlign: TextAlign.center,
						)
					),
					Center
					(
						child:Text
						(
							"Stay Tuned",
							style: GoogleFonts.montserrat
							(
								color: Color(int.parse("0xffC6C6C6")),
								fontSize: 12,
								fontWeight: FontWeight.w400
							),
							textAlign: TextAlign.center,
						)
					)
				],
			),
		);
	}
}