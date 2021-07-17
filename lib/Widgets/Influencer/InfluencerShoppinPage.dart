import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/API/Server.dart';
import 'package:hypd/Widgets/BottomNavigationBar/ImageView.dart';
import 'package:hypd/Widgets/CollectionsPgae.dart';
import 'package:hypd/Widgets/Influencer/InBottomNavBar.dart';
import 'package:hypd/Widgets/MyBag.dart';
import 'package:hypd/Widgets/MyWishlist.dart';
import 'package:hypd/Widgets/Notifications.dart';
import 'package:hypd/Widgets/ProductPage.dart';
import 'package:hypd/Widgets/ViewAll.dart';
import 'package:hypd/global.dart';
import 'package:responsive_grid/responsive_grid.dart';

class InfluencerShoppingPage extends StatefulWidget
{
	final isCustomer;
	InfluencerShoppingPage(this.isCustomer);

	@override
	_InfluencerShoppingPageState createState() => _InfluencerShoppingPageState(this.isCustomer);
}

class _InfluencerShoppingPageState extends State<InfluencerShoppingPage>
{
	final isCustomer;
	_InfluencerShoppingPageState(this.isCustomer);

	var height;
	var width;
	var fontSize;

	List <bool> isFavourites = [];

	bool isFavourite = true;

	@override
	void initState()
	{
		super.initState();
		getAllCategories();
		getNewArrivedProducts();
		getAllBrands();
	}

	@override
	Widget build(BuildContext context)
	{
		height = getHeight(context);
		width = getWidth(context);
		fontSize = getFontSize(context);

		return SafeArea
		(
			top: true,
			child: Scaffold
			(
				appBar: this.isCustomer ? null : appBar(),
				body:  SingleChildScrollView
				(
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children:
						[
							SizedBox(height: height / 50),
							categoriesList.length == 0 ? SizedBox.shrink() : categories(),
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
							newArrivedProductsList(),
							SizedBox(height: height / 50),
						]
					)
				),
				bottomNavigationBar: this.isCustomer ? null :  InBottomNavBar(pageInd: 1),
			)
		);
	}

	appBar()
	{
		return AppBar
		(
				elevation: 4,
				backgroundColor:  Colors.white,
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
								playVideo(null);
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
								playVideo(null);
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
								playVideo(null);
								Navigator.push(context, MaterialPageRoute(builder: (context) => MyBag()));
							},
							icon: Icon(Icons.shopping_bag_outlined),
							color: Colors.black,
						)
					)
				],
				bottom:  PreferredSize
				(
        			preferredSize: Size.fromHeight(height / 9),
					child: header(),
				)
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
							child:
							IconButton
							(
								icon: Icon
								(
									Icons.smart_display_outlined,
									size: 23,
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
									FontAwesomeIcons.store,
									color: Colors.black,
									size:  23,
								),
                				hintText: "Shopping",
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
							child: IconButton
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
				itemCount: categoriesList.length,
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
											backgroundImage: NetworkImage(categoriesList[index]["image"])
										),
										onTap: ()
										{
											Navigator.push(context, MaterialPageRoute(builder: (context) => Collections(categoriesList[index]["id"])));
										},
									),
									SizedBox(height: 6),
									Text
									(
										categoriesList[index]["name"].toString(),
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
		return  GestureDetector
		(
			child: Container
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
			),
			onTap: ()
			{
				// Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAll(1, 2)));
			},
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
							// Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAll()));
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
											title: Column
											(
												crossAxisAlignment: CrossAxisAlignment.start,
												mainAxisAlignment: MainAxisAlignment.spaceEvenly,
												children:
												[
													Wrap
													(
														children:
														[
															Text
															(
																"Travis Scott Tee ",
																style: GoogleFonts.montserrat
																(
																	color: Colors.black,
																	fontWeight: FontWeight.w500,
																	fontSize: 10,
																),
															),
														],
													),
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
				Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(1)));
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
							fontSize: fontSize * 0.04,
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
					fontSize: fontSize * 0.04,
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
			height: height / 5,
			width: width,
			margin: EdgeInsets.only(top: 15, left: 15),
			child:ListView.builder
			(
				scrollDirection: Axis.horizontal,
				itemCount: brandList.length == null ? 0 : brandList.length,
				itemBuilder: (BuildContext context, int index)
				{
					return GestureDetector
					(
						child: Padding
						(
							padding: EdgeInsets.only(left: 15),
							child: CircleAvatar
							(
								radius: 60,
								backgroundImage: NetworkImage(brandList[index]["image"])
							),
						),
						onTap: ()
						{
							Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAll(brandList[index]["id"], null)));
						},
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
					fontSize: fontSize * 0.04,
					color: Colors.black,
					fontWeight: FontWeight.bold
				),
			),
		);
	}

	newArrivedProductsList()
	{
		return  ResponsiveGridRow
		(
			children:  List.generate(newArrivedList.length, (index)
			{
				return  ResponsiveGridCol
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
													child: Image.network(newArrivedList[index]["productImage"][0]["image"].toString()),
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
																Flexible(child:
																Text
																(
																	newArrivedList[index]["name"].toString(),
																	style: GoogleFonts.montserrat
																	(
																		color: Colors.black,
																		fontWeight: FontWeight.w500,
																		fontSize: 10,
																	),
																),
																),
																SizedBox(height: 5),
																Text
																(
																	" ₹ " + newArrivedList[index]["price"].toString(),
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
															addProductToWishlist(newArrivedList[index]["id"], index);
														});
													},
													icon: isFavourites[index] == true 
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
						onTap: ()
						{
							Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(newArrivedList[index]["id"])));
						},
					),
				);
			})
		);
	}

	// -----------------------------------------------------------------------API-------------------------------------------------------------//

	// get all categories
	getAllCategories() async
	{
		categoriesList.clear();

		var response = await Server.getAllCategories();

		for(int i = 0; i < response.length; i++)
		{
			categoriesList.add(response[i]);
		}

		setState(()
		{
		});
	}

	// get all brands
	getAllBrands() async
	{
		brandList.clear();

		var response = await Server.getAllBrands();

		for(int i = 0; i < response.length; i++)
		{
			brandList.add(response[i]);
		}

		setState(()
		{
		});
	}

	getNewArrivedProducts() async
	{
		newArrivedList.clear();

		var response = await Server.getNewArrivedProducts();

		for(int i = 0; i < response.length; i++)
		{
			newArrivedList.add(response[i]);
			isFavourites.add(false);
		}

		setState(()
		{
			print(isFavourites);
		});
	}

	// add to wishlist
	addProductToWishlist(productId, index) async
	{
		var userId = user["id"];

		var response = await Server.addProductsToWishlist(userId, productId);

		if(response == "Wish list added Successfully")
		{
			setState(()
			{
				isFavourites[index] = true;
			});
		}
		else
		{
			setState(()
			{
				isFavourites[index] = false;
			});
		}
	}
}