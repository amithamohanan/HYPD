import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/Login.dart';
import 'package:hypd/global.dart';

class Register extends StatefulWidget
{
	@override
	_RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
{
	TextEditingController dobController = new TextEditingController();

	var height;
	var width;
	var fontSize;

	@override
	Widget build(BuildContext context)
	{
		height = getHeight(context);
		width = getWidth(context);
		fontSize = getFontSize(context);

		return Positioned
		(
			right: width/ 40,
			left: width / 40,
			bottom: 20,
			child: Container
			(
				padding: EdgeInsets.fromLTRB(25, 25, 25, 5),
				decoration: BoxDecoration
				(
					color: Colors.white,
					borderRadius: BorderRadius.circular(40.0)
				),
				child: Form
				(
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children:
						[
							Text
							(
								"Create Account",
								style: GoogleFonts.montserrat
								(
									color: Colors.black,
									fontSize: 20,
									fontWeight: FontWeight.bold
								),
							),
							SizedBox(height: 25,),
							Text
							(
								"Email",
								style: GoogleFonts.montserrat
								(
									color: Colors.black38,
									fontSize: fontSize / 30,
								),
							),
							TextFormField
							(
								decoration: InputDecoration
								(
									hintStyle:  GoogleFonts.montserrat
									(
										color: Colors.grey,
										fontSize: fontSize / 30,
									),
									counterText: "",
									contentPadding: EdgeInsets.all(0),
									isDense: true,
									enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								),
							),
							SizedBox(height: 25,),
							Text
							(
								"Phone",
								style: GoogleFonts.montserrat
								(
									color: Colors.black38,
									fontSize: fontSize / 30,
								),
							),
							TextFormField
							(
								decoration: InputDecoration
								(
									hintStyle:  GoogleFonts.montserrat
									(
										color: Colors.grey,
										fontSize: fontSize / 30,
									),
									counterText: "",
									contentPadding: EdgeInsets.all(0),
									isDense: true,
									enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								)
							),
							SizedBox(height: 25,),
							Text
							(
								"Date of Birth",
								style: GoogleFonts.montserrat
								(
									color: Colors.black38,
									fontSize: fontSize / 30,
								),
							),
							TextFormField
							(
								decoration: InputDecoration
								(
									hintStyle:  GoogleFonts.montserrat
									(
										color: Colors.grey,
										fontSize: fontSize / 30,
									),
									counterText: "",
									contentPadding: EdgeInsets.all(0),
									isDense: true,
									enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								),
								onTap: () async
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
							SizedBox(height: 30,),
							Center
							(
								child: Container
								(
									height: height / 11,
									width: double.infinity,
									child: ElevatedButton
									(
										child: Text
										(
											"Register",
											style: GoogleFonts.montserrat(fontSize: fontSize / 20,)
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
							),
							SizedBox(height: 10,),
							Container
							(
								width: double.infinity,
								child: GestureDetector
								(
									child: RichText
									(
										textAlign: TextAlign.center,
										text: TextSpan
										(
											text: "Already have an account? ",
											style: GoogleFonts.montserrat(color: Colors.grey, fontSize: fontSize / 30,), /*defining default style is optional */
											children:
											[
												TextSpan
												(
													text: "Log In",
													style: GoogleFonts.montserrat
													(
														color: Colors.black,
														fontWeight: FontWeight.bold
													)
												),
											],
										),
									),
									onTap: ()
									{
										Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
									},
								)
							),
							SizedBox(height: 10,),
						],
					),
				),
			)
		);
	}
}