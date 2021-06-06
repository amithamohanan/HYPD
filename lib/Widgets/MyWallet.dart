import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWallet extends StatefulWidget 
{
	@override
	_MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> 
{
	var height;
	var width;

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return Scaffold
		(
			backgroundColor: Color(int.parse("0xff312247")),
			appBar: appBar(),
			body: Container
			(
				margin: EdgeInsets.only(top: 10),
				child: Column
				(
					crossAxisAlignment: CrossAxisAlignment.center,
					// mainAxisAlignment: MainAxisAlignment.end,
					children:
					[
						SizedBox(height: height / 25,),
						titleText(),
						SizedBox(height: height / 25,),
						cost()
					],
				),
			),
			bottomSheet: transcation(),
		);
	}

	appBar()
	{
		return AppBar
		(
			elevation: 0,
			backgroundColor: Color(int.parse("0xff312247")),
			leading: Container
			(
				margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
				padding: EdgeInsets.all(5),
				height: 30,
				width: 30,
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
			centerTitle: true,
			title: Text
			(
				"WALLET",
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w600,
					fontSize: 20,
					color: Colors.white54
				),
			),
		);
	}


	titleText()
	{
		return Container
		(
			width: width,
			height: height / 30,
			child:
			Text
			(
				"Ruvieroy Credit Wallet",
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w200,
					color: Colors.white54,
					fontSize: 18
				),
				textAlign: TextAlign.center,
			),
		);
	}

	cost()
	{
		return Container
		(
			width: width,
			height: height / 25,
			child: Text
			(
				"₹ 0.00",
				style: GoogleFonts.montserrat
				(
					color: Colors.amber,
					fontSize: 25,
					fontWeight: FontWeight.w600,
				),
				textAlign: TextAlign.center,
			),
		);
	}

	transcation()
	{
		return GestureDetector
		(
			child: Container
			(
				height: height / 5,
				width: width,
				decoration: BoxDecoration
				(
					color: Colors.white10,
					borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight:  Radius.circular(50))
				),
				child: Column
				(
					children: 
					[
						topButton(),
						SizedBox(height: height / 30),
						title()
					],
				),
			),
		);
	}

	topButton()
	{
		return Container
		(
			decoration: BoxDecoration
			(
				color: Colors.black38,
				borderRadius: BorderRadius.circular(5)
			),
			margin: EdgeInsets.only(top: 15),
			height: 4,
			width: 50,
		);
	}

	title()
	{
		return Text
		(
			"Transcations History",
			style: GoogleFonts.montserrat
			(
				fontWeight: FontWeight.w600,
				color: Colors.black,
				fontSize: 18
			),
		);
	}

}