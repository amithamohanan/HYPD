import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/Influencer/InProfilePage.dart';

class PendingVerification extends StatelessWidget
{
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			backgroundColor: Colors.white,
			body: Container
			(
				child: Column
				(
					children: 
					[
						Image.asset("assets/images/pending.gif"),
						Text
						(
							"Waiting for approval...",
							style: GoogleFonts.montserrat
							(
								fontWeight: FontWeight.w500,
								fontSize: 20
							),
							textAlign: TextAlign.center,
						),
						SizedBox(height: 30),
						GestureDetector
						(
							child: Container
							(
								padding: EdgeInsets.only(left: 25, right: 25),
								width: MediaQuery.of(context).size.width,
								height: MediaQuery.of(context).size.height / 15,
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
													"GO BACK",
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
								Navigator.push(context, MaterialPageRoute(builder: (context) => InProfilePage()));
							},
						)
					],
				),
			),
		);
	}
}