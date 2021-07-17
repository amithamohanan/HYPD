
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/API/Server.dart';
import 'package:hypd/Widgets/AddUserDetails.dart';
import 'package:hypd/Widgets/Influencer/InfluencerWatchVideo.dart';
import 'package:hypd/Widgets/Influencer/PendingVerification.dart';
import 'package:hypd/Widgets/Login.dart';
import 'package:hypd/Widgets/Utilities/Loader.dart';
import 'package:hypd/Widgets/Utilities/SnackBar.dart';
import 'package:hypd/Widgets/VerifyOtp.dart';
import 'package:hypd/global.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfluencerSignUp extends StatefulWidget
{
	@override
	_InfluencerSignUpState createState() => _InfluencerSignUpState();
}

class _InfluencerSignUpState extends State<InfluencerSignUp>
{
	final _formKeyRegister = GlobalKey<FormState>();

	TextEditingController emailField = new TextEditingController();
	TextEditingController passwordField = new TextEditingController();
	TextEditingController nameField = new TextEditingController();
	TextEditingController cityField = new TextEditingController();
	TextEditingController phoneField = new TextEditingController();
	TextEditingController facebookField = new TextEditingController();
	TextEditingController twitterField = new TextEditingController();
	TextEditingController youtubeField = new TextEditingController();
	TextEditingController instagramField = new TextEditingController();
	TextEditingController dobField = new TextEditingController(text: "");

	late VideoPlayerController _controller;

	bool isNewUser = false;

	var fontSize;
	var height;
	var width;

	@override
	void initState()
	{
		super.initState();
	}

	@override
	void dispose()
	{
		super.dispose();
		_controller.dispose();
	}

	@override
	Widget build(BuildContext context)
	{
		fontSize = getFontSize(context);
		height = getHeight(context);
		width = getWidth(context);

		return  SafeArea
		(
			top: false,
			child: Scaffold
			(
				appBar: AppBar(elevation: 4,),
				backgroundColor: Colors.white,
				resizeToAvoidBottomInset: true,
				body: register(context)
			)
		);
	}

