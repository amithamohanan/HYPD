import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget 
{
	@override
	_SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> 
{
	var height;
	var width;
	var random;

	bool isFavourite = false;

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;
		random = new Random();

		return Scaffold
		(
			backgroundColor: Colors.white,
			body: Container
			(
				height: height,
				child: products(),
			),
		);
	}

	products()
	{
		return ListView.builder
		(
			padding: EdgeInsets.only(top:25, left: 5, right: 5, bottom: 10),
			itemCount: 1,
			itemBuilder: (BuildContext context, int index)
			{
				return GestureDetector
				(
					child: Card
					(
						margin: EdgeInsets.only(bottom: 20, left: 5, right: 5),
						elevation: 0,
						color: Colors.white,
						child:Container
						(
							padding: EdgeInsets.only(left: 0),
							child:  Row
							(
								crossAxisAlignment: CrossAxisAlignment.start,
								children:
								[
									Container
									(
										width: width / 4,
										height: height / 6.5,
										child: ClipRRect
										(
											borderRadius: BorderRadius.circular(15.0),
											child: Image.network
											(
												"https://images.pexels.com/photos/291738/pexels-photo-291738.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
											)
										)
									),
									SizedBox(width: 2),
									details(index)
								],
							)
						),
					),
					onTap: ()
					{
					},
				);
			}
		);
	}

	Widget details(index)
	{
		return Column
		(
			crossAxisAlignment: CrossAxisAlignment.start,
			children:
			[
				Padding
				(
					padding: EdgeInsets.only(top: 15, left: 2),
					child: Text
					(
						"Viscose Twill Flare Belted Dress", 
						style: GoogleFonts.montserrat
						(
							// fontWeight: FontWeight.bold, 
							fontSize: 13
						),
					),
				),
				Padding
				(
					padding: EdgeInsets.only(top: 15, left: 2),
					child: RichText
					(
						textAlign: TextAlign.center,
						text: TextSpan
						(
							text: " ₹ 2499  ",
							style: GoogleFonts.montserrat
							(
								fontWeight: FontWeight.bold, 
								fontSize: 13,
								color: Colors.black,
							), /*defining default style is optional */
							children:
							[
								TextSpan
								(
									text: "  ₹ 5599",
									style: GoogleFonts.montserrat
									(
										color: Colors.black38,
										fontWeight: FontWeight.w400, 
										fontSize: 11,
										decoration: TextDecoration.lineThrough,
									)
								),
								TextSpan
								(
									text: "  (55% off)",
									style: GoogleFonts.montserrat
									(
										color: Color(int.parse("0xff42b369")),
										fontWeight: FontWeight.w400, 
										fontSize: 11,
									)
								),
							],
						),
					),
				),
			]
		);
	}
}
