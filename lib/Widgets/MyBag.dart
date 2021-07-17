import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/API/Server.dart';
import 'package:hypd/Widgets/MyWishlist.dart';
import 'package:hypd/Widgets/Utilities/SelectSizeModal.dart';
import 'package:hypd/global.dart';

class MyBag extends StatefulWidget
{
	@override
	_MyBagState createState() => _MyBagState();
}

class _MyBagState extends State<MyBag>
{
	var height;
	var width;
	var totalPrice = 0;

	List size = ["S", "M", "L", "XL", "XXL", "XXXL"];
	List cartList = [];

	bool isEmpty = true;

	@override
	void initState()
	{
		super.initState();
		getCartItems();
	}

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return Scaffold
		(
			appBar: appBar(),
			resizeToAvoidBottomInset: false,
			backgroundColor: isEmpty ? Colors.white : Color(int.parse("0xff312247")),
			body: Container
			(
				padding: EdgeInsets.only( bottom: 25),
				child: isEmpty ? bagIsEmpty() : bagItems()
			),
			bottomSheet: isEmpty ? null : priceDetails(),
		);
	}

	appBar()
	{
		return AppBar
		(
			title: Text
			(
				"My Bag",
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w400
				),
			),
			elevation: 0,
			backgroundColor: Colors.white,
			leading: Container
			(
				margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
				padding: EdgeInsets.all(5),
				height: 30,
				width: 30,
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
			]
		);
	}

	Widget bagIsEmpty()
	{
		return Column
		(
			crossAxisAlignment: CrossAxisAlignment.center,
			children:
			[
				SizedBox(height: height / 6.5,),
				bagImage(),
				SizedBox(height: height / 25,),
				mainText(),
				SizedBox(height: height / 35,),
				subText(),
				SizedBox(height: height / 10,),
			],
		);
	}

	Widget bagImage()
	{
		return Container
		(
			height: height / 4,
			width: width / 2,
			child: Center
			(
				child: Image.network("https://employer.jobtest.vn/cart/images/owl-cartempty.png"),
			),
		);
	}

	Widget mainText()
	{
		return  Container
		(
			child: Center
			(
				child: Text
				(
					"Your Bag is Empty",
					style: GoogleFonts.montserrat
					(
						fontWeight: FontWeight.w500,
						fontSize: 20
					),
					textAlign: TextAlign.center,
				),
			),
		);
	}

	Widget subText()
	{
		return  Container
		(
			child: Center
			(
				child: Text
				(
					"Add items to it now.",
					style: GoogleFonts.montserrat
					(
						fontWeight: FontWeight.w400,
						fontSize: 15,
						color: Colors.grey
					),
					textAlign: TextAlign.center,
				),
			),
		);
	}

	Widget bagItems()
	{
		print(user);
		return Container
		(
			decoration: BoxDecoration
			(
				color: Colors.white,
				borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.5), bottomRight: Radius.circular(15.5)),
			),
			height: height / 1.5,
			child: Container
			(
				decoration: BoxDecoration
				(
					color: Colors.white,
					borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.5), bottomRight: Radius.circular(15.5)),
				),
				margin: EdgeInsets.only(bottom: 10, top: 30),
				height: height / 1.8,
				child: ListView.builder
				(
					itemCount: cartList.length,
					scrollDirection: Axis.horizontal,
					itemBuilder: (BuildContext context, int index)
					{
						return GestureDetector
						(
							child: Container
							(
								margin: EdgeInsets.only(left: 35),
								height: 25,
								child: Column
								(
									children:
									[
										Container
										(
											height: height / 3.5,
											width: width / 2.5,
										child: FittedBox
											(
												child:ClipRRect
												(
													borderRadius: BorderRadius.circular(50.0),
													child: Image.network(cartList[index]["productImage"][0]["image"]),
												),
												fit: BoxFit.fill,
											)
										),
										SizedBox(height: 7,),
										brandName(index),
										SizedBox(height: 7,),
										productName(index),
										SizedBox(height: 7,),
										cost(index),
										SizedBox(height: 7,),
										sizeSelector(),
										SizedBox(height: 7,),
										buttons(index)
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
			)
		);
	}

	Widget brandName(index)
	{
		return Center
		(
			child: Text
			(
				cartList[index]["productBrand"].toString(),
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w600,
					color: Colors.black26,
					fontSize: 10
				),
			),
		);
	}

	Widget productName(index)
	{
		return Center
		(
			child: Text
			(
				cartList[index]["productName"].toString(),
				style: GoogleFonts.montserrat
				(
					color: Colors.black,
					fontSize: 10,
					fontWeight: FontWeight.w500
				),
			),
		);
	}

	Widget cost(index)
	{
		return Center
		(
			child: RichText
			(
				text: TextSpan
				(
					children:
					[
						TextSpan
						(
							text: "₹ " + cartList[index]["productPrice"].toString(),
							style: GoogleFonts.montserrat
							(
								color: Colors.black,
								fontWeight: FontWeight.bold,
								fontSize: 10
							),
						),
						TextSpan
						(
							text: "  ₹ 900",
							style: GoogleFonts.montserrat
							(
								fontWeight: FontWeight.w600,
								color: Colors.black26,
								fontSize: 10
							),
						),
						TextSpan
						(
							text: "  (55% off)",
							style: GoogleFonts.montserrat
							(
								color: Color(int.parse("0xff42b369")),
								fontWeight: FontWeight.bold,
								fontSize: 10,
							)
						),
					]
				)
			)
		);
	}

	Widget sizeSelector()
	{
		return Center
		(
			child: GestureDetector
			(
				child: Container
				(
					padding: EdgeInsets.only(left: 10, right: 10),
					height: 20,
					decoration: BoxDecoration
					(
						color: Color(int.parse("0xffe8e7e3")),
						borderRadius: BorderRadius.circular(15.5)
					),
					child: Row
					(
						children:
						[
							Text
							(
								"Size: ",
								style: GoogleFonts.montserrat
								(
									fontSize: 10,
									fontWeight: FontWeight.bold
								),
							),
							SizedBox(width: 3,),
							Text
							(
								"M",
								style: GoogleFonts.montserrat
								(
									color: Colors.black38,
									fontWeight: FontWeight.w300
								),
							),
							Icon
							(
								Icons.keyboard_arrow_down_sharp,
								color: Colors.black38,
							)
						],
					),
				),
				onTap: ()
				{
					showSizeModal(context, height, width, size);
				},
			)
		);
	}

	Widget buttons(index)
	{
		var quantity = cartList[index]["productQuantity"];

		return  Container
		(
			padding: EdgeInsets.only(left: 15, right: 15),
			margin: EdgeInsets.only(left: 5, right: 5, top: 2),
			decoration: BoxDecoration
			(
				borderRadius: BorderRadius.circular(15)
			),
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.spaceAround,
				children:
				[
					// Expanded
					// (
						// child:
						Container
						(
							height: 25,
							decoration: BoxDecoration
							(
								border: Border.all(color: Colors.black12),
								borderRadius: BorderRadius.circular(7)
							),
							child: FittedBox
							(
								child: IconButton
								(
									onPressed: ()
									{
										setState(() 
										{
											if(quantity > "1")
											{
												quantity --;
											}
										});
									},
									icon: Icon(Icons.remove, color: Colors.black38),
								),
							),
						),
					// ),
					// Expanded
					// (
					// 	child:
					Container
						(
							padding: EdgeInsets.all(5),
							child: Center
							(
								child: Text
								(
									quantity.toString(),
									style: GoogleFonts.montserrat
									(
										color: Colors.black38,
										fontWeight: FontWeight.w300
									),
								),
							),
						),
					// ),
					// Expanded
					// (
					// 	child:
					Container
						(
							height: 25,

							decoration: BoxDecoration
							(
								border: Border.all(color: Colors.black12),
								borderRadius: BorderRadius.circular(7)
							),
							child: FittedBox
							(
								child: IconButton
								(
									onPressed: ()
									{
										setState(() 
										{
											quantity ++;
										});
									},
									icon: Icon(Icons.add_outlined, color: Colors.black38),
								),
							),
						)
					// ),
				],
			),
		);
	}

	priceDetails()
	{
		print(user);
		return Container
		(
			color: Color(int.parse("0xff312247")),
			height: 100,
			child: Row
			(
				children:
				[
					Container
					(
						margin: EdgeInsets.only(bottom:15, left: 15, right: 5 ),
						height: MediaQuery.of(context).size.height / 12,
						child: Column
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
										//  popPriceDetails(context);
									}
								),
								SizedBox(height: 10,),
								Padding
								(
									padding: EdgeInsets.only(left: 15),
									child: Text
									(
										"₹ " + totalPrice.toString(),
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
									"Pay Now",
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

	// -------------------------------------------------------API-----------------------------------------------------//

	getCartItems() async
	{

		var userId = user["id"];

		var response = await Server.getCartProducts(userId);

		if(response["status"] == 0)
		{
			for(int i = 0; i < response["cartList"].length; i++)
			{
				cartList.add(response["cartList"][i]);
			}

			setState(() 
			{
				isEmpty = false;
				totalPrice = response["totalAmount"];
			});
		}
		else
		{
			isEmpty = true;
		}
	}
}





