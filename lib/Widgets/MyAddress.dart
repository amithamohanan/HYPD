import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAddress extends StatefulWidget
{
	@override
	_MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress>
{
	var height;
	var width;

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return  SafeArea
		(
			top: false,
			child: Scaffold
			(
				resizeToAvoidBottomInset: false,
				backgroundColor: Colors.white,
				body: Container
				(
					padding: EdgeInsets.all(25),
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.center,
						children: 
						[
							SizedBox(height: height / 25,),
							closeButton(),
							locationImage(),
							SizedBox(height: height / 25,),
							mainText(),
							SizedBox(height: height / 35,),
							subText(),
							SizedBox(height: height / 10,),
							addAddrssButton()
						],
					),
				),
			)
		);
	}

	Widget closeButton()
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.end,
			children: 
			[
				Container
				(
					margin: EdgeInsets.only(top: 5),
					padding: EdgeInsets.all(5),
					decoration: BoxDecoration
					(
						color: Color(int.parse("0xfff2f2f0")),
						borderRadius: BorderRadius.circular(20)
					),
					height: 45,
					width: 45,
					child: FittedBox
					(
						child: IconButton
						(
							onPressed: ()
							{
								Navigator.pop(context);
							},
							icon: Icon(Icons.close),
							color: Colors.black,
						),
					),
				)
			],
		);
	}

	Widget locationImage()
	{
		return Container
		(
			height: height / 4,
			width: width / 2,
			child: Center
			(
				child: Image.asset("assets/images/home-location.gif"),
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
					"You don't have any saved addresses",
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
					"We 're waiting for your address",
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


	addAddrssButton()
	{
		return GestureDetector
		(
			child: Container
			(
				padding: EdgeInsets.only(left: 25, right: 25),
				width: width,
				height: height / 15,
				child: DottedBorder
				(
					color: Color(int.parse("0xff674094")),
					borderType: BorderType.RRect,
					radius: Radius.circular(12),
					padding: EdgeInsets.all(6),
					child: ClipRRect
					(
						borderRadius: BorderRadius.all(Radius.circular(12)),
						child: Container
						(
							child: Center
							(
								child: Text
								(
									"Add New Address",
									style: GoogleFonts.montserrat
									(
										color: Color(int.parse("0xff674094")),
										fontWeight: FontWeight.bold,
										fontSize: 18
									),
								),
							)
						),
					),
				)
			),
			onTap: ()
			{
				addAddress(context);
			},
		);
	}

	addAddress(context)
	{
		return showModalBottomSheet
		(	
			isScrollControlled: true,
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
			context: context,
			builder: (BuildContext context) 
			{
    			return Padding
				(
        			padding: MediaQuery.of(context).viewInsets,
					child: Container
					(
						decoration: BoxDecoration
						(
							borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
						),
						child: SingleChildScrollView
						(
							child: Column
							(
								mainAxisSize: MainAxisSize.min,
								children: 
								[
									topButton(),
									SizedBox(height: height / 25,),
									title(),
									SizedBox(height: height / 25,),
									address1(),
									SizedBox(height: height / 25,),
									address2(),
									SizedBox(height: height / 25,),
									address3(),
									SizedBox(height: height / 25,),
									address4(),
									SizedBox(height: height / 25,),
									address5(),
									SizedBox(height: height / 20,),
									submitButton()
								],
							)
						)
					)
				);
			}
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
			"Add New Address",
			style: GoogleFonts.montserrat
			(
				fontWeight: FontWeight.w500,
				color: Colors.black,
				fontSize: 18
			),
		);
	}

	address1()
	{
		return Container
		(
			margin: EdgeInsets.only(left: 25, right: 25),
			child: Row
			(
				children: 
				[
					Expanded
					(
						child: TextFormField
						(
							style:  GoogleFonts.montserrat
							(
								fontWeight: FontWeight.bold,
								color: Colors.black,
								fontSize: 12
							),
							decoration: InputDecoration
							(
								labelText: "Pin Code",
								labelStyle: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.w300,
									color: Colors.black38,
									fontSize: 12
								),
								counterText: "",
								contentPadding: EdgeInsets.all(0),
								isDense: true,
								enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
							),
						),
					),
					SizedBox(width: 25),
					Expanded
					(
						child: TextFormField
						(
							style:  GoogleFonts.montserrat
							(
								fontWeight: FontWeight.bold,
								color: Colors.black,
								fontSize: 12
							),
							decoration: InputDecoration
							(
								labelText: "State",
								labelStyle: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.w300,
									color: Colors.black38,
									fontSize: 12
								),
								counterText: "",
								contentPadding: EdgeInsets.all(0),
								isDense: true,
								enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
							),
						),
					)
				],
			)
		);
	}

	address2()
	{
		return Container
		(
			margin: EdgeInsets.only(left: 25, right: 25),
			child: Row
			(
				children: 
				[
					Expanded
					(
						child: TextFormField
						(
							style:  GoogleFonts.montserrat
							(
								fontWeight: FontWeight.bold,
								color: Colors.black,
								fontSize: 12
							),
							decoration: InputDecoration
							(
								labelText: "Contact Number",
								labelStyle: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.w300,
									color: Colors.black38,
									fontSize: 12
								),
								counterText: "",
								contentPadding: EdgeInsets.all(0),
								isDense: true,
								enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
							),
						),
					),
				],
			)
		);
	}

	address3()
	{
		return Container
		(
			margin: EdgeInsets.only(left: 25, right: 25),
			child: Row
			(
				children: 
				[
					Expanded
					(
						child: TextFormField
						(
							style:  GoogleFonts.montserrat
							(
								fontWeight: FontWeight.bold,
								color: Colors.black,
								fontSize: 12
							),
							decoration: InputDecoration
							(
								labelText: "Address (Hosue No., Building, Street, Area)",
								labelStyle: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.w300,
									color: Colors.black38,
									fontSize: 12
								),
								counterText: "",
								contentPadding: EdgeInsets.all(0),
								isDense: true,
								enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
							),
						),
					),
				],
			)
		);
	}

	address4()
	{
		return Container
		(
			margin: EdgeInsets.only(left: 25, right: 25),
			child: Row
			(
				children: 
				[
					Expanded
					(
						child: TextFormField
						(
							style:  GoogleFonts.montserrat
							(
								fontWeight: FontWeight.bold,
								color: Colors.black,
								fontSize: 12
							),
							decoration: InputDecoration
							(
								labelText: "Address line 2 (Optional)",
								labelStyle: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.w300,
									color: Colors.black38,
									fontSize: 12
								),
								counterText: "",
								contentPadding: EdgeInsets.all(0),
								isDense: true,
								enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
							),
						),
					),
				],
			)
		);
	}

	address5()
	{
		return Container
		(
			margin: EdgeInsets.only(left: 25, right: 25),
			child: Row
			(
				children: 
				[
					Expanded
					(
						child: TextFormField
						(
							style:  GoogleFonts.montserrat
							(
								fontWeight: FontWeight.bold,
								color: Colors.black,
								fontSize: 12
							),
							decoration: InputDecoration
							(
								labelText: "Locality",
								labelStyle: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.w300,
									color: Colors.black38,
									fontSize: 12
								),
								counterText: "",
								contentPadding: EdgeInsets.all(0),
								isDense: true,
								enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
							),
						),
					),
					SizedBox(width: 25),
					Expanded
					(
						child: TextFormField
						(
							style:  GoogleFonts.montserrat
							(
								fontWeight: FontWeight.bold,
								color: Colors.black,
								fontSize: 12
							),
							decoration: InputDecoration
							(
								labelText: "District",
								labelStyle: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.w300,
									color: Colors.black38,
									fontSize: 12
								),
								counterText: "",
								contentPadding: EdgeInsets.all(0),
								isDense: true,
								enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
							),
						),
					),
				],
			)
		);
	}

	submitButton()
	{
		return  Container
		(

			margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
			height: MediaQuery.of(context).size.height / 15,
			width: double.infinity,
			child: ElevatedButton
			(
				child: Text
				(
					"Submit",
					style: TextStyle(fontSize: 14)
				),
				style: ButtonStyle
				(
					foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
					backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xff674094"))),
					shape: MaterialStateProperty.all<RoundedRectangleBorder>
					(
						RoundedRectangleBorder
						(
							borderRadius: BorderRadius.circular(10.5),
							side: BorderSide(color: Colors.white38)
						)
					)
				),
				onPressed: ()
				{
					// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
				}
			)
		);
	}
}