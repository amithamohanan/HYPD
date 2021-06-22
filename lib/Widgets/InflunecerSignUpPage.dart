
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/Influencer/PendingVerification.dart';
import 'package:hypd/Widgets/Utilities/SnackBar.dart';
import 'package:hypd/Widgets/VerifyOtp.dart';
import 'package:hypd/global.dart';
import 'package:video_player/video_player.dart';

class InfluencerSignUp extends StatefulWidget 
{
	@override
	_InfluencerSignUpState createState() => _InfluencerSignUpState();
}

class _InfluencerSignUpState extends State<InfluencerSignUp> 
{
	final _formKeyRegister = GlobalKey<FormState>();

	TextEditingController emailField = new TextEditingController();
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
				margin: EdgeInsets.only(left: 20, right: 20, top: 50),
				color: Colors.white,
				child: Form
				(
					key: _formKeyRegister,
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children:
						[
							SizedBox(height: 35),
							Text
							(
								"Sign up as Influencer",
								style: GoogleFonts.montserrat
								(
									color: Colors.black,
									fontSize: 20,
									fontWeight: FontWeight.bold
								),
							),
							SizedBox(height: 20),
							// name
							TextFormField
							(
								controller: nameField,
								keyboardType: TextInputType.name,
								style:  GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
									fontSize: 12
								),
								decoration: InputDecoration
								(
									prefixIcon: Icon(FontAwesomeIcons.user, size: 15, color: Colors.black38,),
									prefixIconConstraints: BoxConstraints
									(
										minWidth: 25,
										minHeight: 5,
									),
									isDense: true,
									hintText: "Full Name",
									hintStyle: GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w300,
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
										return "*Name cannot be empty";
									}
								},
								onSaved: (value) => nameField.text = value.toString(),
							),
							SizedBox(height: 40),
							// phone
							TextFormField
							(
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
									prefixIcon: Icon(FontAwesomeIcons.phone, size: 15, color: Colors.black38,),
									prefixIconConstraints: BoxConstraints
									(
										minWidth: 25,
										minHeight: 5,
									),
									isDense: true,
									hintText: "Phone",
									hintStyle: GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w300,
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
							SizedBox(height: 40),
							// email
							TextFormField
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
									prefixIcon: Icon(Icons.mail_outline, size: 15, color: Colors.black38,),
									prefixIconConstraints: BoxConstraints
									(
										minWidth: 25,
										minHeight: 5,
									),
									isDense: true,
									hintText: "Email",
									hintStyle: GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w300,
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
							SizedBox(height: 40),
							// dob
							TextFormField
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
									prefixIcon: Icon(Icons.calendar_today, size: 15, color: Colors.black38,),
									prefixIconConstraints: BoxConstraints
									(
										minWidth: 25,
										minHeight: 5,
									),
									isDense: true,
									hintText: "Date of birth",
									hintStyle: GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w300,
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
										return "*Date of birth cannot be empty";
									}
								},
								onSaved: (value) => dobField.text = value.toString(),
							),
							SizedBox(height: 40),
							// city
							TextFormField
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
									prefixIcon: Icon(Icons.location_city, size: 15, color: Colors.black38,),
									prefixIconConstraints: BoxConstraints
									(
										minWidth: 25,
										minHeight: 5,
									),
									isDense: true,
									hintText: "City",
									hintStyle: GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w300,
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
							),
							SizedBox(height: 40),
							// facebook
							TextFormField
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
									prefixIcon: Icon(FontAwesomeIcons.facebook, size: 15, color: Colors.black38,),
									prefixIconConstraints: BoxConstraints
									(
										minWidth: 25,
										minHeight: 5,
									),
									isDense: true,
									hintText: "Facebook link",
									hintStyle: GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w300,
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
							),
							SizedBox(height: 40),
							// you tube
							TextFormField
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
									prefixIcon: Icon(FontAwesomeIcons.youtube, size: 15, color: Colors.black38,),
									prefixIconConstraints: BoxConstraints
									(
										minWidth: 25,
										minHeight: 5,
									),
									isDense: true,
									hintText: "Youtube link",
									hintStyle: GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w300,
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
							SizedBox(height: 40),
							TextFormField
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
									prefixIcon: Icon(FontAwesomeIcons.instagram, size: 15, color: Colors.black38,),
									prefixIconConstraints: BoxConstraints
									(
										minWidth: 25,
										minHeight: 5,
									),
									isDense: true,
									hintText: "Instagram link",
									hintStyle: GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w300,
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
							SizedBox(height: 40),
							TextFormField
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
									prefixIcon: Icon(FontAwesomeIcons.twitter, size: 15, color: Colors.black38,),
									prefixIconConstraints: BoxConstraints
									(
										minWidth: 25,
										minHeight: 5,
									),
									isDense: true,
									hintText: "Twitter link",
									hintStyle: GoogleFonts.montserrat
									(
										fontWeight: FontWeight.w300,
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
											"Register",
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
													borderRadius: BorderRadius.circular(20.5),
													side: BorderSide(color: Colors.white38)
												)
											)
										),
										onPressed: ()
										{
											// if (_formKeyRegister.currentState!.validate()) 
											// {
											// 	showSnackBar(context, "OTP send, please check your phone");
												// Navigator.push(context, MaterialPageRoute(builder: (context) => PendingVerification()));
												Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTP()));
											// }
										}
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
										setState(() 
										{
											isNewUser = false;
										});
									},
								)
							),
							SizedBox(height: 10,),
						],
					),
				)
			),
		);
	}
}