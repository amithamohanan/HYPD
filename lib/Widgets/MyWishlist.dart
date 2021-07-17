import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/API/Server.dart';
import 'package:hypd/Widgets/MyBag.dart';
import 'package:hypd/Widgets/ProductPage.dart';
import 'package:hypd/global.dart';
import 'package:responsive_grid/responsive_grid.dart';

class MyWishlist extends StatefulWidget
{
	@override
	_MyWishlistState createState() => _MyWishlistState();
}

class _MyWishlistState extends State<MyWishlist>
{
	var height;
	var width;

	bool isFavourite = true;

	List wishlist = [];

	@override
	void initState()
	{
		super.initState();
		getWishlistProducts();
	}
	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return Scaffold
		(
			body: SingleChildScrollView
			(
				padding: EdgeInsets.only(top: 50, left: 10, right: 10),
				child: Column
				(
					children:
					[
						closeButton(),
						SizedBox(height: height / 20,),
						titleText(),
						wishlist.length == null ? null : wishList()
					]
				)
			)
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

	wishList()
	{
		return SingleChildScrollView
		(
			child: Container
			(
				child: ResponsiveGridRow
				(
					children:  List.generate(wishlist.length, (index)
					{
						return ResponsiveGridCol
						(
							lg: 3,
							xs: 6,
							md: 4,
							child: GestureDetector
							(
								child: Container
								(
									margin: EdgeInsets.only(left: 15, bottom: 15),
									color: Colors.white,
									height: 250,
									child: Stack
									(
										children:
										[
											Positioned
											(
												child: Container
												(
													height: 230,
													width: width / 2.5,
													child: FittedBox
													(
														child:ClipRRect
														(
															borderRadius: BorderRadius.circular(50.0),
															child: Image.network(wishlist[index]["productImage"][0]["image"].toString()),
														),
														fit: BoxFit.fill,
													)
												)
											),
											Positioned.fill
											(
												child: Align
												(
													alignment: Alignment.bottomLeft,
													child: Container
													(
														height: 80,
														width: width / 2.8,
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
																		Expanded(child: Text
																		(
																			wishlist[index]["productName"].toString(),
																			style: GoogleFonts.montserrat
																			(
																				color: Colors.black,
																				fontWeight: FontWeight.w500,
																				fontSize: 10,
																			),
																		),),
																		// SizedBox(height: 10),
																		Text
																		(
																			" ₹ " + wishlist[index]["productPrice"].toString(),
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
												right: width / 2.5 - width / 2.8,
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
														)
													)
												)
											)
										]
									)
								),
								onTap: ()
								{
									Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(wishlist[index]["id"])));
								},
							)
						);
					})
				)
			)
		);
	}

	getWishlistProducts() async
	{
		var userId = user["id"];

		var response = await Server.getWishlistProducts(userId);

		if(response.length != null)
		{
			for(int i = 0; i < response.length; i++)
			{
				wishlist.add(response[i]);
			}

			setState(() 
			{

			});
		}
	}
}