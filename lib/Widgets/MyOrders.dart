import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrders extends StatefulWidget
{
	@override
	_MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
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
			body: Container
			(
				margin: EdgeInsets.only(top: 50, left: 10, right: 10),
				child: Column
				(
					children:
					[
						closeButton(),
						SizedBox(height: height / 20,),
						titleText()
					],
				),
			),
		);
	}

	Widget closeButton()
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children:
			[
				Container
				(
					margin: EdgeInsets.all(5),
					height: 45,
					width: 45,
					decoration: BoxDecoration
					(
						color: Colors.black12,
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
				Row
				(
					mainAxisAlignment: MainAxisAlignment.end,
					children: 
					[
						Container
						(
							margin: EdgeInsets.all(5),
							height: 45,
							width: 45,
							decoration: BoxDecoration
							(
								color: Colors.black12,
								borderRadius: BorderRadius.circular(15)
							),
							child: FittedBox
							(
								child:  IconButton
								(
									onPressed: ()=>null,
									icon: Icon(Icons.favorite_border),
									color: Colors.black,
								),
							)
						),
						Container
						(
							margin: EdgeInsets.all(5),
							height: 45,
							width: 45,
							decoration: BoxDecoration
							(
								color: Colors.black12,
								borderRadius: BorderRadius.circular(15)
							),
							child: FittedBox
							(
								child: IconButton
								(
									onPressed: ()=>null,
									icon: Icon(Icons.shopping_bag_outlined),
									color: Colors.black,
								)
							)
						)
					],
				)
			],
		);
	}

	titleText()
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.center,
			children :
			[
				Text
				(
					"My Orders",
					style: GoogleFonts.montserrat
					(
						fontWeight: FontWeight.w400,
						color: Colors.black,
						fontSize: 25
					),
				),
			]
		);
	}

}