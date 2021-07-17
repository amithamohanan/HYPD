import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/API/Server.dart';
import 'package:hypd/Widgets/BottomNavigationBar/BottomNavBar.dart';
import 'package:hypd/Widgets/EditProfile.dart';
import 'package:hypd/Widgets/MyAddress.dart';
import 'package:hypd/Widgets/MyOrders.dart';
import 'package:hypd/Widgets/MyWallet.dart';
import 'package:hypd/Widgets/settings.dart';
import 'package:hypd/global.dart';

class UserAccount extends StatefulWidget
{
	@override
	_UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount>
{
	var height;
	var width;
	var fontSize;
	var response;

	@override
	void initState()
	{
		super.initState();
		print(user);
	}

	@override
	Widget build(BuildContext context)
	{
		height = getHeight(context);
		width = getWidth(context);
		fontSize = getFontSize(context);

		return Scaffold
		(
			body: body(),
			bottomNavigationBar: BottomNavBar(pageInd: 2,),
		);
	}

	Widget body()
	{
		return Container
		(
			child: Stack
			(
				children: 
				[
					Container
					(
						color: Colors.white,
						height: height,
						width: width,
						child: Text(""),
					),
					Positioned
					(
						bottom: 5,
						left: 0,
						right: 0,
						child: inviteLink()
					),
					Positioned
					(
						left: 0,
						right: 0,
						top: 5,
						child: userAccount()
					)
				],
			),
		);
	}

	Widget userAccount()
	{
		return Container
		(
			margin: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 25),
			padding: EdgeInsets.all(5),
			decoration: BoxDecoration
			(
				borderRadius: BorderRadius.circular(25),
				color: Color(int.parse("0xff674094"))
			),
			child: Column
			(
				crossAxisAlignment: CrossAxisAlignment.start,
				children:
				[
					settingsIcon(),
					SizedBox(height: 10,),
					imageUpload(),
					SizedBox(height: 10),
					text(),
					SizedBox(height: 5,),
					orderDetails1(),
					SizedBox(height: 5,),
					orderDetails2(),
					SizedBox(height: 20,),
				],
			),
		);
	}

