import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/BottomNavBar.dart';
import 'package:hypd/Widgets/BottomNavigationBar/ShoppingPage.dart';
import 'package:hypd/Widgets/BottomNavigationBar/WatchVideos.dart';
import 'package:hypd/Widgets/MyBag.dart';
import 'package:hypd/Widgets/MyWishlist.dart';
import 'package:hypd/Widgets/Notifications.dart';
import 'package:hypd/Widgets/Search..dart';
import 'package:hypd/global.dart';

class HomePage extends StatefulWidget 
{
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
	final PageController controller = PageController(initialPage: 1);

	var height;
	var width;
	var fontSize;

	bool isScrollLeft = false;
	bool isScrollRight = false;
	bool isFavourite = false;

	@override
	Widget build(BuildContext context)
	{
		height = getHeight(context);
		width = getWidth(context);
		fontSize = getFontSize(context);

		return Scaffold
		(
			// extendBodyBehindAppBar: true,
			backgroundColor: Colors.white,
			appBar: appBar(),
			body:  PageView
			(
      			scrollDirection: Axis.horizontal,
      			controller: controller,
      			children: 
				[
					ShoppingPage(),
					WatchVideo(),
					SearchPage(),
				],
				onPageChanged: pageChanged
			),
			bottomNavigationBar: BottomNavBar(pageInd: 0,),
		);
	}

	appBar()
	{
		return AppBar
		(
				elevation: 0,
				backgroundColor: Colors.white,
				centerTitle: false,
				titleSpacing: 0.0,
				leading: Text(""),
				title:  Transform
				(
					transform:  Matrix4.translationValues(-40.0, 0.0, 0.0),
					child: Text
					(
						"Baby Munchkins.",
						style: GoogleFonts.montserrat
						(
							fontSize: fontSize / 20,
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
				bottom: PreferredSize
				(
        			preferredSize: Size.fromHeight(height / 9),
					child: header(),
				),
		);
	}

	// header icons
	header()
	{
		return Container
		(
			margin: EdgeInsets.only(bottom: 10),
			height: height / 12,
			// color: Colors.pinkAccent,
			child: Row
			(
				children: 
				[
					Container
					(
						height: height * .15,
						width: width / 6,
						decoration: BoxDecoration
						(
							borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
							color: Color(int.parse("0xfff2f2f0")),
						),
						child: Center
						(
							child: isScrollLeft 
							? IconButton
							(
								icon: Icon(Icons.search),
								onPressed: () => null,
							) 
							: isScrollRight ?
							IconButton
							(
								icon: Icon
								(
									Icons.smart_display_outlined,
									size: 23,
								),
								onPressed: () => null,
							) 
							:IconButton
							(
								icon: Icon
								(
									FontAwesomeIcons.store,
									size: 15,
								),
								onPressed: () => null,
							) 
						),
					),
					SizedBox(width: width / 25,),
					Expanded
					(
						child: TextFormField
						(
							textAlign: TextAlign.center,
							decoration: InputDecoration
							(
								prefixIcon:Icon
								(
									isScrollLeft 
									? FontAwesomeIcons.store
									: isScrollRight 
									? Icons.search
									: Icons.smart_display_outlined,
									color: Colors.black,
									size: isScrollLeft ? 15 : 23,
								),
                				hintText: isScrollLeft ? "Shopping" : isScrollRight ? "Search Here..." : "Pebbles",
								hintStyle: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
								),
                				fillColor: Colors.white,
                				focusedBorder: OutlineInputBorder
								(
                  					borderRadius: BorderRadius.circular(20.0),
                  					borderSide: BorderSide(color: Colors.black12),
                				),
                				enabledBorder: OutlineInputBorder
								(
                  					borderRadius: BorderRadius.circular(20.0),
                  					borderSide: BorderSide
									(
                    					color: Color(int.parse("0xfff2f2f0")),
                    					width: 1.0,
                  					),
                				),
							)
						),
					),
					SizedBox(width: width / 25,),
					Container
					(
						width: width / 6,
						decoration: BoxDecoration
						(
							borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
							color: Color(int.parse("0xfff2f2f0")),
						),
						child: Center
						(
							child: isScrollLeft 
							? IconButton
							(
								icon: Icon(Icons.smart_display_outlined),
								onPressed: () => null,
							) 
							: isScrollRight ?
							IconButton
							(
								icon: Icon
								(
									FontAwesomeIcons.store,
									size: 15,
								),
								onPressed: () => null,
							) 
							:IconButton
							(
								icon: Icon
								(
									Icons.search,
									size: 23,
								),
								onPressed: () => null,
							)
						),
					),
				],
			),
		);
	}

	pageChanged(int page)
	{
		if(page == 0)
		{
			isScrollLeft = true;
			isScrollRight = false;
		}
		else if(page == 2)
		{
			print(page);
			isScrollRight = true;
			isScrollLeft = false;
		}
		else
		{
			isScrollLeft = false;
			isScrollRight = false;
		}

		setState(() {});
	}
}
