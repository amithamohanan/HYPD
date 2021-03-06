
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/ImageView.dart';
import 'package:hypd/Widgets/MyBag.dart';
import 'package:hypd/Widgets/MyWishlist.dart';
import 'package:hypd/Widgets/Notifications.dart';
import 'package:hypd/Widgets/Utilities/SelectSizeModal.dart';
import 'package:hypd/global.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class ProductPage extends StatefulWidget 
{
	@override
	_ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> 
{
	final double _initFabHeight = 120.0;
	double _fabHeight = 0;
	double _panelHeightOpen = 0;
	double _panelHeightClosed = 95.0;
	var height;
	var width;
	var fontSize;

	int currentPos = 0;

	bool isFavourite = false;
	bool _showBottomSheet = false;


	 	List<String> listPaths = 
	[
    	"https://images.pexels.com/photos/6945696/pexels-photo-6945696.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    	"https://images.pexels.com/photos/3913589/pexels-photo-3913589.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    	"https://images.pexels.com/photos/7404985/pexels-photo-7404985.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  	];

	List size = ["S", "M", "L", "XL", "XXL", "XXXL"];


	@override
	void initState() 
	{
		super.initState();
		_fabHeight = _initFabHeight;
	}

	@override
	Widget build(BuildContext context) 
	{
		height = getHeight(context);
		width = getWidth(context);
		fontSize = getFontSize(context);

		_panelHeightOpen = MediaQuery.of(context).size.height * .80;

		return Scaffold
		(
			extendBodyBehindAppBar: true,
			appBar: appBar(),
			body: SlidingUpPanel
			(
				color: !_showBottomSheet ? Color(int.parse("0xff674094")) : Colors.white,
				maxHeight: height,
				minHeight: _panelHeightClosed,
				parallaxEnabled: true,
				parallaxOffset: .5,
				body: stack(),
				panelBuilder: (sc) => scroller(sc),
				borderRadius: BorderRadius.only(
				topLeft: Radius.circular(18.0),
				topRight: Radius.circular(18.0)),
				onPanelOpened: ()
				{
					setState(() 
					{
						_showBottomSheet = true;
					});
				},
				onPanelClosed: ()
				{
					setState(() 
					{
						_showBottomSheet = false;
					});
				},
				onPanelSlide: (double pos) => setState(() 
				{
					_fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;

					
				}),
			)
		);
	}

	appBar()
	{
		return AppBar
		(
			// excludeHeaderSemantics: false,
			elevation: 0,
			backgroundColor: Colors.transparent,
			leading: Container
			(
				margin: EdgeInsets.all(5),
				height: 45,
				width: 45,
				decoration: BoxDecoration
				(
					color: Colors.white,
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
			actions: 
			[
				Container
				(
					margin: EdgeInsets.all(5),
					height: 10,
					width: 45,
					decoration: BoxDecoration
					(
						color: Colors.white,
						borderRadius: BorderRadius.circular(20)
					),
					child: IconButton
					(
						onPressed: ()
						{
							Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
						},
						icon: Icon(Icons.ios_share),
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
						color: Colors.white,
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
						color: Colors.white,
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

	stack()
	{
		return Stack
		(
			children: 
			[
				Container
				(
					color: Colors.red,
					height: height,
					width: width,
					child:  CarouselSlider.builder
					(
              			itemCount: listPaths.length,
              			options:CarouselOptions
						(
							aspectRatio: 16 / 9,
							height: height,
							autoPlay: false,
							viewportFraction: 1.0,
							scrollDirection: Axis.vertical,
                  			onPageChanged: (index, reason)
							{
                    			setState(() 
								{
                      				currentPos = index;
                    			});
                  			}
              			),
              			itemBuilder: (BuildContext context,index, i)
						{
                			return MyImageView(listPaths[index]);
              			},
            		),
				),
				Positioned
				(
					top: height / 2.5,
					right: width / 17,
					child: Column
					(
						children: listPaths.map((url) 
						{
							int index = listPaths.indexOf(url);
							return Container
							(
								width: 10,
								height: 10,
								margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
								decoration: BoxDecoration
								(
									shape: BoxShape.circle,
									color: currentPos == index
									? Color.fromRGBO(0, 0, 0, 0.9)
									: Color.fromRGBO(0, 0, 0, 0.4),
								),
							);
						}).toList(),
					),
				)
			],
		);
	}

	title()
	{
		return Container
		(
			margin: EdgeInsets.only(left: 6, right: 15),
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: 
				[
					Container
					(
						width: width / 1.5,
						// color: Colors.white,
						child: Wrap
						(
							children: 
							[
								Text
								(
									"Pangolian Backpack",
									style: GoogleFonts.montserrat
									(
										// fontWeight: FontWeight.w600,
										color: _showBottomSheet ? Colors.black : Colors.white30,
										fontSize: 18
									),
								),
							],
						)
					),
					Column
					(
						crossAxisAlignment: CrossAxisAlignment.end,
						children: 
						[
							Text
							(
								"???3800",
								style: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.w600,
									color: _showBottomSheet ? Colors.black : Colors.white30,
									fontSize: 18
								),
							),
							Text
							(
								"(55% off)",
								style: GoogleFonts.montserrat
								(
									color: Color(int.parse("0xff42b369")),
									fontWeight: FontWeight.w400, 
									fontSize: 11,
								)
							)
						],
					)
				],
			)
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
					color: !_showBottomSheet ? Colors.white38 : Colors.grey,
					borderRadius: BorderRadius.circular(5)
				),
				margin: EdgeInsets.only(top: 15),
				height: 4,
				width: 50,
			),
		);
	}

	Widget scroller(ScrollController sc)
	{
		var height = getHeight(context);

		return MediaQuery.removePadding
		(
        	removeTop: true,
			context: context, 
			child: ListView
			(
				children: 
				[
					topButton(),
					SizedBox(height: height / 30),
					title(),
					Container
					(
						height: height / 2.3,
						child: SingleChildScrollView
						(
							// height: 500,
							child: Column
							(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: 
								[
									SizedBox(height: height / 30),
									howItWorsk(),
									SizedBox(height: height / 30),
									productTitle("Product Description"),
									SizedBox(height: height / 55),
									productDescription(),
									SizedBox(height: height / 30),
									productTitle("Specifications"),
									SizedBox(height: 10),
									specifications(),
									SizedBox(height: height / 30),
								]
							),
						),
					),
					sizePicker()
				],
			)
		);
	}


	howItWorsk()
	{
		return Container
		(
			margin: EdgeInsets.only(left: 15, right: 15),
			decoration: BoxDecoration
			(
				color: Color(int.parse("0xfff0f2f2")),
				borderRadius: BorderRadius.circular(10),
			),
			child: Row
			(
				children: 
				[
					Container
					(
						margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
						height: height / 20,
						width: width / 15,
						child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWJsNgL5xt6MOZ6Y8XsunvSA3kz5KtxJ6zPA&usqp=CAU"),
					),
					Container
					(
						margin: EdgeInsets.only(top: 20, left: 10, right: 10),
						child: Column
						(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: 
							[
								Text
								(
									"Pay in 3 via Simpl",
									style: GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 10
									),
								),
								SizedBox(height: 5),
								Text
								(
									"Pay in 3 interest free EMI of",
									style: GoogleFonts.montserrat
									(
										color: Colors.black26,
										fontSize: 10
									)
								),
								SizedBox(height: 5,),
								Text
								(
									"??? 1267",
									style: GoogleFonts.montserrat
									(
										color: Colors.black26,
										fontSize: 10
									)
								),
								SizedBox(height: 5,),
							],
						),
					),
					Container
					(
						margin: EdgeInsets.only(left: 15, right: 15),
						child: Text
						(
							"How it works?",
							style: GoogleFonts.montserrat
							(
								fontSize: 13,
								color: Color(int.parse("0xffF56C27")),
								decoration: TextDecoration.underline,
								decorationStyle: TextDecorationStyle.dashed,
							),
						),
					)
				],
			),
		);
	}

	productTitle(title)
	{
		return Padding
		(
			padding: EdgeInsets.only(left: 15),
			child: Text
			(
				title.toString(),
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.bold,
					color: Colors.black,
					fontSize: 12
				),
			),
		);
	}

	specifications()
	{
		return Padding
		(
			padding: EdgeInsets.only(left: 15),
			child: Column
			(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: 
				[
					Text
					(
						"* Country of origin - India",
						style: GoogleFonts.montserrat
						(
							color: Colors.black26,
							fontSize: 10
						),
					),
					SizedBox(height: 10),
					Text
					(
						"* Color - Black",
						style: GoogleFonts.montserrat
						(
							color: Colors.black26,
							fontSize: 10
						),
					),
					SizedBox(height: 10),
					Text
					(
						"* Fabric - Cotton",
						style: GoogleFonts.montserrat
						(
							color: Colors.black26,
							fontSize: 10
						),
					),
					SizedBox(height: 10),
					Text
					(
						"* Neck Type - Round",
						style: GoogleFonts.montserrat
						(
							color: Colors.black26,
							fontSize: 10
						),
					),
					SizedBox(height: 10),
					Text
					(
						"* Pattern - Printed",
						style: GoogleFonts.montserrat
						(
							color: Colors.black26,
							fontSize: 10
						),
					),
					SizedBox(height: 10),
					Text
					(
						"* Ocassion - Casual",
						style: GoogleFonts.montserrat
						(
							color: Colors.black26,
							fontSize: 10
						),
					),
					SizedBox(height: 10),
					Divider
					(
						thickness: 0.5,
						color: Colors.black26,
					),
					SizedBox(height: 10),
				],
			),
		);
	}

	productDescription()
	{
		return Padding
		(
			padding: EdgeInsets.only(left: 15, right: 15),
			child: Text
			(
				"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident..",
				style: GoogleFonts.montserrat
				(
					color: Colors.black38,
					fontSize: 12,
					fontWeight: FontWeight.w300,
					wordSpacing: 2
				)
			)
		);
	}

	Widget sizePicker()
	{
		var height = getHeight(context);
		var width = getWidth(context);

		return Container
		(
			width: width,
			decoration: BoxDecoration
			(
				color: Color(int.parse("0xff674094")),
				borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
			),
			child: 
			Column
			(
				children: 
				[
					Row
					(
						children: 
						[
							Expanded
							(
								child: GestureDetector
								(
									child: Container
									(
										padding: EdgeInsets.only(left: 15, right: 15, top: 5), 
										margin: EdgeInsets.only(left: 15, right: 15, top: 25),
										height: height / 12,
										decoration: BoxDecoration
										(
											border: Border.all(color: Colors.white12),
											borderRadius: BorderRadius.circular(15)
										),
										child: Column
										(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: 
											[
												Text
												(
													"Select Size",
													style: GoogleFonts.montserrat
													(
														color: Colors.white,
														fontWeight: FontWeight.w200,
														fontSize: 10
													),
												),
												Text
												(
													"Pick One",
													style: GoogleFonts.montserrat
													(
														color: Colors.white,
														fontWeight: FontWeight.w300
													),
												),
											],
										),
									),
									onTap: ()
									{
										showSizeModal(context, height, width, size);
									},
								)
							),
							SizedBox(width: 10),
							Expanded
							(
								child: Container
								(
									padding: EdgeInsets.only(left: 15, right: 15), 
									margin: EdgeInsets.only(left: 15, right: 15, top: 25),
									height: height / 12,
									decoration: BoxDecoration
									(
										border: Border.all(color: Colors.white12),
										borderRadius: BorderRadius.circular(15)
									),
									child: Row
									(
										children: 
										[
											Expanded
											(
												child: Container
												(
													decoration: BoxDecoration
													(
														border: Border.all(color: Colors.white12),
														borderRadius: BorderRadius.circular(15)
													),
													child: FittedBox
													(
														child: IconButton
														(
															onPressed: null, 
															icon: Icon(Icons.remove, color: Colors.white),
														),
													),
												)
											),
											Expanded
											(
												child:  Container
												(
													child: Center
													(
														child: Text
														(
															"1",
															style: GoogleFonts.montserrat
															(
																color: Colors.white,
																fontWeight: FontWeight.w300
															),
														),
													),
												)
											),
											Expanded
											(
												child: Container
												(
													decoration: BoxDecoration
													(
														border: Border.all(color: Colors.white12),
														borderRadius: BorderRadius.circular(15)
													),
													child: FittedBox
													(
														child: IconButton
														(
															onPressed: null, 
															icon: Icon(Icons.add_outlined, color: Colors.white),
														),
													),
												)
											),
										],
									),
								)
							),
						],
					),
					SizedBox(height: 20),
					Row
					(
						children: 
						[
							Container
							(
								margin: EdgeInsets.only(left: 15),
								height: height / 13,
								width: width / 6,
								decoration: BoxDecoration
								(
									border: Border.all(color: Colors.white12),
									borderRadius: BorderRadius.circular(20)
								),
								child: IconButton
								(
									onPressed: ()
									{
										setState(() 
										{
											isFavourite = !isFavourite;
										});
									},
									icon: Icon
									(
										Icons.favorite_border,
										color: Colors.white70,
									),
								),
							),
							SizedBox(width: 10),
							Expanded
							(
								child: Container
								(
									margin: EdgeInsets.only(right: 15),
									height: height / 13,
									width: double.infinity,
									child: ElevatedButton
									(
										child: Text
										(
											"Add to Bag",
											style: TextStyle(fontSize: 14)
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
										onPressed: () => null
									)
								)
							)
						],
					),
					SizedBox(height: 20),
				],
			)
		);
	}

	sizeTitle()
	{
		return Center
		(
			child: Text
			(
				"Details",
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w500,
					color: Colors.black,
					fontSize: 18
				),
			),
		);
	}

	selectSizeText()
	{
		return Text
		(
			"Select size",
			style: GoogleFonts.montserrat
			(
				fontWeight: FontWeight.w500,
				color: Colors.black38,
				fontSize: 18
			),
		);
	}
}