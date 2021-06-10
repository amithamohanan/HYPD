import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/ProductPage.dart';

class TaggedProducts extends StatefulWidget
{
	@override
	_TaggedProductsState createState() => _TaggedProductsState();
}

class _TaggedProductsState extends State<TaggedProducts>
{
	var height;
	var width;

	bool isFavourite = false;

	List size = ["S", "M", "L", "XL", "XXL", "XXXL"];


	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return  SafeArea
		(
			top: false,
			child: Scaffold
			(
				backgroundColor: Color(int.parse("0xff674094")),
				body: Container
				(
					child: Column
					(
						children:
						[
							productDescription(),
							// priceDetails()
						],
					),
				),
				bottomSheet: priceDetails(),
			)
		);
	}

	Widget productDescription()
	{
		return Stack
		(
			children:
			[
				Container
				(
					height: height / 1.4,
					width: width,
					color: Color(int.parse("0xff674094")),
				),
				Container
				(
					height: height / 1.6,
					width: width,
					decoration: BoxDecoration
					(
						color: Colors.white,
						borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))
					),
					// child: taggedProducts(),
				),
				Container
				(
					height: height / 2.8,
					width: width,
					decoration: BoxDecoration
					(
						color: Colors.white,
						borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))
					),
					child: taggedProducts(),
				),
				Positioned
				(
					bottom: height / 20,
					right: 10,
					child: addToCart()
				),
				Positioned
				(
					bottom: height / 7,
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: 
						[
							selectSizeText(),
							chooseSize()
						],
					),
				)
			],
		);
	}


	addToCart()
	{
		return Container
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
						// Navigator.push(context, MaterialPageRoute(builder: (context) => MyBag()));
					},
					icon: Icon(Icons.shopping_bag_outlined),
					color: Colors.black,
				),
			)
		);
	}

	taggedProducts()
	{
		return  Container
		(
			margin: EdgeInsets.only(top: 50, bottom: 10),
			// height: 25,
			child: ListView.builder
			(
				scrollDirection: Axis.horizontal,
				itemBuilder: (BuildContext context, int index)
				{
					return GestureDetector
					(
						child: Container
						(
							margin: EdgeInsets.only(left: 15),
							// color: Colors.red,
							child: Stack
							(
								children: 
								[
									Positioned
									(
										child: Container
										(
											height: 200,
											width: width / 2.7,
											child: FittedBox
											(
												child:ClipRRect
												(
													borderRadius: BorderRadius.circular(50.0),
													child: Image.network("https://images.pexels.com/photos/2866119/pexels-photo-2866119.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
												),
												fit: BoxFit.contain,
											)
										)
									),
									Positioned
									(
										child: Align
										(
											alignment: Alignment.bottomCenter,
											child: Container
											(
												height: 80,
												width: width / 3,
												decoration: BoxDecoration
												(
													borderRadius: BorderRadius.circular(50)
												),
												child: Card
												(
													elevation: 10,
													shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
													child: ListTile
													(
														leading: Column
														(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: 
															[
																SizedBox(height: 5),
																Text
																(
																	"Travis Scott Tee",
																	style: GoogleFonts.montserrat
																	(
																		color: Colors.black,
																		fontWeight: FontWeight.w500,
																		fontSize: 10,
																	),
																),
																SizedBox(height: 20),
																Text
																(
																	" ₹ 12000",
																	style: GoogleFonts.montserrat
																	(
																		color: Colors.black,
																		fontWeight: FontWeight.bold,
																		fontSize: 10,
																	),
																),
															],
														)
													),
												),
											)
										)
									),
									Positioned
									(
										top: 5,
										right: 5,
										child:Container
										(
											margin: EdgeInsets.all(5),
											height: 45,
											width: 45,
											decoration: BoxDecoration
											(
												color: Color(int.parse("0xfff2f2f0")),
												borderRadius: BorderRadius.circular(10)
											),
											child: FittedBox
											(
												child: IconButton
												(
													onPressed: ()
													{
														setState(() 
														{
															// isFavourite = !isFavourite;
														});
													},
													icon: isFavourite 
													? Icon
													(
														Icons.favorite,
														color: Color(int.parse("0xffA12C2A"))
													)
													: Icon
													(
														Icons.favorite_border,
														color: Colors.black,
													),
												),
											)
										),
									)
								],
							)
						),
						onTap:()
						{
							Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));
						},
					);
				}
			),
		);
	}

	priceDetails()
	{
		return Container
		(
			color: Color(int.parse("0xff674094")),
			height: 100,
			child: Row
			(
				children: 
				[
					Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: 
						[
							InkWell
							(
								child: Padding
								(
									padding: EdgeInsets.only(left: 15),
									child: Text
									(
										"PRICE DETAILS",
										style: GoogleFonts.montserrat
										(
											color: Colors.white,
											fontWeight: FontWeight.w500,
											fontSize: 13,
											decoration: TextDecoration.underline
										),
									)
								),
								onTap:()
								{
									 popPriceDetails(context);
								}
							),
							SizedBox(height: 10,),
							Padding
							(
								padding: EdgeInsets.only(left: 15),
								child: Text
								(
									"₹ 8500",
									style: GoogleFonts.montserrat
									(
										color: Colors.white,
										fontWeight: FontWeight.w500,
										fontSize: 17,
									),
								)
							)
						],
					),
					Expanded
					(
						child: Container
						(
							margin: EdgeInsets.only(bottom:15, left: 15, right: 15 ),
							height: MediaQuery.of(context).size.height / 12,
							width: double.infinity,
							child: ElevatedButton
							(
								child: Text
								(
									"Express Checkout",
									style: TextStyle(fontSize: 16)
								),
								style: ButtonStyle
								(
									foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
									backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xffEF5C99"))),
									shape: MaterialStateProperty.all<RoundedRectangleBorder>
									(
										RoundedRectangleBorder
										(
											borderRadius: BorderRadius.circular(20.5),
											side: BorderSide(color: Colors.white38)
										)
									)
								),
								onPressed: ()
								{
									// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
								}
							)
						)
					)
				],
			)
		);
	}

	selectSizeText()
	{
		return Padding
		(
			padding: EdgeInsets.only(left: 15),
			child: Text
			(
				"Select size",
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w500,
					color: Colors.black38,
					fontSize: 14
				),
			),
		);
	}

	chooseSize()
	{
		return Container
		(
			height: height / 15,
			width: width,
			child: ListView.builder
			(
				scrollDirection: Axis.horizontal,
				itemCount: size.length,
				itemBuilder: (BuildContext context, int index)
				{
					return  Container
					(
						margin: EdgeInsets.only(left: 15),
						height: 30,
						width: 50,
						decoration: BoxDecoration
						(
							border: Border.all(color: Colors.black12),
							borderRadius: BorderRadius.circular(15)
						),
						child: Center
						(
							child: Text
							(
								size[index].toString(),
								style: GoogleFonts.montserrat
								(
									color: Colors.black,
									fontWeight: FontWeight.bold
								),
							),
						)
					);
				}
			),
		);
	}

	popPriceDetails(context)
	{
		return showModalBottomSheet
		(	
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
			context: context,
			builder: (BuildContext context) 
			{
				return Padding
				(
					padding: MediaQuery.of(context).viewInsets,
					child: Container
					(
						margin: EdgeInsets.only(left: 15, right: 15),
						decoration: BoxDecoration
						(
							borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
						),
						child: Column
						(
							mainAxisSize: MainAxisSize.min,
							crossAxisAlignment: CrossAxisAlignment.start,
							children: 
							[
								topButton(),
								SizedBox(height: 20,),
								title(),
								SizedBox(height: 20,),
								text("Total MRP", "₹ 10099"),
								SizedBox(height: 20,),
								text("Discount on MRP", "₹ 2199"),
								SizedBox(height: 20,),
								text("Coupon Discount", "₹ 2199"),
								SizedBox(height: 20,),
								text("Platform Handling Fee", "FREE"),
								SizedBox(height: 20,),
								pricePopUp()
							],
						),
					)
				);
			}
		);
	}


	topButton()
	{
		return Center
		(
			child: Container
			(
				decoration: BoxDecoration
				(
					color: Colors.black38,
					borderRadius: BorderRadius.circular(5)
				),
				margin: EdgeInsets.only(top: 15),
				height: 4,
				width: 50,
			)
		);
	}

	title()
	{
		return Center
		(
			child: Text
			(
				"Price Details",
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w500,
					color: Colors.black,
					fontSize: 18
				),
			),
		);
	}

	text(text1, text2)
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: 
			[
				Text
				(
					text1.toString(),
					style: GoogleFonts.montserrat
					(
						color: Colors.black38,
					),
				),
				Text
				(
					text2.toString(),
					style: GoogleFonts.montserrat
					(
						color: Colors.black,
						fontWeight: FontWeight.bold
					),
				)
			],
		);
	}

	pricePopUp()
	{
		return Container
		(
			child: Row
			(
				children: 
				[
					Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: 
						[
							InkWell
							(
								child: Padding
								(
									padding: EdgeInsets.only(left: 15),
									child: Text
									(
										"TOTAL PRICE",
										style: GoogleFonts.montserrat
										(
											color: Colors.black,
											fontWeight: FontWeight.bold,
											fontSize: 13,
										),
									)
								),
							),
							SizedBox(height: 10,),
							Padding
							(
								padding: EdgeInsets.only(left: 15),
								child: Text
								(
									"₹ 8500",
									style: GoogleFonts.montserrat
									(
										color: Colors.black,
										fontWeight: FontWeight.w500,
										fontSize: 17,
									),
								)
							)
						],
					),
					Expanded
					(
						child: Container
						(
							margin: EdgeInsets.only(bottom:15, left: 15, right: 15 ),
							height: MediaQuery.of(context).size.height / 12,
							width: double.infinity,
							child: ElevatedButton
							(
								child: Text
								(
									"Express Checkout",
									style: TextStyle(fontSize: 16)
								),
								style: ButtonStyle
								(
									foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
									backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xffEF5C99"))),
									shape: MaterialStateProperty.all<RoundedRectangleBorder>
									(
										RoundedRectangleBorder
										(
											borderRadius: BorderRadius.circular(20.5),
											side: BorderSide(color: Colors.white38)
										)
									)
								),
								onPressed: ()
								{
									// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
								}
							)
						)
					)
				],
			)
		);
	}
}