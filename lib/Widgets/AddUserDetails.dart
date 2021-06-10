import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/HomePage.dart';
import 'package:hypd/global.dart';

class AddUserDetails extends StatefulWidget
{
	@override
	_AddUserDetailsState createState() => _AddUserDetailsState();
}

class _AddUserDetailsState extends State<AddUserDetails>
{
	var height;
	var width;
	var fontSize;

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return SafeArea
		(
			top: false,
			child: scaffold()
		);
	}

	Widget scaffold()
	{
		fontSize = getFontSize(context);
		height = getHeight(context);
		width = getWidth(context);

		return Scaffold
		(
			body: Container
			(
				padding: EdgeInsets.all(25),
				height: height,
				width: width,
				child: SingleChildScrollView
				(
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children:
						[
							SizedBox(height: height / 15,),
							profileText(),
							SizedBox(height: height / 15,),
							details1(),
							details2(),
							SizedBox(height: height / 22,),
							imageUpload(),
							SizedBox(height: height / 15,),
							textFormField(),
							// SizedBox(height: height / 15,),
							// submitButton()
						],
					)
				),
			),
		);
	}

	Widget profileText()
	{
		return Text
		(
			"Your Profile",
			style: GoogleFonts.montserrat
			(
				fontSize: fontSize / 20,
			),
		);
	}

	Widget details1()
	{
		return Text
		(
			"Enter the following details and",
			style: GoogleFonts.montserrat
			(
				fontSize: fontSize / 35,
				color: Colors.black38
			),
		);
	}

	Widget details2()
	{
		return Text
		(
			"get connected...",
			style: GoogleFonts.montserrat
			(
				fontSize: fontSize / 35,
				color: Colors.black38
			),
		);
	}

	Widget imageUpload()
	{
		return Stack
		(
			children:
			[
				Container
				(
					height: 100,
					width: 100,
					child: Container
					(
						margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
						height: 50,
						width: 60,
						decoration: BoxDecoration
						(
							color: Colors.black,
							borderRadius: BorderRadius.circular(25)
						),
					),
				),
				Positioned
				(
					bottom: 3,
					right: 0,
					child: CircleAvatar
					(
						backgroundColor: Color(int.parse("0xffEF5C99")),
						child: IconButton
						(
							color: Colors.white,
							onPressed: ()
							{

							},
							icon: Icon(Icons.camera_alt)
						)
					)
				)
			],
		);
	}

	Widget textFormField()
	{
		return Column
		(
			crossAxisAlignment: CrossAxisAlignment.start,
			children:
			[
				Text
				(
					"Your Full Name",
					style: GoogleFonts.montserrat
					(
						color: Colors.black38,
						fontSize: 12,
					),
				),
				SizedBox(height: height / 25,),
				TextFormField
				(
					style:  GoogleFonts.montserrat
					(
						fontWeight: FontWeight.bold,
						color: Colors.black,
						fontSize: 12
					),
					decoration: InputDecoration
					(
						counterText: "",
						contentPadding: EdgeInsets.all(0),
						isDense: true,
						enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
						focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
					),
				),
				SizedBox(height: height / 15,),
				Text
				(
					"Phone Number",
					style: GoogleFonts.montserrat
					(
						color: Colors.black38,
						fontSize: 12,
					),
				),
				SizedBox(height: height / 25,),
				TextFormField
				(
					style:  GoogleFonts.montserrat
					(
						fontWeight: FontWeight.bold,
						color: Colors.black,
						fontSize: 12
					),
					decoration: InputDecoration
					(
						hintStyle:  GoogleFonts.montserrat
						(
							color: Colors.grey,
							fontSize: 12
						),
						counterText: "",
						contentPadding: EdgeInsets.all(0),
						isDense: true,
						enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
						focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
					),
				),
				SizedBox(height: height / 15,),
				Text
				(
					"Email",
					style: GoogleFonts.montserrat
					(
						color: Colors.black38,
						fontSize: 12,
					),
				),
				SizedBox(height: height / 25,),
				TextFormField
				(
					style:  GoogleFonts.montserrat
					(
						fontWeight: FontWeight.bold,
						color: Colors.black,
						fontSize: 12
					),
					decoration: InputDecoration
					(
						hintStyle:  GoogleFonts.montserrat
						(
							color: Colors.grey,
							fontSize: 12
						),
						counterText: "",
						contentPadding: EdgeInsets.all(0),
						isDense: true,
						enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
						focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
					),
				),
				SizedBox(height: height / 25,),
				Text
				(
					"Date of birth",
					style: GoogleFonts.montserrat
					(
						color: Colors.black38,
						fontSize: 12,
					),
				),
				SizedBox(height: height / 25,),
				Row
				(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children:
					[
						Container
						(
							height: 25,
							width: 25,
							child: TextFormField
							(
								keyboardType: TextInputType.number,
								maxLength: 2,
								style:  GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
									fontSize: 12
								),
								decoration: InputDecoration
								(
									hintText: "DD",
									hintStyle:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w500,
										color: Colors.black26,
										fontSize: fontSize / 35
									),
									counterText: "",
									contentPadding: EdgeInsets.all(0),
									isDense: true,
									enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								),
							),
						),
						SizedBox(width: 5,),
						Container
						(
							height: 25,
							width: 25,
							child: TextFormField
							(
								keyboardType: TextInputType.number,
								maxLength: 2,
								style:  GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
									fontSize: 12
								),
								decoration: InputDecoration
								(
									hintText: "MM",
									hintStyle:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w500,
										color: Colors.black26,
										fontSize: fontSize / 35
									),
									counterText: "",
									contentPadding: EdgeInsets.all(0),
									isDense: true,
									enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								),
							),
						),
						SizedBox(width: 5,),
						Container
						(
							height: 25,
							width: 40,
							child: TextFormField
							(
								keyboardType: TextInputType.number,
								maxLength: 4,
								style:  GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
									fontSize: 12
								),
								decoration: InputDecoration
								(
									hintText: "YYYY",
									hintStyle:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w500,
										color: Colors.black26,
										fontSize: fontSize / 35
									),
									counterText: "",
									contentPadding: EdgeInsets.all(0),
									isDense: true,
									enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								),
							),
						),
						SizedBox(width: width / 3),
						Container
						(
							child: IconButton
							(
								color: Colors.black12,
								icon: Icon(Icons.calendar_today_outlined),
								onPressed: () async
								{
									// DateTime date = DateTime.now();
									FocusScope.of(context).requestFocus(new FocusNode());
									var date = await showDatePicker
									(
										context: context,
										initialDate:DateTime.now(),
										firstDate:DateTime(1900),
										lastDate: DateTime(2100)
									);
									// DateFormat formatter = DateFormat('dd-MM-yyyy');
									// dobController.text = formatter.format(date);
								},
							),
						)
					],
				),
				SizedBox(height: height / 25,),
				Text
				(
					"Gender",
					style: GoogleFonts.montserrat
					(
						color: Colors.black38,
						fontSize: fontSize / 30
					),
				),
				Row
				(
					mainAxisAlignment: MainAxisAlignment.spaceBetween	,
					children:
					[
						OutlinedButton
						(
							child: Text
							(
								"Male",
								style: GoogleFonts.montserrat
								(
									fontSize: fontSize / 30,
									color: Colors.black26
								),
							),
							onPressed: ()
							{

							}
						),
						OutlinedButton
						(
							child: Text
							(
								"Female",
								style: GoogleFonts.montserrat
								(
									fontSize: fontSize / 30,
									color: Colors.black26
								),
							),
							onPressed: ()
							{

							}
						),
						OutlinedButton
						(
							child: Text
							(
								"Other",
								style: GoogleFonts.montserrat
								(
									fontSize: fontSize / 35,
									color: Colors.black26
								),
							),
							onPressed: ()
							{

							}
						)
					],
				),
				SizedBox(height: height / 15,),
				Container
				(
					height: MediaQuery.of(context).size.height / 12,
					width: double.infinity,
					child: ElevatedButton
					(
						child: Text
						(
							"Submit",
							style: TextStyle(fontSize: fontSize / 23)
						),
						style: ButtonStyle
						(
							foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
							backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xff674094"))),
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
							Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
						}
					)
				),
				SizedBox(height: 10),
			],
		);
	}
}