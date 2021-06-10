import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget
{
	@override
	_SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
{
	var height;
	var width;

	bool changed = true;

	@override
	Widget build(BuildContext context)
	{
		height = MediaQuery.of(context).size.height;
		width = MediaQuery.of(context).size.width;

		return Scaffold
		(
			body: Container
			(
				margin: EdgeInsets.only(top: 25, left: 10, right: 10),
				child: Column
				(
					crossAxisAlignment: CrossAxisAlignment.start,
					children:
					[
						backButton(),
						SizedBox(height: height / 35),
						settingsText(),
						SizedBox(height: height / 35),
						notificationBar(),
						SizedBox(height: height / 35),
						privacyPolicy(),
						SizedBox(height: height / 35),
						termsOfUse(),
						SizedBox(height: height / 35),
						helpCenter(),
						SizedBox(height: height / 35),
						logOut()
					],
				),
			),
		);
	}

	backButton()
	{
		return  Container
		(
			padding: EdgeInsets.all(5),
			decoration: BoxDecoration
			(
				color: Color(int.parse("0xfff2f2f0")),
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
		);
	}

	settingsText()
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.center,
			children :
			[
				Text
				(
					"Settings",
					style: GoogleFonts.montserrat
					(
						fontWeight: FontWeight.w400,
						color: Colors.black,
						fontSize: 30
					),
				),
			]
		);
	}

	notificationBar()
	{
		return  Card
		(
			elevation: 0,
			color: Colors.transparent,
			child: ListTile
			(
				leading: Container
				(
					height: 40,
					width: 40,
					margin: EdgeInsets.all(5),
					padding: EdgeInsets.all(10),
					decoration: BoxDecoration
					(
						color: Color(int.parse("0xfff2f2f0")),
						borderRadius: BorderRadius.circular(15)
					),
					child: FittedBox
					(
						fit: BoxFit.cover,
						child: Icon(Icons.notifications_active_outlined, color: Colors.black,),
					)
				),
				title: Padding
				(
					padding: EdgeInsets.only(top: height / 35),
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children:
						[
							Text
							(
								"Notifications",
								style: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.bold,
									fontSize: 15,
								),
							),
							SizedBox(height:  5,),
							Text
							(
								"This will not affect any order updates",
								style: GoogleFonts.montserrat
								(
									fontWeight: FontWeight.w200,
									fontSize: 11,
								),
							),
						],
					),
				),
				trailing: Switch
				(
					activeColor: Color(int.parse("0xffEF5C99")),
					value: changed,
					onChanged: (bool newValue)
					{
						setState(()
						{
							changed = newValue;
							if(changed == true)
							{
								// wifiEnabled = true;
								// print(wifiEnabled);
							}
							else
							{
								// wifiEnabled = false;
							}
						});
					}
				)
			),
		);
	}

	privacyPolicy()
	{
		return Card
		(
			elevation: 0,
			color: Colors.transparent,
			child: ListTile
			(
				leading: Container
				(
					height: 40,
					width: 40,
					margin: EdgeInsets.all(5),
					padding: EdgeInsets.all(10),
					decoration: BoxDecoration
					(
						color: Color(int.parse("0xfff2f2f0")),
						borderRadius: BorderRadius.circular(15)
					),
					child: FittedBox
					(
						fit: BoxFit.cover,
						child: Icon(Icons.dashboard_customize_rounded, color: Colors.black,),
					)
				),
				title: Text
				(
					"Privacy Policy",
					style: GoogleFonts.montserrat
					(
						fontWeight: FontWeight.bold,
						fontSize: 15,
					),
				),
			),
		);
	}

	termsOfUse()
	{
		return Card
		(
			elevation: 0,
			color: Colors.transparent,
			child: ListTile
			(
				leading: Container
				(
					height: 40,
					width: 40,
					margin: EdgeInsets.all(5),
					padding: EdgeInsets.all(10),
					decoration: BoxDecoration
					(
						color: Color(int.parse("0xfff2f2f0")),
						borderRadius: BorderRadius.circular(15)
					),
					child: FittedBox
					(
						fit: BoxFit.cover,
						child: Icon(Icons.file_copy_outlined, color: Colors.black,),
					)
				),
				title: Text
				(
					"Terms of Use",
					style: GoogleFonts.montserrat
					(
						fontWeight: FontWeight.bold,
						fontSize: 15,
					),
				)
			),
		);
	}

	helpCenter()
	{
		return Card
		(
			elevation: 0,
			color: Colors.transparent,
			child: ListTile
			(
				leading: Container
				(
					height: 40,
					width: 40,
					margin: EdgeInsets.all(5),
					padding: EdgeInsets.all(10),
					decoration: BoxDecoration
					(
						color: Color(int.parse("0xfff2f2f0")),
						borderRadius: BorderRadius.circular(15)
					),
					child: FittedBox
					(
						fit: BoxFit.cover,
						child: Icon(Icons.help_outline, color: Colors.black,),
					)
				),
				title: Text
				(
					"Help Center",
					style: GoogleFonts.montserrat
					(
						fontWeight: FontWeight.bold,
						fontSize: 15,
					),
				)
			),
		);
	}

	logOut()
	{
		return Container
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
								"Log Out",
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
		);
	}
}