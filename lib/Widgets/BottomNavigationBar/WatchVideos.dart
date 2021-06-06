import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/TaggedProductsPage.dart';
import 'package:hypd/Widgets/BottomNavigationBar/VideoPlayer.dart';
import 'package:hypd/Widgets/MyBag.dart';
import 'package:hypd/Widgets/MyWishlist.dart';
import 'package:hypd/Widgets/Notifications.dart';
import 'package:video_player/video_player.dart';

class WatchVideo extends StatefulWidget
{
	@override
	_WatchVideoState createState() => _WatchVideoState();
}

class _WatchVideoState extends State<WatchVideo>
{
	var height;
	var width;
	var random;

	bool isFavourite = false;
	bool isFullScreen = false;
	bool isIconExpanded = false;

	List videos =
	[
		"https://vod-progressive.akamaized.net/exp=1622717966~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F993%2F20%2F504965980%2F2312203141.mp4~hmac=bed1903c8f3d7462eb7f7605f5e9a5ef47cb7d07888c088e97f8fc70787eee68/vimeo-prod-skyfire-std-us/01/993/20/504965980/2312203141.mp4?filename=pexels-roman-odintsov-6609500.mp4",
		"https://vod-progressive.akamaized.net/exp=1622718679~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4949%2F20%2F524748008%2F2459605317.mp4~hmac=c254e665e62355907c625f25c00095ec779108b4864aee905e2513fcc9008200/vimeo-prod-skyfire-std-us/01/4949/20/524748008/2459605317.mp4?filename=pexels-cottonbro-7169950.mp4",
		"https://vod-progressive.akamaized.net/exp=1622717966~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F993%2F20%2F504965980%2F2312203141.mp4~hmac=bed1903c8f3d7462eb7f7605f5e9a5ef47cb7d07888c088e97f8fc70787eee68/vimeo-prod-skyfire-std-us/01/993/20/504965980/2312203141.mp4?filename=pexels-roman-odintsov-6609500.mp4",
	];

	var temp = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla non venenatis ligula. Praesent massa ex, vestibulum eget nisl sit amet, rutrum ullamcorper augue. Aliquam erat leo, hendrerit non ipsum sit amet, auctor sollicitudin odio. Donec aliquet accumsan nunc. Vestibulum condimentum et urna eget porttitor. Mauris ultrices id augue et convallis. Etiam lobortis tincidunt libero, eget efficitur orci commodo euismod.";

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;
		random = new Random();

