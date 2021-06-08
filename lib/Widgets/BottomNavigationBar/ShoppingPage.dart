import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/ImageView.dart';
import 'package:hypd/Widgets/CollectionsPgae.dart';
import 'package:hypd/Widgets/ProductPage.dart';
import 'package:hypd/Widgets/ViewAll.dart';

class ShoppingPage extends StatefulWidget 
{
	@override
  	_ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> 
{
	var height;
	var width;

	bool isFavourite = false;

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return SingleChildScrollView
		(
			child: Column
			(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: 
				[
					SizedBox(height: height / 50),
					categories(),
					SizedBox(height: 10),
					carouselSlider(),
					SizedBox(height: height / 50),
					title1(),
					SizedBox(height: height / 50),
					itemCards(),
					SizedBox(height: height / 50),
					itemCards(),
					SizedBox(height: height / 50),
					title2(),
					SizedBox(height: height / 50),
					collection2(),
					SizedBox(height: height / 50),
					featuredBrandsTitle(),
					SizedBox(height: 5),
					featuredBrandsCircleAvatar(),
					SizedBox(height: height / 50),
					newArrivals(),
					SizedBox(height: height / 50),
					itemCards(),
					SizedBox(height: height / 50),
					itemCards(),
					SizedBox(height: height / 50),
				],
			),
		);
	}

	// circular avater categories section in header part
	categories()
	{
		return Container
		(
			height: height / 7,
			width: width,
			margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
			child: ListView.builder
			(
				scrollDirection: Axis.horizontal,
				itemCount: 10,
				itemBuilder: (BuildContext context, int index)
				{
					return  Row
					(
						children: 
						[
							Column
							(
								children: 
								[
									GestureDetector
									(
										child: CircleAvatar
										(
											radius: 30,
											backgroundImage: NetworkImage("https://images.pexels.com/photos/2853909/pexels-photo-2853909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")
										),
										onTap: ()
										{
											Navigator.push(context, MaterialPageRoute(builder: (context) => Collections()));
										},
									),
									SizedBox(height: 6),
									Text
									(
										"Dress",
										style: GoogleFonts.montserrat
										(
											fontSize: 13,
											color: Colors.black,
											fontWeight: FontWeight.w300
										),
									)
								],
							),
							SizedBox(width: 15,)
						],
					);
				}
			)
		);
	}

	// carousel slider
	carouselSlider()
	{
		return Container
		(
			margin: EdgeInsets.symmetric(horizontal: 2),
        	height: height / 2.5,
          	width: width,
			child: Stack
			(
				children: 
				[
					CarouselSlider
					(
						options: CarouselOptions
						(
							aspectRatio: 4 /3,
							height: height / 2 ,
							autoPlay: true,
							enlargeCenterPage: true
						),
						items: 
						[
							ClipRRect
							(
								borderRadius: BorderRadius.circular(16.0),
								child: MyImageView('https://images.pexels.com/photos/6945696/pexels-photo-6945696.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
							),
							ClipRRect
							(
								borderRadius: BorderRadius.circular(16.0),
								child: MyImageView('https://images.pexels.com/photos/3913589/pexels-photo-3913589.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
							),
							ClipRRect
							(
								borderRadius: BorderRadius.circular(16.0),
								child: MyImageView('https://images.pexels.com/photos/7404985/pexels-photo-7404985.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
							)
						]
					),
					Positioned.fill
					(
						child: Align
						(
							alignment: Alignment.topCenter,
							child: Column
							(
								mainAxisAlignment: MainAxisAlignment.end,
								crossAxisAlignment: CrossAxisAlignment.center,
								children: 
								[
									Text
									(
										"Supplements",
										style: GoogleFonts.montserrat
										(
											fontSize: 20,
											fontWeight: FontWeight.bold,
											color: Colors.white
										),
									),
									Text
									(
										"upto 50% off",
										style: GoogleFonts.montserrat
										(
											fontSize: 20,
											fontWeight: FontWeight.bold,
											color: Color(int.parse("0xffd6a62b"))
										),
									),
									SizedBox(height: 10)
								],
							
							)
						),
					)
				],
			)
        );
	}

	// title for individual cards
	title1()
	{
		return Container
		(
			margin: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: 
				[
					Text
					(
						"THIS IS MY QUARA - TEE",
						style: GoogleFonts.montserrat
						(
							fontSize: 14,
							color: Colors.black,
							fontWeight: FontWeight.w600
						),
					),
					GestureDetector
					(
						child: Text
						(
							"View all",
							style: GoogleFonts.montserrat
							(
								fontSize: 16,
								color: Colors.orange,
								decoration: TextDecoration.underline,
								decorationStyle: TextDecorationStyle.dashed,
							),
						),
						onTap: ()
						{
							Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAll()));
						},
					)
				],
			),
		);
	}

