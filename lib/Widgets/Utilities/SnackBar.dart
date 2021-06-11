import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/global.dart';

showSnackBar(context, title)
{
	return ScaffoldMessenger.of(context).showSnackBar
	(
		SnackBar
		(
			
			content: Text
			(
				title,
				style: GoogleFonts.montserrat
				(
					fontSize: getFontSize(context) / 25,
					color: Colors.white
				)
			),
			backgroundColor: Color(int.parse("0xffEF5C99")),
		)
	);
}