	settingsIcon()
	{
		return Padding
		(
			padding: EdgeInsets.only(top: 15, right: 15),
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.end,
				children:
				[
					Container
					(
						// margin: EdgeInsets.all(5),
						height: 45,
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
								Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
							},
							icon: Icon(Icons.settings_outlined),
							color: Colors.black,
						),
					),
				],
			)
		);
	}

	Widget imageUpload()
	{
		return  Row
		(
			children:
			[

				Container
				(
					margin: EdgeInsets.only(left: 10),
					height: 70,
					width: 70,
					child: ClipRRect
					(
    					borderRadius: BorderRadius.circular(10.0),
						child: user["image"] == null ? Image.network("https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg", fit: BoxFit.contain) : Image.network(user["image"].toString(), fit: BoxFit.fill)
					),
				),
				Container
				(
					margin: EdgeInsets.only(left: 10),
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children:
						[
							Text
							(
								user["name"].toString() == "null" ? "" : user["name"].toString(),
								style: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.white
								),
							),
							SizedBox(height: 10,),
							Text
							(
								user["phone"].toString() == "null" ? "" : user["phone"].toString(),
								style: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.w300,
									color: Colors.white
								),
							)
						],
					),
				)
			],
		);
	}

	text()
	{
		return Padding
		(
			padding: EdgeInsets.only(left: 10),
			child: Column
			(
				crossAxisAlignment: CrossAxisAlignment.start,
				children:
				[
					Text
					(
						"Baby Munchkins Credit Wallet",
						style: GoogleFonts.montserrat
						(
							color: Colors.white,
							fontSize: fontSize / 25,
							fontWeight: FontWeight.w200,
						),
					),
					SizedBox(height: 3,),
					Text
					(
						"₹ 0.00",
						style: GoogleFonts.montserrat
						(
							color: Colors.amber,
							fontSize: fontSize / 25,
							fontWeight: FontWeight.w600,
						),
					)
				],
			),
		);
	}

	orderDetails1()
	{
		return  Container
		(
			margin: EdgeInsets.only(left: 10, right: 10),
			child: Column
			(

				children:
				[
					Row
					(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children:
						[
							profileDetailsButton(),
							SizedBox(width: width / 25,),
							myWallet(),
						],
					)
				],
			),
		);
	}

	Widget profileDetailsButton()
	{
		return Expanded
		(
			child: OutlinedButton
			(
				onPressed: ()
				{
					Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
				},
				child: Row
				(
					children: <Widget>
					[
						Align
						(
							alignment: Alignment.centerLeft,
							child: Icon(Icons.account_circle, color: Colors.white,)
						),
						SizedBox(width: width / 35,),
						Align
						(
							alignment: Alignment.center,
							child: Text
							(
								"Profile Details",
								style: GoogleFonts.montserrat
								(
									fontSize: 10,
									color: Colors.white
								),
							)
						)
					],
				),
				style: OutlinedButton.styleFrom
				(
      				shape: RoundedRectangleBorder
					(
         				borderRadius: BorderRadius.circular(8.0),
      				),
      				side: BorderSide(width: 1, color: Colors.white38),
   				)
			)
		);
	}

	Widget myWallet()
	{
		return Expanded
		(
			child: OutlinedButton
			(
				onPressed: ()
				{
					Navigator.push(context, MaterialPageRoute(builder: (context) => MyWallet()));
				},
				child: Row
				(
					children: <Widget>
					[
						Align
						(
							alignment: Alignment.centerLeft,
							child: Icon(Icons.payment_rounded, color: Colors.white,)
						),
						SizedBox(width: width / 35,),
						Align
						(
							alignment: Alignment.center,
							child: Text
							(
								"My Wallet",
								style: GoogleFonts.montserrat
								(
									fontSize: 10,
									color: Colors.white
								),
							)
						)
					],
				),
				style: OutlinedButton.styleFrom
				(
      				shape: RoundedRectangleBorder
					(
         				borderRadius: BorderRadius.circular(8.0),
      				),
      				side: BorderSide(width: 1, color: Colors.white38),
   				)
			),
		);
	}

	orderDetails2()
	{
		return  Container
		(
			margin: EdgeInsets.only(left: 10, right: 10),
			child: Column
			(

				children:
				[
					Row
					(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children:
						[
							myOrders(),
							SizedBox(width: width / 25,),
							myAddress(),
						],
					)
				],
			),
		);
	}

	Widget myOrders()
	{
		return Expanded
		(
			child: OutlinedButton
			(
				onPressed: ()
				{
					Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders()));
				},
				child: Row
				(
					children: <Widget>
					[
						Align
						(
							alignment: Alignment.centerLeft,
							child: Icon(Icons.book_online, color: Colors.white,)
						),
						SizedBox(width: width / 35,),
						Align
						(
							alignment: Alignment.center,
							child: Text
							(
								"My Orders",
								style: GoogleFonts.montserrat
								(
									fontSize: 10,
									color: Colors.white
								),
							)
						)
					],
				),
				style: OutlinedButton.styleFrom
				(
      				shape: RoundedRectangleBorder
					(
         				borderRadius: BorderRadius.circular(8.0),
      				),
      				side: BorderSide(width: 1, color: Colors.white38),
   				)
			),
		);
	}

	Widget myAddress()
	{
		return Expanded
		(
			child: OutlinedButton
			(
				onPressed: ()
				{
					Navigator.push(context, MaterialPageRoute(builder: (context) => MyAddress()));
				},
				child: Row
				(
					children: <Widget>
					[
						Align
						(
							alignment: Alignment.centerLeft,
							child: Icon(Icons.location_on, color: Colors.white,)
						),
						SizedBox(width: width / 35,),
						Align
						(
							alignment: Alignment.center,
							child: Text
							(
								"My Address",
								style: GoogleFonts.montserrat
								(
									fontSize: 10,
									color: Colors.white
								),
							)
						)
					],
				),
				style: OutlinedButton.styleFrom
				(
      				shape: RoundedRectangleBorder
					(
         				borderRadius: BorderRadius.circular(8.0),
      				),
      				side: BorderSide(width: 1, color: Colors.white38),
   				)

			),
		);
	}

	Widget inviteLink()
	{

		return Container
		(
			padding: EdgeInsets.only(left: 20, top: 15),
			decoration: BoxDecoration
			(
				borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
			),
			child: Row
			(
				crossAxisAlignment: CrossAxisAlignment.center,
				children:
				[
					Expanded
					(
						child: Container
						(
							// color: Colors.red,
							// width: width * .55,
							// margin: EdgeInsets.only(top: 20, right: 10),
							child: Column
							(
								crossAxisAlignment: CrossAxisAlignment.start,
								// mainAxisAlignment: MainAxisAlignment.start,
								children: 
								[
									Text
									(
										"Refer a friend",
										style: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.bold,
											color: Colors.black,
										),
									),
									SizedBox(height: height / 25,),
									Wrap
									(
										children: 
										[
											Text
											(
												"Invite your friends to Baby Munchkins and enjoy shopping togethere!",
												style: GoogleFonts.montserrat
												(
													fontSize: fontSize / 30,
													fontWeight: FontWeight.w300,
													color: Colors.black54,
												),
												textAlign: TextAlign.left,
											),
										],
									),
									// Text
									// (
									// 	"enjoy shopping togethere!",
									// 	style: GoogleFonts.montserrat
									// 	(
									// 		fontSize: 13,
									// 		fontWeight: FontWeight.w300,
									// 		color: Colors.black54,
									// 	),
									// 	textAlign: TextAlign.left,
									// ),
									SizedBox(height: height / 30,),
									Container
									(
										height: height / 13,
										width: width / 2.5,
										child: ElevatedButton
										(
											child: Text
											(
												"Invite Friends",
												style: GoogleFonts.montserrat
												(
													fontWeight: FontWeight.bold,
													fontSize: 14,
													color: Colors.white
												)
											),
											style: ButtonStyle
											(
												foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
												backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xff674094"))),
												shape: MaterialStateProperty.all<RoundedRectangleBorder>
												(
													RoundedRectangleBorder
													(
														borderRadius: BorderRadius.circular(15.5),
														side: BorderSide(color: Colors.white38)
													)
												)
											),
											onPressed: ()
											{
												// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddUserDetails()));
											}
										)
									)
								],
							),
						)
					),
					Expanded
					(
						// height: height * .2,
						// width: width * .2,
						// child: FittedBox
						// (
						// 	fit: BoxFit.contain,
							child: Image.asset("assets/images/59347-gift-box (2).gif", fit: BoxFit.contain,),
						// )
					)
				],
			),
		);
	}

	
}