	// individual item cards
	itemCards()
	{
		return Container
		(
			child: Row
			(
				children: 
				[
					card1(),
					SizedBox(width: 20),
					card1(),
				],
			),
		);
	}

	card1()
	{
		return GestureDetector
		(
			child: Container
			(
				margin: EdgeInsets.only(left: 15),
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
										child: Image.network("https://images.pexels.com/photos/2866119/pexels-photo-2866119.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
									),
									fit: BoxFit.contain,
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
												isFavourite = !isFavourite;
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

	// title for collections
	title2()
	{
		return Container
		(
			margin: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: 
				[
					Text
					(
						"A smile costs nothing 😃 ",
						style: GoogleFonts.montserrat
						(
							fontSize: 13,
							color: Colors.black,
							fontWeight: FontWeight.bold
						),
					),
					
				],
			),
		);
	}

	collection2()
	{
		return Container
		(
			height: height / 5,
			width: width,
			margin: EdgeInsets.only(left: 10),
			child: ListView.builder
			(
				scrollDirection: Axis.horizontal,
				itemCount: 5,
				itemBuilder: (BuildContext context, int index)
				{
					return Stack
					(
						children: 
						[
							Container
							(
								margin: EdgeInsets.only(left: 15, right: 15),
								height: height / 5.2,
								width: width / 1.3,
								child: FittedBox
								(
									child:ClipRRect
									(
										borderRadius: BorderRadius.circular(50.0),
										child: Image.network("https://images.pexels.com/photos/821398/pexels-photo-821398.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
									),
									fit: BoxFit.fill,
								)
							),
							Positioned
							(
								left: width / 10,
								bottom: height / 25,
								child: Column
								(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: 
									[
										Text
										(
											"Cost you less than coffee.",
											style: GoogleFonts.montserrat
											(
												fontSize: 15,
												fontWeight: FontWeight.bold,
												color: Colors.white
											),
										),
										Text
										(
											"Products under ₹499.",
											style: GoogleFonts.montserrat
											(
												fontSize: 12,
												fontWeight: FontWeight.w200,
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

	featuredBrandsTitle()
	{
		return Container
		(
			margin: EdgeInsets.only(top: 15, bottom: 2, left: 15, right: 15),
			child: Text
			(
				"Featured Brands",
				style: GoogleFonts.montserrat
				(
					fontSize: 13,
					color: Colors.black,
					fontWeight: FontWeight.bold
				),
			),
		);
	}

	featuredBrandsCircleAvatar()
	{
		return Container
		(
			color: Colors.white,
			height: height / 7,
			width: width,
			margin: EdgeInsets.only(top: 15, left: 15),
			child:ListView.builder
			(
				scrollDirection: Axis.horizontal,
				itemCount: 10,
				itemBuilder: (BuildContext context, int index)
				{
					return  
					CircleAvatar
					(
						radius: 60,
						backgroundImage: NetworkImage("https://images.pexels.com/photos/974911/pexels-photo-974911.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")
					);
				}
			)
		);
	}


	newArrivals()
	{
		return Container
		(
			margin: EdgeInsets.only(top: 5, bottom: 2, left: 15, right: 15),
			child: Text
			(
				"New Arrivals",
				style: GoogleFonts.montserrat
				(
					fontSize: 13,
					color: Colors.black,
					fontWeight: FontWeight.bold
				),
			),
		);
	}
}


