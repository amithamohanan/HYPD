import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/AddUserDetails.dart';

class VerifyOTP extends StatefulWidget 
{
	@override
	_VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> 
{
	var height;
	var width;

	late Timer _timer;

	int _start = 60;
	int disabledCounter = 0;

	bool isOtpEntered = false;
	bool resendOTP = false;

	final focus1 = FocusNode();
	final focus2 = FocusNode();
	final focus3 = FocusNode();
	final focus4= FocusNode();
	final focus5 = FocusNode();
	final focus6 = FocusNode();

	var f1Controller = TextEditingController();
	var f2Controller = TextEditingController();
	var f3Controller = TextEditingController();
	var f4Controller = TextEditingController();
	var f5Controller = TextEditingController();
	var f6Controller = TextEditingController();


	@override
	void initState()
	{
		super.initState();
		startTimer();
	}

	@override
	void dispose()
	{
		_timer.cancel();
		super.dispose();
	}

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
		return  Scaffold
		(
			resizeToAvoidBottomInset: false,
			backgroundColor: Color(int.parse("0xff312247")),
			appBar: appBar(),
			body: otpForm()
		);
	}

	appBar()
	{
		return  AppBar
		(
			leadingWidth: 50,
			elevation: 0,
			leading: Container
			(
				padding: EdgeInsets.all(7),
				decoration: BoxDecoration
				(
					color: Colors.white,
					borderRadius: BorderRadius.circular(20)
				),
				height: height / 12,
				width: width / 7,
				child: Center
				(
					child: IconButton
					(
						onPressed: ()
						{
							Navigator.pop(context);
						}, 
						icon: Icon(Icons.arrow_back_ios),
						color: Colors.black,
					),
				),
			),
			centerTitle: true,
			title: Text
			(
				"VERIFY PHONE NUMBER",
				style: GoogleFonts.montserrat
				(
					color: Colors.white,
					fontSize: 13
				),
			),
			backgroundColor: Color(int.parse("0xff312247")),
		);
	}

	otpForm()
	{
		return  Container
		(
			margin: EdgeInsets.all(25),
			padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
			height: height / 1.3,
			width: double.infinity,
			decoration: BoxDecoration
			(
				color: Colors.white,
				borderRadius: BorderRadius.circular(25)
			),
			child: Column
			(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: 
				[
					Text
					(
						"Verification OTP",
						style: GoogleFonts.montserrat
						(
							color: Colors.black,
							fontSize: 15,
							fontWeight: FontWeight.bold
						),
					),
					SizedBox(height: 25),
					Text
					(
						"We have sent an OTP on your number 1234567890",
						style: GoogleFonts.montserrat
						(
							color: Colors.grey,
							fontSize: 12,
							// fontWeight: FontWeight.bold
						),
					),
					otpEnterField(),
					SizedBox(height: 25),
					timerField(),
					SizedBox(height: 25),
					sendOtp(),
					SizedBox(height: 25),
					confirmButton()
				],
			),
		);
	}

