
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hypd/Widgets/API/Server.dart';
import 'package:hypd/Widgets/AddUserDetails.dart';
import 'package:hypd/Widgets/BottomNavigationBar/HomePage.dart';
import 'package:hypd/Widgets/Influencer/InfluencerWatchVideo.dart';
import 'package:hypd/Widgets/InflunecerSignUpPage.dart';
import 'package:hypd/Widgets/Utilities/Loader.dart';
import 'package:hypd/Widgets/Utilities/SnackBar.dart';
import 'package:hypd/Widgets/VerifyOtp.dart';
import 'package:hypd/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Login extends StatefulWidget
{
	@override
	_LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
{
	final _formKeyRegister = GlobalKey<FormState>();
	final _formKeyLogin = GlobalKey<FormState>();

	TextEditingController emailField = new TextEditingController();
	TextEditingController phoneField = new TextEditingController();
	TextEditingController loginEmailField = new TextEditingController();
	TextEditingController loginPasswordField = new TextEditingController();
	TextEditingController passwordField = new TextEditingController();
	TextEditingController confirmpasswordField = new TextEditingController();
	TextEditingController dobField = new TextEditingController(text: "");



	late VideoPlayerController _controller;

	bool isNewUser = false;
	bool isLoginWithEmail = false;
	bool showPassword1 = false;
	bool showPassword2 = false;

	var fontSize;
	var height;
	var width;
	var date;

	@override
	void initState()
	{
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
				backgroundColor: Colors.black,
				resizeToAvoidBottomInset: true,
				body: SingleChildScrollView
				(
					child: Stack
					(
						children: <Widget>
						[
							videoPlayer(),
							isNewUser ? register(context) : skipText(),
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
			child: Image.network("https://images.pexels.com/photos/1133721/pexels-photo-1133721.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", fit: BoxFit.cover)
		);
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
				// 	Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
					Navigator.push(context, MaterialPageRoute(builder: (context) => InfluecnerWatchVideo()));
					// Navigator.push(context, MaterialPageRoute(builder: (context) => RecordVideo()));
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
					facebookLoginButton(),
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
	Widget facebookLoginButton()
	{
		return GestureDetector
		(
			child: Image.asset("assets/images/Facebook_icon.png"),
			onTap: () async
			{
				initiateFacebookLogin();
			},
		);
	}

	// google login
	Widget googleLogin()
	{
		return GestureDetector
		(
			child: Image.asset("assets/images/Google_icon.png"),
			onTap: () async
			{
				GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

				var response = _googleSignIn.signIn();

				print(response);
				_googleSignIn.signIn().then((GoogleSignInAccount? acc) async
				{
					GoogleSignInAuthentication auth = await acc!.authentication;

					print(auth);
					print(acc.id);
					print(acc.email);
					print(acc.displayName);
					print(acc.photoUrl);

					acc.authentication.then((GoogleSignInAuthentication auth) async
					{
						print(auth.idToken);
						print(auth.accessToken);
					});
				});
			}
		);
	}

	// get user credentials from Facebook
	initiateFacebookLogin() async
	{
		bool _isLoggedIn = true;
		var  result = await FacebookAuth.instance.login();
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
				key: _formKeyLogin,
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
							controller: loginEmailField,
							keyboardType: TextInputType.emailAddress,
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
							validator: (value)
							{
								if(value == null || value.isEmpty)
								{
									return "*Email cannot be empty";
								}
								else
								{
									// if (!value.contains('@'))
									// {
									// 	return 'Invalid Email';
									// }
									// else
									// {
									// 	return null;
									// }
								}
							},
							onChanged: (value)
							{
								final number = num.tryParse(value);

								print(value.length);

								if(number == null && value.length != 0)
								{
									isLoginWithEmail = true;
								}
								else
								{
									isLoginWithEmail = false;
								}

								setState((){});
							},
							onSaved: (value) => loginEmailField.text = value.toString(),
						),
						SizedBox(height: 25,),
						isLoginWithEmail ? Text
						(
							"Password",
							style: GoogleFonts.montserrat
							(
								color: Colors.grey,
								fontSize: fontSize / 25,
								fontWeight: FontWeight.w300
							),
						) : SizedBox.shrink(),
						isLoginWithEmail ? SizedBox(height: 20) : SizedBox.shrink(),
						isLoginWithEmail ?
						TextFormField
						(
							obscureText: true,
							controller: loginPasswordField,
							keyboardType: TextInputType.text,
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
							validator: (value)
							{
								if(value == null || value.isEmpty)
								{
									return "*Password cannot be empty";
								}
							},
							onChanged: (value)
							{
								if(value.contains("@"))
								{
									print(value);
									isLoginWithEmail = true;
								}
							},
							onSaved: (value) => loginPasswordField.text = value.toString(),
						) : SizedBox.shrink(),
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
										"Login",
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
									onPressed: () async
									{
										if(isLoginWithEmail == true)
										{
											await loginWithEmail(loginEmailField.text, loginPasswordField.text);
										}
										else
										{
											print("else part");
											print(loginEmailField.text);
											await loginWithPhone(loginEmailField.text);
										}
										// if (_formKeyLogin.currentState!.validate())
										// {
										// 	showSnackBar(context, "OTP send successfully");
										// 	Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTP()));
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

	Widget register(context)
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
					key: _formKeyRegister,
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
							SizedBox(height: 20),
							// email
							TextFormField
							(
								controller: emailField,
								keyboardType: TextInputType.emailAddress,
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
									errorStyle: GoogleFonts.montserrat
									(
										color: Colors.pink,
										fontSize: fontSize / 30,
									),
									counterText: "",
									contentPadding: EdgeInsets.all(0),
									isDense: true,
									enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
								),
								validator: (value)
								{
									if(value == null || value.isEmpty)
									{
										return "*Email cannot be empty";
									}
									else
									{
										if (!value.contains('@'))
										{
											return 'Invalid Email';
										}
										else
										{
											return null;
										}
									}
								},
								onSaved: (value) => emailField.text = value.toString(),
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
							SizedBox(height: 20),
							// phone
							TextFormField
							(
								controller: phoneField,
								keyboardType: TextInputType.phone,
								maxLength: 10,
								style:  GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
									fontSize: fontSize / 30,
								),
								decoration: InputDecoration
								(
									errorStyle: GoogleFonts.montserrat
									(
										color: Colors.pink,
										fontSize: fontSize / 30,
									),
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
								validator: (value)
								{
									if(value == null || value.isEmpty)
									{
										return "*Phone cannot be empty";
									}
									else
									{
										if (value.length != 10)
										{
											return 'Enter a valid phone number';
										}
										else
										{
											return null;
										}
									}
								},
								onSaved: (value) => phoneField.text = value.toString(),
							),
							SizedBox(height: 25,),
							Text
							(
								"Password",
								style: GoogleFonts.montserrat
								(
									color: Colors.black38,
									fontSize: fontSize / 30,
								),
							),
							SizedBox(height: 20),
							// password
							TextFormField
							(
								obscureText: true,
								controller: passwordField,
								keyboardType: TextInputType.text,
								style:  GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
									fontSize: fontSize / 30,
								),

								decoration: InputDecoration
								(
									errorStyle: GoogleFonts.montserrat
									(
										color: Colors.pink,
										fontSize: fontSize / 30,
									),
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
								validator: (value)
								{
									if(value == null || value.isEmpty)
									{
										return "*Password cannot be empty";
									}
									else
									{
										if (value.length < 8)
										{
											return '*Password is too weak';
										}
										else
										{
											return null;
										}
									}
								},
								onSaved: (value) => passwordField.text = value.toString(),
							),
							SizedBox(height: 25,),
							Text
							(
								"Confirm Password",
								style: GoogleFonts.montserrat
								(
									color: Colors.black38,
									fontSize: fontSize / 30,
								),
							),
							SizedBox(height: 20),
							// confirm password
							TextFormField
							(
								obscureText: true,
								controller: confirmpasswordField,
								keyboardType: TextInputType.text,
								style:  GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									color: Colors.black,
									fontSize: fontSize / 30,
								),
								decoration: InputDecoration
								(
									errorStyle: GoogleFonts.montserrat
									(
										color: Colors.pink,
										fontSize: fontSize / 30,
									),
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
								validator: (value)
								{
									if(value == null || value.isEmpty)
									{
										return "*Confirm password cannot be empty";
									}
									else
									{
										if (value.toString() != passwordField.text.toString())
										{
											return '*Password mismatch!!!';
										}
										else
										{
											return null;
										}
									}
								},
								onSaved: (value) => confirmpasswordField.text = value.toString(),
							),
							SizedBox(height: 20),
							Text
							(
								"Date of Birth",
								style: GoogleFonts.montserrat
								(
									color: Colors.black38,
									fontSize: fontSize / 30,
								),
							),
							SizedBox(height: 20),
							TextFormField
							(
								controller: dobField,
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
								validator: (value)
								{
									if(value == null || value.isEmpty)
									{
										return "*Date of birth cannot be empty";
									}
									else
									{
										return null;
									}
								},
								onSaved: (value) => dobField.text = value.toString(),
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
										onPressed: () async
										{
											if (_formKeyRegister.currentState!.validate())
											{
												popup(context);
												await newRegistration(emailField.text, phoneField.text, passwordField.text, dobField.text);
											// 	showSnackBar(context, "OTP send, please check your phone");
											// 	Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTP()));
											}
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
											text: "Sign up as ",
											style: GoogleFonts.montserrat(color: Colors.grey, fontSize: fontSize / 30,), /*defining default style is optional */
											children:
											[
												TextSpan
												(
													text: "Influencer",
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
											isInfluencer = true;
										});
										Navigator.push(context, MaterialPageRoute(builder: (context) => InfluencerSignUp()));
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

	newRegistration(email, phone, password, dob) async
	{

		if (_formKeyRegister.currentState!.validate())
		{
			var response = await Server.customerRegistration(email, phone, password, dob);
			print(response);

			if(response == false)
			{
				showPopup("error", "Already Registered", context);
			}
			else
			{
				var response = await Server.loginWithEmail(email, password);
				if(response == false)
				{
					showPopup("error", "Error in Login", context);
				}
				else
				{
					user["email"] = email;
					user["phone"] = phone;
					user["dob"] = dob;
					user["id"] = response[0]["id"];
					user["token"] = response[0]["remember_token"];
					user["isLoggedIn"]  = true;

					saveLocally();

					showSnackBar(context, "Registered Successfully");
					Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserDetails()));
				}
			}
		}
	}

	loginWithEmail(email, password) async
	{
		if (_formKeyLogin.currentState!.validate())
		{
			var response = await Server.loginWithEmail(email, password);
			print(response);

			if(response == false)
			{
				showPopup("error", "Error in Login", context);
			}
			else
			{
				user["id"] = response[0]["id"];
				user["token"] = response[0]["remember_token"];
				user["name"] = response[0]["name"];
				user["email"] = email;
				user["phone"] = response[0]["phone"];
				user["dob"] = response[0]["dob"];
				user["image"] = response[0]["image"];
				user["isLoggedIn"]  = true;
				user["gender"]  = response[0]["gender"];

				saveLocally();

				Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
			}
		}
	}

	loginWithPhone(phone) async
	{
		if (_formKeyLogin.currentState!.validate())
		{
			print(phone);
			var response = await Server.loginWithPhone(phone);
			print(response);

			if(response == false)
			{
				showPopup("error", "Error in Login", context);
			}
			else
			{
				user["id"] = response["response"][0]["id"];
				user["token"] = response["response"][0]["remember_token"];
				user["name"] = response["response"][0]["name"];
				user["email"] = response["response"][0]["email"];
				user["phone"] = response["response"][0]["phone"];
				user["dob"] = response["response"][0]["dob"];
				user["image"] = response["response"][0]["image"];
				user["isLoggedIn"]  = true;
				user["gender"]  = response["response"][0]["gender"];

				print(user);

				saveLocally();
				showSnackBar(context, "OTP send successfully");
				Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTP(response["OTPnumber"])));

			}

		// if (_formKeyLogin.currentState!.validate())
		// {
			// Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTP()));
		}
	}

	saveLocally() async
	{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		await prefs.setString('isLoggedIn', jsonEncode(user.toString()));

	}

}