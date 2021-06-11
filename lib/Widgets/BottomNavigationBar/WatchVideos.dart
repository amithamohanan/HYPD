import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/TaggedProductsPage.dart';
import 'package:hypd/Widgets/BottomNavigationBar/VideoPlayer.dart';
import 'package:hypd/Widgets/ProductPage.dart';
import 'package:hypd/global.dart';

class WatchVideo extends StatefulWidget
{
	WatchVideo(this.hasChanged);
	final hasChanged;

	@override
	_WatchVideoState createState() => _WatchVideoState(this.hasChanged);
}

class _WatchVideoState extends State<WatchVideo>
{
	_WatchVideoState(this.hasChanged);
	final hasChanged;

	var height;
	var width;
	var fontSize;
	var random;

	bool isFavourite = false;
	bool isFullScreen = false;
	bool isIconExpanded = false;

	List videos =
	[
		"https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
		"https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
		"https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
		"https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
	];

	var temp = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla non venenatis ligula. Praesent massa ex, vestibulum eget nisl sit amet, rutrum ullamcorper augue. Aliquam erat leo, hendrerit non ipsum sit amet, auctor sollicitudin odio. Donec aliquet accumsan nunc. Vestibulum condimentum et urna eget porttitor. Mauris ultrices id augue et convallis. Etiam lobortis tincidunt libero, eget efficitur orci commodo euismod.";

	@override
	Widget build(BuildContext context)
	{
		height = getHeight(context);
		width = getWidth(context);
		fontSize = getFontSize(context);

		return Scaffold
		(
			backgroundColor: Colors.white,
			body: Container
			(
				height: height,
				width: width,
				child: videoPlayer(),
			),
		);
	}

	videoPlayer()
	{
		return Stack
		(
			children:
			[
				Container
				(
					height: height,
					width: width,
					child: CarouselSlider.builder
					(
              			itemCount: 1,
              			options:CarouselOptions
						(
							height: height,
							autoPlay: false,
							viewportFraction: 1.0,
							scrollDirection: Axis.vertical,
                  			onPageChanged: (index, reason)
							{
                    			setState(()
								{
                      				isFullScreen = true;
									this.hasChanged(true);
                    			});
                  			}
              			),
              			itemBuilder: (BuildContext context,index, i)
						{
                			return Player(videos[index]);
              			},
            		),
				),
				// buttons
				buttons(context),
				description()
			],
		);
	}

	buttons(context)
	{
		return Positioned
		(
			right: 5,
			bottom: 10,
			child: Container
			(
				child: Column
				(
					children:
					[
						// my favourite
						myFavourite(),
						Text
						(
							"6",
							style: GoogleFonts.montserrat
							(
								color: Colors.white,
								fontSize: 11,
								fontWeight: FontWeight.w300
							),
						),
						SizedBox(height: 20,),
						// viewers
						viewers(),
						Text
						(
							"74",
							style: GoogleFonts.montserrat
							(
								color: Colors.white,
								fontSize: 13,
							),
						),
						SizedBox(height: 15,),
						// share
						share(),
						SizedBox(height: 15,),
						// add to cart
						addToCart(context),
						SizedBox(height: 15,),

					],
				),
			)
		);
	}

	myFavourite()
	{
		return Container
		(
			height: 45,
			width: 45,
			child: FittedBox
			(
				child: IconButton
				(
					iconSize: 30,
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
						Icons.favorite_border_outlined,
						color: Colors.white70,
					),
				)
			)
		);
	}

	viewers()
	{
		return Container
		(
			height: 45,
			width: 45,
			child: FittedBox
			(
				child: IconButton
				(
					iconSize: 30,
					onPressed: ()
					{
						taggedProductsPopUp(context);
					},
					icon: Icon(Icons.remove_red_eye_outlined,
					color: Colors.white70),
				)
			)
		);
	}

	share()
	{
		return Container
		(
			height: 45,
			width: 45,
			child: FittedBox
			(
				child: IconButton
				(
					iconSize: 30,
					onPressed: ()
					{
						Navigator.push(context, MaterialPageRoute(builder: (context) => TaggedProducts()));
					},
					icon: Icon
					(
						Icons.ios_share_outlined,
						color: Colors.white70,
					),
				),
			)
		);
	}

	addToCart(context)
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
					iconSize: 30,
					onPressed: ()
					{
						taggedProductsPopUp(context);
					},
					icon: Icon(Icons.shopping_bag_outlined),
					color: Colors.black,
				),
			)
		);
	}

	description()
	{
		return Positioned
		(
			bottom: 10,
			left: 15,
			right: 15,
			child: Container
			(
				// color: Colors.amber,
				height: isIconExpanded ? height / 2.2 : height / 6,
				child: Column
				(
					children:
					[
						Row
						(
							children:
							[
								Container
								(
									height: 45,
									width: 45,
									child: ClipRRect
									(
										borderRadius: BorderRadius.circular(15.5),
										child: Image.network("https://images.pexels.com/photos/4131101/pexels-photo-4131101.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", fit: BoxFit.cover),
									)
								),
								SizedBox(width: 10,),
								Container
								(
									height: 45,
									child: Column
									(
										crossAxisAlignment: CrossAxisAlignment.start,
										children:
										[
											Text
											(
												"Baby Munchkins",
												style: GoogleFonts.montserrat
												(
													color: Colors.white,
													fontSize: fontSize / 25,
													fontWeight: FontWeight.w600
												),
											),
											Text
											(
												"Nov 26, 2021",
												style: GoogleFonts.montserrat
												(
													color: Colors.white,
													fontSize: 13,
													fontWeight: FontWeight.w300
												),
											),
										],
									),
								)
							],
						),
						SizedBox(height: 8,),
						moreInfo()
					],
				),
			)
		);
	}

	Widget moreInfo()
    {
		double textSize = width;

        return Column
        (
			crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
                Padding
                (
                    padding: EdgeInsets.only(left: 2, right: 50),
                    child: Wrap
					(
						children: 
						[
							Text
							(
								isIconExpanded == true ? temp.toString() : temp.length < 100 ? temp.toString() : temp.substring(0, 25),
								style: GoogleFonts.montserrat
								(
									color: Colors.white,
									fontSize: textSize / 26,
									fontWeight: FontWeight.w300
								),
							)
						],
					),
                ),
                temp.length < 25 ? SizedBox.shrink() : GestureDetector
                (
                    child: Text
					(
						isIconExpanded ? "Less" : "Read more",
                        style: GoogleFonts.montserrat
						(
							color: Colors.white,
							fontWeight: FontWeight.bold,
							fontSize: textSize / 26
						),
					),
                    onTap: ()
                    {
                        setState(()
                        {
                        	isIconExpanded = !isIconExpanded;
                        });
                    }
                )
            ],
        );
    }

	taggedProductsPopUp(context)
	{

		return showModalBottomSheet
		(
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
			context: context,
			builder: (BuildContext context) 
			{
    			return  Container
					(
						decoration: BoxDecoration
						(
							color: Colors.white,
							borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
						),
						child: Wrap
						(
							children:
							[
								topButton(),
								SizedBox(height: height / 25,),
								title(),
								SizedBox(height: height / 25,),
								taggedProducts(),
								SizedBox(height: 20),
							],
						),
					// )
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
				"Tagged Products",
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w500,
					color: Colors.black,
					fontSize: 18
				),
			),
		);
	}

	taggedProducts()
	{
		return  Container
		(
			color: Colors.white,
			margin: EdgeInsets.only(top: 2, bottom: 0),
			height: 260,
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
			),
		);
	}
}
