import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/MyBag.dart';
import 'package:hypd/Widgets/MyWishlist.dart';
import 'package:hypd/Widgets/Notifications.dart';

class ViewAll extends StatefulWidget 
{
	@override
	_ViewAllState createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> 
{
	var height;
	var width;

	bool isFavourite = false;

	@override
	Widget build(BuildContext context) 
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return Scaffold
		(
			backgroundColor: Colors.white,
			appBar: appBar(),
			body: gridView(context),
		);
	}

	appBar()
	{
		return PreferredSize
		(
        	preferredSize: Size.fromHeight(height / 8),
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

	gridView(context)
	{
		// print(temp[0]);
		return Container
		(
			padding: EdgeInsets.all(20),
			child: GridView.count
			(
				crossAxisCount: 2,
				mainAxisSpacing: 8,
				crossAxisSpacing: 9,
				childAspectRatio: 0.55,
				children: List.generate(15, (index)
				{
					return InkWell
					(
						child: Container
						(
							margin: EdgeInsets.only(left: 15),
							color: Colors.white,
							height: height / 2.3,
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
													child: Image.network("https://images.pexels.com/photos/908934/pexels-photo-908934.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
												),
												fit: BoxFit.fill,
											)
										)
									),
									Positioned
									(
										left: 0,
										bottom: height / 30,
										child: Container
										(
											height: height / 8,
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
									),
									Positioned
									(
										top: 5,
										right: 2,
										child:Container
										(
											margin: EdgeInsets.all(5),
											height: height / 16,
											width: width / 10,
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
						)
					);
				}),
			)
		);
	}
}