		return Scaffold
		(
			backgroundColor: Colors.white,
			// appBar: appBar(),
			body: Container
			(
				height: height,
				width: width,
				child: videoPlayer(),
			),
			// bottomNavigationBar: BottomNavBar(pageInd: 0,),
		);
	}

	videoPlayer()
	{
		return Stack
		(
			children:
			[
				// video player
				Container
				(
					// color: Colors.red,
					height: height,
					width: width,
					child: CarouselSlider.builder
					(
              			itemCount: 1,
              			options:CarouselOptions
						(
							// aspectRatio: 16 / 9,
							height: height,
							autoPlay: false,
							viewportFraction: 1.0,
							scrollDirection: Axis.vertical,
                  			onPageChanged: (index, reason)
							{
                    			setState(()
								{
                      				isFullScreen = true;
                    			});
                  			}
              			),
              			itemBuilder: (BuildContext context,index, i)
						{
                			return Player("https://vod-progressive.akamaized.net/exp=1622717966~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F993%2F20%2F504965980%2F2312203141.mp4~hmac=bed1903c8f3d7462eb7f7605f5e9a5ef47cb7d07888c088e97f8fc70787eee68/vimeo-prod-skyfire-std-us/01/993/20/504965980/2312203141.mp4?filename=pexels-roman-odintsov-6609500.mp4");
              			},
            		),
				),
				// buttons
				buttons(context),
				description()
			],
		);
	}

	appBar()
	{
		return PreferredSize
		(
        	preferredSize: Size.fromHeight(50.0),
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
						"Ruvieroy.",
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

	buttons(context)
	{
		return Positioned
		(
			right: 5,
			bottom: 10,
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
			)
		);
	}

	myFavourite()
	{
		return Container
		(
			// margin: EdgeInsets.all(5),
			height: 30,
			width: 30,
			decoration: BoxDecoration
			(
				// color: Color(int.parse("0xfff2f2f0")),
				borderRadius: BorderRadius.circular(10)
			),
			child: FittedBox
			(
				child: IconButton
				(
					iconSize: 50,
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
			height: 30,
			width: 30,
			decoration: BoxDecoration
			(
				borderRadius: BorderRadius.circular(10)
			),
			child: FittedBox
			(
				child: IconButton
				(
					iconSize: 50,
					onPressed: ()
					{
						setState(()
						{
							isFavourite = !isFavourite;
						});
					},
					icon: Icon
					(
						Icons.remove_red_eye_outlined,
						color: Colors.white70,
					),
				),
			)
		);
	}

	share()
	{
		return Container
		(
			height: 30,
			width: 30,
			decoration: BoxDecoration
			(
				borderRadius: BorderRadius.circular(10)
			),
			child: FittedBox
			(
				child: IconButton
				(
					iconSize: 50,
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
												"Ruvieroy Store",
												style: GoogleFonts.montserrat
												(
													color: Colors.white,
													fontSize: 15,
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
			isScrollControlled: true,
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
			context: context,
			builder: (context)
			{
				return FractionallySizedBox
				(
        			heightFactor: 0.65,
					child: Container
					(
						decoration: BoxDecoration
						(
							color: Colors.white,
							borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
						),
						child: Column
						(
							children:
							[
								topButton(),
								SizedBox(height: height / 25,),
								title(),
								SizedBox(height: height / 25,),
								taggedProducts()
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
			margin: EdgeInsets.only(top: 2, bottom: 0),
			height: height / 2.5,
			child: ListView.builder
			(
				scrollDirection: Axis.horizontal,
				itemBuilder: (BuildContext context, int index)
				{
					return GestureDetector
					(
						child: Container
						(
							margin: EdgeInsets.only(left: 35),
							// height: 10,
							child: Stack
							(
								children:
								[
									Positioned
									(
										child: Container
										(
											height: height / 3,
											width: width / 2.5,
											child: FittedBox
											(
												child:ClipRRect
												(
													borderRadius: BorderRadius.circular(50.0),
													child: Image.network("https://images.pexels.com/photos/3526923/pexels-photo-3526923.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
												),
												fit: BoxFit.fill,
											)
										)
									),
									Positioned
									(
										left: 0,
										bottom: 0,
										child: Container
										(
											height: height / 8,
											width: width / 2.6,
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
													isThreeLine: true,
													title: Text
													(
														"Yellow Blossom Print Shirt",
														style: GoogleFonts.montserrat
														(
															color: Colors.black,
															fontWeight: FontWeight.w400,
															fontSize: 12,
														),
													),
													subtitle: Padding
													(
														padding: EdgeInsets.only(top: 3),
														child: Text
														(
															" ₹ 12000",
															style: GoogleFonts.montserrat
															(
																color: Colors.black,
																fontWeight: FontWeight.bold,
																fontSize: 12,
															),
														),
													)
													// leading: Column
													// (
													// 	mainAxisAlignment: MainAxisAlignment.spaceAround,
													// 	crossAxisAlignment: CrossAxisAlignment.start,
													// 	children:
													// 	[
													// 		SizedBox(height: 5),
													// 		Expanded
													// 		(
													// 			child:

													// 				Text
													// 				(
													// 					"Yello Blossom Print Shirt",
													// 					style: GoogleFonts.montserrat
													// 					(
													// 						color: Colors.black,
													// 						fontWeight: FontWeight.w500,
													// 						fontSize: 10,
													// 					),
													// 				),
													// 			// ],
													// 		),
													// 		SizedBox(height: 5),
													// 		Expanded(child: Text
													// 		(
													// 			" ₹ 12000",
													// 			style: GoogleFonts.montserrat
													// 			(
													// 				color: Colors.black,
													// 				fontWeight: FontWeight.bold,
													// 				fontSize: 10,
													// 			),
													// 		),)
													// 	],
													// )
												),
											),
										)
									),
								],
							)
						),
						onTap:()
						{
							// Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));
						},
					);
				}
			),
		);
	}
}