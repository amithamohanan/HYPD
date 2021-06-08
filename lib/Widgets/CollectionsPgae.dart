import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/MyBag.dart';
import 'package:hypd/Widgets/MyWishlist.dart';

class Collections extends StatefulWidget 
{
	@override
	_CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> 
{
	var height;
	var width;

	bool isFavourite = false;

	@override
	Widget build(BuildContext context) 
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return Scaffold
		(
			backgroundColor: Colors.white,
			appBar: appBar(),
			body: collections(),
		);
	}

	appBar()
	{
		return PreferredSize
		(
        	preferredSize: Size.fromHeight(height / 8),
			child: AppBar
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
							fontSize: 20,
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
			)
		);
	}

	collections()
	{
		return Container
		(
			height: height,
			width: width,
			margin: EdgeInsets.only(left: 10, top: 50),
			child: ListView.builder
			(
				scrollDirection: Axis.vertical,
				itemCount: 15,
				itemBuilder: (BuildContext context, int index)
				{
					return Stack
					(
						children: 
						[
							Container
							(
								margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
								height: height / 5.5,
								width: width,
								
									child:ClipRRect
									(
										borderRadius: BorderRadius.circular(20.0),
										child: Image.network("https://images.pexels.com/photos/862848/pexels-photo-862848.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", fit: BoxFit.cover,),
									),
							),
							Positioned
							(
								left: width / 10,
								top: height / 15,
								child: Column
								(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: 
									[
										Text
										(
											"Supplements.",
											style: GoogleFonts.montserrat
											(
												fontSize: 20,
												fontWeight: FontWeight.bold,
												color: Colors.white
											),
										),
									],
								),
							)
						],
					);
				}
			)
		);
	}
}