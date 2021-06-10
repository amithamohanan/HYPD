
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
		// _controller = VideoPlayerController.network("https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4");
		_controller = VideoPlayerController.asset("assets/images/introScreen.mp4")..initialize();

		_controller.addListener(() 
		{
			if (_controller.value.hasError) 
			{
				print(_controller.value.errorDescription);
			}
			if (_controller.value.isInitialized)
			{
				SnackBar(content: Text("Initialised"));
			}
			if (_controller.value.isBuffering)
			{
				SnackBar(content: Text("Buffering"));
			}
		});
		// _controller.initialize();
		_controller.play();
		_controller.setLooping(true);
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
				resizeToAvoidBottomInset: true,
				body:  Stack
				(
					children: <Widget>
					[
						videoPlayer(),
						isNewUser ? register() : skipText(),
						!isNewUser ? Positioned
						(
							right: width/ 40,
							left: width / 40,
							bottom: 20,
							child: Form
							(
								child: Column
								(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: 
									[
										loginText(),
										socialMediaIcons(),
										formField(),
									],
								),
							),
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
		return  Padding
		(
			padding: EdgeInsets.only(bottom: 20),
			child: Text
			(
				"Log in with Social Media",
				style: GoogleFonts.montserrat
				(
					color: Colors.white,
					fontSize: fontSize / 20,
					fontWeight: FontWeight.w300
				)
			),
		);
	}

	Widget socialMediaIcons()
	{
		return Padding
		(
			padding: EdgeInsets.only(bottom: 20),
			child: Row
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
			)
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
							"Log in to Continue",
							style: GoogleFonts.montserrat
							(
								color: Colors.black,
								fontSize: 20,
								fontWeight: FontWeight.bold
							),
						),
						SizedBox(height: 20),
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
						SizedBox(height: 20),
						TextFormField
						(
							style:  GoogleFonts.montserrat
							(
								fontWeight: FontWeight.bold,
								color: Colors.black,
								fontSize: fontSize / 30,
							),
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
										"Submit",
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
									onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTP()))

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
						),
						SizedBox(height: 10,),
					],
				),
			),
		);
	}
	
	Widget register()
	{
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
								style:  GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
									fontSize: fontSize / 30,
								),
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
								style:  GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
									fontSize: fontSize / 30,
								),
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
								style:  GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
									fontSize: fontSize / 30,
								),
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
				),
			)
		);
	}
}