	otpEnterField()
	{
		return Row
		(
			children: 
			[
				Container
				(
					height: 50,
					width: 30,
					margin: EdgeInsets.only(right:8, bottom:10),
					child: TextFormField
					(
						style: TextStyle(fontSize: 18, color: Colors.grey),
						controller: f1Controller,
						textInputAction: TextInputAction.next,
						focusNode: focus1,
						keyboardType: TextInputType.number,
						textAlign: TextAlign.center,
						maxLength: 1,
						decoration: InputDecoration
						(
							counterText: ''
						),
						onChanged: (v)
						{
							editOtp();

							if (v.length == 0)
							{

							}
							else
							{
								FocusScope.of(context).requestFocus(focus2);
							}
						},
					),
				),
				Container
				(
					height: 50,
					width: 30,
					margin: EdgeInsets.only(right:8, bottom:10),
					child: TextFormField
					(
						style: TextStyle(fontSize: 18, color: Colors.grey),
						controller: f2Controller,
						textInputAction: TextInputAction.next,
						focusNode: focus2,
						keyboardType: TextInputType.number,
						textAlign: TextAlign.center,
						maxLength: 1,
						decoration: InputDecoration
						(
							counterText: ''
						),
						onChanged: (v)
						{
							editOtp();

							if (v.length == 0)
							{
								FocusScope.of(context).requestFocus(focus1);
							}
							else
							{
								FocusScope.of(context).requestFocus(focus3);
							}
						},
					),
				),
				Container
				(
					height: 50,
					width: 30,
					margin: EdgeInsets.only(right:8, bottom:10),
					child: TextFormField
					(
						style: TextStyle(fontSize: 18, color: Colors.grey),
						controller: f3Controller,
						textInputAction: TextInputAction.next,
						focusNode: focus3,
						keyboardType: TextInputType.number,
						textAlign: TextAlign.center,
						maxLength: 1,
						decoration: InputDecoration
						(
							counterText: ''
						),
						onChanged: (v)
						{
							editOtp();

							if (v.length == 0)
							{
								FocusScope.of(context).requestFocus(focus2);
							}
							else
							{
								FocusScope.of(context).requestFocus(focus4);
							}
						},
					),
				),
				Container
				(
					height: 50,
					width: 30,
					margin: EdgeInsets.only(right:8, bottom:10),
					child: TextFormField
					(
						style: TextStyle(fontSize: 18, color: Colors.grey),
						controller: f4Controller,
						textInputAction: TextInputAction.next,
						focusNode: focus4,
						keyboardType: TextInputType.number,
						textAlign: TextAlign.center,
						maxLength: 1,
						decoration: InputDecoration
						(
							counterText: ''
						),
						onChanged: (v)
						{
							editOtp();

							if (v.length == 0)
							{
								FocusScope.of(context).requestFocus(focus3);
							}
							else
							{
								FocusScope.of(context).requestFocus(focus5);
							}
						}
					),
				),
				Container
				(
					height: 50,
					width: 30,
					margin: EdgeInsets.only(right:8, bottom:10),
					child: TextFormField
					(
						style: TextStyle(fontSize: 18, color: Colors.grey),
						controller: f5Controller,
						textInputAction: TextInputAction.next,
						focusNode: focus5,
						keyboardType: TextInputType.number,
						textAlign: TextAlign.center,
						maxLength: 1,
						decoration: InputDecoration
						(
							counterText: ''
						),
						onChanged: (v)
						{
							editOtp();

							if (v.length == 0)
							{
								FocusScope.of(context).requestFocus(focus4);
							}
							else
							{
								FocusScope.of(context).requestFocus(focus6);
							}
						}
					),
				),
				Container
				(
					height: 50,
					width: 30,
					margin: EdgeInsets.only(right:8, bottom:10),
					child: TextFormField
					(
						style: TextStyle(fontSize: 18, color: Colors.grey),
						controller: f6Controller,
						textInputAction: TextInputAction.next,
						focusNode: focus6,
						keyboardType: TextInputType.number,
						textAlign: TextAlign.center,
						maxLength: 1,
						decoration: InputDecoration
						(
							counterText: ''
						),
						onChanged: (v)
						{
							editOtp();

							if (v.length == 0)
							{
								FocusScope.of(context).requestFocus(focus5);
							}
							else
							{

							}
						}
					),
				)
			],
		);
	}

	timerField()
	{
		return Text
		(
			"00:" +_start.toString(),
			style: GoogleFonts.montserrat
			(
				color: Colors.black,
				fontWeight: FontWeight.bold,
				fontSize: 17

			),
		);
	}

	sendOtp()
	{
		return  GestureDetector
		(
			child: RichText
			(
				textAlign: TextAlign.center,
				text: TextSpan
				(
					text: "Didn't receive OTP? ",
					style: TextStyle(color: Colors.grey, fontSize: 13), /*defining default style is optional */
					children:
					[
						TextSpan
						(
							text: "Resend Code",
							style: GoogleFonts.montserrat
							(
								color: resendOTP ?  Colors.blue : Colors.black12,
							)
						),
					],
				),
			),
			onTap: ()
			{
				// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
			},
		);
	}

	confirmButton()
	{
		return Container
		(
			height: height / 12,
			width: width / 4,
			child: ElevatedButton
			(
				child: Text
				(
					"Confirm",
					style: GoogleFonts.montserrat
					(
						fontSize: 14,
						color: Colors.white
					)
				),
				style: ButtonStyle
				(
					foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
					backgroundColor:  isOtpEntered ? MaterialStateProperty.all<Color>(Color(int.parse("0xffF56C27"))) : MaterialStateProperty.all<Color>(Colors.white70),
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
					Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddUserDetails()));
				}
			)
		);
	}

	void startTimer()
	{
		_start = 30;
  		const oneSec = const Duration(seconds: 1);

  		_timer = new Timer.periodic(oneSec, (Timer timer)
		{
      		if (_start == 0)
			{
        		setState(()
				{
          			_timer.cancel();
					resendOTP = true;
        		});
      		}
			else
			{
        		setState(()
				{
          			_start--;
        		});
      		}
    	},);
	}

	editOtp()
	{
		var code = f1Controller.text + f2Controller.text + f3Controller.text + f4Controller.text + f5Controller.text + f6Controller.text;

		print(code.length);

		setState(()
		{
			isOtpEntered = code.length == 6 ? true : false;
			// isOtpEntered = true;
			// otpEntered = code;
		});
	}
}