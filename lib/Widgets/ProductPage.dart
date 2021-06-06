import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/ImageView.dart';
import 'package:hypd/Widgets/MyBag.dart';
import 'package:hypd/Widgets/MyWishlist.dart';
import 'package:hypd/Widgets/Notifications.dart';
import 'package:hypd/Widgets/Utilities/SelectSizeModal.dart';

class ProductPage extends StatefulWidget
{
	@override
	_ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
{
	var height;
	var width;

	bool isFavourite = false;
	bool _showBottomSheet = false;

	int currentPos = 0;

 	List<String> listPaths = 
	[
    	"https://images.pexels.com/photos/6945696/pexels-photo-6945696.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    	"https://images.pexels.com/photos/3913589/pexels-photo-3913589.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    	"https://images.pexels.com/photos/7404985/pexels-photo-7404985.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  	];

	List size = ["S", "M", "L", "XL", "XXL", "XXXL"];

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;
		
		return Scaffold
		(
			backgroundColor: Colors.white,
			appBar: appBar(),
			body: Container
			(
				child: stack(),
			),
			bottomSheet: BottomSheet
			(
            	elevation: 0,
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              	backgroundColor: Colors.red,
              	onClosing: () 
				{
                // Do something
              	},
              	builder: (BuildContext ctx)
				{
					return productDetails();
				}
			)
		);
	}

	appBar()
	{
		return AppBar
		(
			elevation: 0,
			backgroundColor: Colors.black,
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
						color: Color(int.parse("0xfff2f2f0")),
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
								"₹3800",
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

	productDetails()
	{
		return GestureDetector
		(
			child: Container
			(
				decoration: BoxDecoration
				(
					color: _showBottomSheet ? Colors.white : Color(int.parse("0xff312247")),
					borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight:  Radius.circular(20))
				),
				width: double.infinity,
				height: _showBottomSheet ? height / 1.2 : height / 7,
				alignment: Alignment.center,
				child: Column
				(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: 
					[
						topButton(),
						SizedBox(height: height / 30),
						title(),
						_showBottomSheet ? Container
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
						): SizedBox.shrink(),
						_showBottomSheet ? sizePicker() : SizedBox.shrink(),

					],
				),
			),
			onVerticalDragStart: (DragStartDetails d)
			{
				setState(() 
				{
					_showBottomSheet = !_showBottomSheet;
				});
			},
			// onVerticalDragEnd: (DragEndDetails d)
			// {
			// 	setState(() 
			// 	{
			// 		// _showBottomSheet = !_showBottomSheet;
			// 	});
			// },
		);
	}

	howItWorsk()
	{
		return Container
		(
			height: height / 7,
			margin: EdgeInsets.only(left: 15, right: 15),
			decoration: BoxDecoration
			(
				color: Color(int.parse("0xfff0f2f2")),
				borderRadius: BorderRadius.circular(25),
			),
			child: Row
			(
				children: 
				[
					Container
					(
						margin: EdgeInsets.only(bottom: 12, left: 10, right: 10),
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
									"₹ 1267",
									style: GoogleFonts.montserrat
									(
										color: Colors.black26,
										fontSize: 10
									)
								),
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
		return  Expanded
		(
			child: Container
			(
				width: width,
				decoration: BoxDecoration
				(
					color: Color(int.parse("0xff312247")),
					borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
				),
				child: Column
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
										icon: isFavourite ? Icon
										(
											Icons.favorite,
											color: Color(int.parse("0xffA12C2A"))
										)
										: Icon
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
												backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xffF56C27"))),
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
						)
					],
				)
			)
		);
	}

	// showSizeModal()
	// {
	// 	return showModalBottomSheet
	// 	(	
	// 		// isScrollControlled: true,
	// 		shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
	// 		context: context,
	// 		builder: (context) 
	// 		{
	// 			return FractionallySizedBox
	// 			(
    //     			heightFactor: 0.7,
	// 				child: Container
	// 				(
	// 					margin: EdgeInsets.only(left: 10, right: 10),
	// 					decoration: BoxDecoration
	// 					(
	// 						borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
	// 					),
	// 					child: Column
	// 					(
	// 						crossAxisAlignment: CrossAxisAlignment.start,
	// 						children: 
	// 						[
	// 							topButton(),
	// 							SizedBox(height: height / 25,),
	// 							sizeTitle(),
	// 							SizedBox(height: height / 25,),
	// 							selectSizeText(),
	// 							SizedBox(height: 3,),
	// 							chooseSize(),
	// 							SizedBox(height: height / 25,),
	// 							submitButton(),
	// 							SizedBox(height: 5,),
	// 						],
	// 					),
	// 				)
	// 			);
	// 		}
	// 	);
	// }

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

	submitButton()
	{
		return 
		// Expanded
		// (
		// 	child: 
			Container
			(
				margin: EdgeInsets.only(right: 15),
				height: 50,
				width: double.infinity,
				child: ElevatedButton
				(
					child: Text
					(
						"Done",
						style: TextStyle(fontSize: 14)
					),
					style: ButtonStyle
					(
						foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
						backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xffF56C27"))),
						shape: MaterialStateProperty.all<RoundedRectangleBorder>
						(
							RoundedRectangleBorder
							(
								borderRadius: BorderRadius.circular(15.5),
								side: BorderSide(color: Colors.white38)
							)
						)
					),
					onPressed: () => null
				)
			// )
		);
	}
}