	Widget register(context)
	{
		return SingleChildScrollView
		(
			child: Container
			(
				decoration: BoxDecoration
				(
					// color: Colors.grey[200],
					borderRadius: BorderRadius.circular(25)
				),
				margin: EdgeInsets.only(left: 20, right: 20, top: 10),
				padding: EdgeInsets.only(left: 10, right: 10),
				// color: Colors.white,
				child: Form
				(
					key: _formKeyRegister,
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.center,
						children:
						[
							SizedBox(height: 10),
							Container
							(
								height: 100,
								width: 100,
								child:  Image.asset("assets/images/logo.png", fit: BoxFit.cover)
							),
							SizedBox(height: 30),
							Center
							(
								child: 	Text
								(
									"Create new Account",
									style: GoogleFonts.montserrat
									(
										color: Colors.purple[900],
										fontSize: 20,
										fontWeight: FontWeight.bold
									),
								),
							),
							SizedBox(height: 40),
							// name
							Material
							(
								borderRadius: BorderRadius.circular(10),
								elevation: 4,
								color: Colors.white,
								shadowColor: Colors.purpleAccent,
								child: TextFormField
								(
									controller: nameField,
									keyboardType: TextInputType.name,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 15
									),
									decoration: InputDecoration
									(
										fillColor: Colors.white,
										prefixIcon: Icon(FontAwesomeIcons.user, size: 17, color: Colors.black38,),
										prefixIconConstraints: BoxConstraints
										(
											minWidth: 55,
											minHeight: 5,
										),
										// isDense: true,
										hintText: "NAME",
										hintStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w400,
											color: Colors.black45,
											fontSize: 12,
										),
										errorStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w300,
											color: Colors.black38,
											fontSize: 12
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									validator: (value)
									{
										if(value == null || value.isEmpty)
										{
											return "*Name cannot be empty";
										}
									},
									onSaved: (value) => nameField.text = value.toString(),
								),
							),
							SizedBox(height: 25),
							// phone
							Material
							(
								borderRadius: BorderRadius.circular(10),
								elevation: 4,
								color: Colors.white,
								shadowColor: Colors.purpleAccent,
							 	child: TextFormField
								(
									maxLength: 10,
									controller: phoneField,
									keyboardType: TextInputType.phone,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									decoration: InputDecoration
									(
										prefixIcon: Icon(FontAwesomeIcons.mobile, size: 17, color: Colors.black38,),
										prefixIconConstraints: BoxConstraints
										(
											minWidth: 45,
											minHeight: 5,
										),
										// isDense: true,
										hintText: "PHONE",
										hintStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w400,
											color: Colors.black38,
											fontSize: 12,
										),
										errorStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w300,
											color: Colors.black38,
											fontSize: 12
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									validator: (value)
									{
										if(value == null || value.isEmpty)
										{
											return "*Phone cannot be empty";
										}
									},
									onSaved: (value) => phoneField.text = value.toString(),
								),
							),
							SizedBox(height: 25),
							// email
							Material
							(
								borderRadius: BorderRadius.circular(10),
								elevation: 4,
								color: Colors.white,
								shadowColor: Colors.purpleAccent,
								child: TextFormField
								(
									controller: emailField,
									keyboardType: TextInputType.emailAddress,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									decoration: InputDecoration
									(
										prefixIcon: Icon(Icons.mail_outline, size: 20, color: Colors.black38,),
										prefixIconConstraints: BoxConstraints
										(
											minWidth: 45,
											minHeight: 5,
										),
										// isDense: true,
										hintText: "EMAIL",
										hintStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w400,
											color: Colors.black38,
											fontSize: 12,
										),
										errorStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w300,
											color: Colors.black38,
											fontSize: 12
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									validator: (value)
									{
										if(value == null || value.isEmpty)
										{
											return "*Email cannot be empty";
										}
									},
									onSaved: (value) => emailField.text = value.toString(),
								),
							),
							SizedBox(height: 25),
							// email
							Material
							(
								borderRadius: BorderRadius.circular(10),
								elevation: 4,
								color: Colors.white,
								shadowColor: Colors.purpleAccent,
								child: TextFormField
								(
									controller: passwordField,
									keyboardType: TextInputType.emailAddress,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									obscureText: true,
									decoration: InputDecoration
									(
										prefixIcon: Icon(Icons.lock, size: 20, color: Colors.black38,),
										prefixIconConstraints: BoxConstraints
										(
											minWidth: 45,
											minHeight: 5,
										),
										// isDense: true,
										hintText: "PASSWORD",
										hintStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w400,
											color: Colors.black38,
											fontSize: 12,
										),
										errorStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w300,
											color: Colors.black38,
											fontSize: 12
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									validator: (value)
									{
										if(value == null || value.isEmpty)
										{
											return "*Password cannot be empty";
										}
									},
									onSaved: (value) => passwordField.text = value.toString(),
								),
							),
							SizedBox(height: 25),
							// dob
							Material
							(
								borderRadius: BorderRadius.circular(10),
								elevation: 4,
								color: Colors.white,
								shadowColor: Colors.purpleAccent,
								child: TextFormField
								(
									controller: dobField,
									keyboardType: TextInputType.datetime,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									decoration: InputDecoration
									(
										prefixIcon: Icon(Icons.calendar_today, size: 20, color: Colors.black38,),
										prefixIconConstraints: BoxConstraints
										(
											minWidth: 45,
											minHeight: 5,
										),
										// isDense: true,
										hintText: "DATE OF BIRTH",
										hintStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w400,
											color: Colors.black38,
											fontSize: 12,
										),
										errorStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w300,
											color: Colors.black38,
											fontSize: 12
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									onTap: () async
									{
										FocusScope.of(context).requestFocus(new FocusNode());
											var date = await showDatePicker
											(
												context: context,
												initialDate: DateTime(2000),
												firstDate:DateTime(1970),
												lastDate: DateTime(2010)
											);
											var x = date.toString().split("-").join("/");
											var temp = x.split(" ");

											setState(()
											{
												dobField.text = temp[0].toString();
											});
									},
									validator: (value)
									{
										if(value == null || value.isEmpty)
										{
											return "*Date of birth cannot be empty";
										}
									},
									onSaved: (value) => dobField.text = value.toString(),
								)
							),
							SizedBox(height: 25),
							// city
							Material
							(
								borderRadius: BorderRadius.circular(10),
								elevation: 4,
								color: Colors.white,
								shadowColor: Colors.purpleAccent,
								child: TextFormField
								(
									controller: cityField,
									keyboardType: TextInputType.streetAddress,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									decoration: InputDecoration
									(
										prefixIcon: Icon(Icons.location_city, size: 20, color: Colors.black38,),
										prefixIconConstraints: BoxConstraints
										(
											minWidth: 45,
											minHeight: 5,
										),
										// isDense: true,
										hintText: "CITY",
										hintStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w400,
											color: Colors.black38,
											fontSize: 12,
										),
										errorStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w300,
											color: Colors.black38,
											fontSize: 12
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									validator: (value)
									{
										if(value == null || value.isEmpty)
										{
											return "*City cannot be empty";
										}
									},
									onSaved: (value) => cityField.text = value.toString(),
								)
							),
							SizedBox(height: 25),
							// facebook
							Material
							(
								borderRadius: BorderRadius.circular(10),
								elevation: 4,
								color: Colors.white,
								shadowColor: Colors.purpleAccent,
								child: TextFormField
								(
									controller: facebookField,
									keyboardType: TextInputType.url,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									decoration: InputDecoration
									(
										prefixIcon: Icon(FontAwesomeIcons.facebook, size: 17, color: Colors.black38,),
										prefixIconConstraints: BoxConstraints
										(
											minWidth: 45,
											minHeight: 5,
										),
										// isDense: true,
										hintText: "FACEBOOK LINK",
										hintStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w400,
											color: Colors.black38,
											fontSize: 12,
										),
										errorStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w300,
											color: Colors.black38,
											fontSize: 12
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									validator: (value)
									{
										if(value == null || value.isEmpty)
										{
											return "*Link cannot be empty";
										}
									},
									onSaved: (value) => facebookField.text = value.toString(),
								)
							),
							SizedBox(height: 25),
							// you tube
							Material
							(
								borderRadius: BorderRadius.circular(10),
								elevation: 4,
								color: Colors.white,
								shadowColor: Colors.purpleAccent,
								child: TextFormField
								(
									controller: youtubeField,
									keyboardType: TextInputType.url,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									decoration: InputDecoration
									(
										prefixIcon: Icon(FontAwesomeIcons.youtube, size: 17, color: Colors.black38,),
										prefixIconConstraints: BoxConstraints
										(
											minWidth: 45,
											minHeight: 5,
										),
										// isDense: true,
										hintText: "YOUTUBE LINK",
										hintStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w400,
											color: Colors.black38,
											fontSize: 12,
										),
										errorStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w300,
											color: Colors.black38,
											fontSize: 12
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									validator: (value)
									{
										if(value == null || value.isEmpty)
										{
											return "Link cannot be empty";
										}
									},
									onSaved: (value) => youtubeField.text = value.toString(),
								),
							),
							SizedBox(height: 25),
							Material
							(
								borderRadius: BorderRadius.circular(10),
								elevation: 4,
								color: Colors.white,
								shadowColor: Colors.purpleAccent,
								child: TextFormField
								(
									controller: instagramField,
									keyboardType: TextInputType.url,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									decoration: InputDecoration
									(
										prefixIcon: Icon(FontAwesomeIcons.instagram, size: 17, color: Colors.black38,),
										prefixIconConstraints: BoxConstraints
										(
											minWidth: 45,
											minHeight: 5,
										),
										// isDense: true,
										hintText: "INSTAGRAM LINK",
										hintStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w400,
											color: Colors.black38,
											fontSize: 12,
										),
										errorStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w300,
											color: Colors.black38,
											fontSize: 12
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									validator: (value)
									{
										if(value == null || value.isEmpty)
										{
											return "Link cannot be empty";
										}
									},
									onSaved: (value) => instagramField.text = value.toString(),
								),
							),
							SizedBox(height: 25),
							Material
							(
								borderRadius: BorderRadius.circular(10),
								elevation: 4,
								color: Colors.white,
								shadowColor: Colors.purpleAccent,
								child: TextFormField
								(
									controller: twitterField,
									keyboardType: TextInputType.url,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									decoration: InputDecoration
									(
										prefixIcon: Icon(FontAwesomeIcons.twitter, size: 17, color: Colors.black38,),
										prefixIconConstraints: BoxConstraints
										(
											minWidth: 45,
											minHeight: 5,
										),
										// isDense: true,
										hintText: "TWITTER LINK",
										hintStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w400,
											color: Colors.black38,
											fontSize: 12,
										),
										errorStyle: GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w300,
											color: Colors.black38,
											fontSize: 12
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									validator: (value)
									{
										if(value == null || value.isEmpty)
										{
											return "Link cannot be empty";
										}
									},
									onSaved: (value) => twitterField.text = value.toString(),
								),
							),
							SizedBox(height: 40),
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
											"Sign Up",
											style: GoogleFonts.montserrat(fontSize: fontSize / 20,)
										),
										style: ButtonStyle
										(
											foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
											backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xff674094"))),
											shape: MaterialStateProperty.all<RoundedRectangleBorder>
											(
												RoundedRectangleBorder
												(
													borderRadius: BorderRadius.circular(25.5),
													side: BorderSide(color: Colors.white38)
												)
											)
										),
										onPressed: ()
										{
											if (_formKeyRegister.currentState!.validate())
											{
												popup(context);

												signUp(nameField.text, phoneField.text, emailField.text, passwordField.text, dobField.text, cityField.text, facebookField.text, youtubeField.text, instagramField.text, twitterField.text);

												// Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTP()));
											}
										}
									)
								)
							),
							SizedBox(height: 10),
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
														color: Colors.purple[900],
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
							SizedBox(height: 30),
						],
					),
				)
			),
		);
	}

	signUp(name, phone, email, password, dob, city, facebookLink, youtubeLink, instaLink, twitterLink) async
	{
		var response = await Server.influencerRegistration(name, email, phone, dob, city, facebookLink, youtubeLink, instaLink, twitterLink, password);

		if(response == false)
		{
			showPopup("error", "Already Registered", context);
		}
		else
		{
			var userData = await Server.loginWithEmail(email, password);

			print(userData);

			if(userData == false)
			{
				Navigator.pop(context);
				showPopup("error", "Error in Login", context);
			}
			else
			{
				setState(()
				{
					isInfluencer = true;
				});

				user["id"] = userData[0]["id"];
				user["token"] = userData[0]["remember_token"];
				user["name"] = userData[0]["name"];
				user["email"] = userData[0]["email"];
				user["phone"] = userData[0]["phone"];
				user["dob"] = userData[0]["dob"];
				user["image"] = userData[0]["image"];
				user["isLoggedIn"]  = true;
				user["gender"]  = userData[0]["gender"];

				// saveLocally();
				// showSnackBar(context, "Registered Successfully");
				Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserDetails()));
			}
		}
	}

	saveLocally() async
	{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		await prefs.setString('isLoggesIn', jsonEncode(user.toString()));
	}
}