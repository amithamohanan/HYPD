
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/HomePage.dart';
import 'package:hypd/Widgets/Register.dart';
import 'package:hypd/Widgets/VerifyOtp.dart';
import 'package:hypd/global.dart';
import 'package:video_player/video_player.dart';

class Login extends StatefulWidget 
{
	@override
	_LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> 
{

	late VideoPlayerController _controller;

	bool isNewUser = false;

	var fontSize;
	var height;
	var width;

	@override
	void initState()
	{
		_controller = VideoPlayerController.asset("assets/images/introPlayer.mp4");
		_controller.initialize();
		_controller.play();
		_controller.setLooping(true);
		super.initState();

	}

	@override
	void dispose()
	{
		_controller.dispose();
		super.dispose();
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
				resizeToAvoidBottomInset: true,
				body:  Stack
				(
					children: <Widget>
					[
						videoPlayer(),
						isNewUser ? Register() : skipText(),
						!isNewUser ? Positioned
						(
							left: width / 30,
							right: width / 30,
							bottom: 0,
							child: Container
							(
								width: width,
								height: height / 1.6,
								child: Column
								(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: 
									[
										loginText(),
										Expanded(child: SizedBox(height: 30,),),
										socialMediaIcons(),
										Expanded(child: SizedBox(height: 30,),),
										formField(),
										Expanded(child: SizedBox(height: 30,),),
									],
								),
							)
						): SizedBox.shrink()
					],
				),
			)
		);
	}

	// player
	Widget videoPlayer()
	{
		return Container
		(
			height: height,
			width: width,
			child: VideoPlayer(_controller));
	}

	// skip text
	Widget skipText()
	{
		return Positioned
		(
			top: height / 20, 
			right: width / 30, 
			child: GestureDetector
			(
				child: Text
				(
					"Skip",
					style: GoogleFonts.montserrat
					(
						fontSize: fontSize / 20,
						color: Colors.white,
						decoration: TextDecoration.underline,
					),
				),
				onTap: ()
				{
					Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
				},
			)
		);
	}

	Widget loginText()
	{
		return  Text
		(
			"Log in with Social Media",
			style: GoogleFonts.montserrat
			(
				color: Colors.white,
				fontSize: fontSize / 20,
				fontWeight: FontWeight.w300
			)
		);
	}

	Widget socialMediaIcons()
	{
		return Row
		(
			children: 
			[
				facebookLogin(),
				SizedBox(width: 10,),
				googleLogin(),
				SizedBox(width: 10,),
				Text
				(
					"OR",
					style: GoogleFonts.montserrat
					(
						color: Colors.white,
						fontSize: 12,
						fontWeight: FontWeight.w300,
					),
				),
				SizedBox(width: 10,),
				Container
				(
					height: MediaQuery.of(context).size.height / 50,
					width: MediaQuery.of(context).size.width / 2.7,
					// width: 75,
					child: Divider
					(
						color: Colors.white,
						thickness: 0.6,
					),
				)
			],
		);
	}

	// facebook login
	facebookLogin()
	{
		return GestureDetector
		(
			child: Image.asset("assets/images/Facebook_icon.png"),
		);
	}

	// google login
	googleLogin()
	{
		return GestureDetector
		(
			child: Image.asset("assets/images/Google_icon.png"),
		);
	}

	formField()
	{
		return Container
		(
			padding: EdgeInsets.only(left: 25, right: 25, top: 25),
			decoration: BoxDecoration
			(
				color: Colors.white,
				borderRadius: BorderRadius.circular(40.0)
			),
			height:  height * 0.45,
			width:  width,
			child: Form
			(
				child: Column
				(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: 
					[
						 Text
						(
							"Log in to Continue",
							style: GoogleFonts.montserrat
							(
								color: Colors.black,
								fontSize: fontSize / 20,
								fontWeight: FontWeight.bold
							),
						),
						SizedBox(height: height / 30,),
						Text
							(
								"Email or Phone Number",
								style: GoogleFonts.montserrat
								(
									color: Colors.grey,
									fontSize: fontSize / 25,
									fontWeight: FontWeight.w300
								),
							),
						SizedBox(height: height / 30,),
						TextFormField
						(
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
						Expanded
						(
							child: Center
							(
								child: Container
								(
									height: height  / 13,
									width: double.infinity,
									child: ElevatedButton
									(
										child: Text
										(
											"Submit",
											style: GoogleFonts.montserrat(fontSize: fontSize / 20)
										),
										style: ButtonStyle
										(
											foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
											backgroundColor: MaterialStateProperty.all<Color>(Colors.white70),
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
											Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTP()));
										}
									)
								)
							),
						),
						Expanded
						(
							child: Container
							(
								width: double.infinity,
								child: GestureDetector
								(
									child: RichText
									(
										textAlign: TextAlign.center,
										text: TextSpan
										(
											text: "Don't have an account? ",
											style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 13), /*defining default style is optional */
											children:
											[
												TextSpan
												(
													text: "Create Account",
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
											isNewUser = true;
										});
									},
								)
							)
						)
					],
				),
			),
		);
	}
}