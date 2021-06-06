import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/MyBag.dart';

class MyWishlist extends StatefulWidget
{
	@override
	_MyWishlistState createState() => _MyWishlistState();
}

class _MyWishlistState extends State<MyWishlist>
{
	var height;
	var width;

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return Scaffold
		(
			body: Container
			(
				margin: EdgeInsets.only(top: 50, left: 10, right: 10),
				child: Column
				(
					children:
					[
						closeButton(),
						SizedBox(height: height / 20,),
						titleText()
					],
				),
			),
		);
	}

	Widget closeButton()
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children:
			[
				Container
				(
					margin: EdgeInsets.all(5),
					height: 45,
					width: 45,
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
				Row
				(
					mainAxisAlignment: MainAxisAlignment.end,
					children: 
					[
						Container
						(
							margin: EdgeInsets.all(5),
							height: 45,
							width: 45,
							decoration: BoxDecoration
							(
								color: Color(int.parse("0xfff2f2f0")),
								borderRadius: BorderRadius.circular(15)
							),
							child: FittedBox
							(
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
						)
					],
				)
			],
		);
	}

	titleText()
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.center,
			children :
			[
				Text
				(
					"My Wishlist",
					style: GoogleFonts.montserrat
					(
						fontWeight: FontWeight.w400,
						color: Colors.black,
						fontSize: 25
					),
				),
			]
		);
	}

}