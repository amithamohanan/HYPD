import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsOfUse extends StatelessWidget
{
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			appBar: appBar(context),
			body: SingleChildScrollView
			(
				child: Container
				(
					margin: EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 50),
					child: Text
					(
						"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam id nisi sed urna pulvinar varius. Nullam rhoncus, arcu non interdum hendrerit, orci nibh lobortis odio, a tincidunt orci enim at risus. Sed vulputate, massa sed suscipit faucibus, lacus erat suscipit arcu, aliquet blandit orci lectus in massa. Cras efficitur tincidunt suscipit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce ac congue urna. Nulla eget pretium quam, id vestibulum nibh."
						"Vivamus congue eros vitae magna fringilla, et luctus ipsum pellentesque. Fusce sit amet mattis neque, nec ultrices nunc. Aenean vitae venenatis odio. Aenean bibendum justo a dolor iaculis posuere. Nam ac risus ut eros blandit scelerisque. Nulla efficitur egestas libero sed ornare. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam erat volutpat. Proin sed ante justo. Aliquam erat volutpat. Morbi pulvinar et nunc vitae sollicitudin. Donec vulputate eleifend purus nec cursus. Aliquam sed lectus aliquam nisl porta sollicitudin. Pellentesque nec est nec sapien dignissim egestas non a sapien. Nullam gravida, magna sit amet bibendum aliquam, nulla arcu lobortis nunc, eget rutrum eros libero eu ligula."

						"Sed at convallis lectus, sed iaculis mauris. Ut eleifend felis nec condimentum egestas. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Pellentesque feugiat sed metus vel dapibus. Morbi auctor varius sem, vitae commodo orci lobortis vitae. Etiam vitae ornare augue, bibendum tempus libero. Vestibulum metus ex, iaculis nec erat ultricies, varius hendrerit justo."

						"Nam enim tortor, euismod a cursus at, congue sit amet arcu. Phasellus pharetra leo finibus ante molestie dignissim. Cras tortor nulla, aliquet a massa a, eleifend tempus sapien. Suspendisse condimentum purus tortor, eget egestas metus tincidunt tristique. Sed tristique odio sapien, eget placerat arcu fringilla sed. Duis tempus vulputate eros sit amet fringilla. Suspendisse ac dapibus ante. Aliquam lobortis eros in enim sollicitudin aliquet. Pellentesque cursus ex quis eleifend rutrum. Nulla gravida nisi vel leo ornare porttitor. Donec rutrum tristique elementum."

						"Nullam vel diam at arcu tincidunt semper. Morbi vitae libero ipsum. Maecenas elementum iaculis dignissim. Aliquam eu dapibus sapien. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eget eros euismod, varius lorem a, tincidunt ipsum. Curabitur pharetra, risus a vestibulum feugiat, dolor velit porta ipsum, sit amet viverra nulla magna quis tortor. Morbi sed scelerisque enim. Aliquam malesuada mollis odio, gravida viverra justo fringilla eu. Nam vehicula venenatis dui. Integer eu semper mi. Morbi in rhoncus arcu. Nulla libero urna, tincidunt sed pharetra sagittis, volutpat nec nibh. Ut ut placerat odio. Cras massa lorem, tristique egestas leo sit amet, lobortis sollicitudin est. Fusce lobortis est justo, quis ornare risus dictum eget.",
						style: GoogleFonts.montserrat
						(
							letterSpacing: 0.5,
							wordSpacing: 0.5,
							fontSize: 15,
							color: Colors.black54
						),
					),
				),
			),
		);
	}

	appBar(context)
	{
		return AppBar
		(
			title: Text
			(
				"Terms of Use",
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w400
				),
			),
			centerTitle: true,
			elevation: 0,
			backgroundColor: Colors.white,
			leading: Container
			(
				margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
				padding: EdgeInsets.all(5),
				height: 30,
				width: 30,
				decoration: BoxDecoration
				(
					color: Color(int.parse("0xfff2f2f0")),
					borderRadius: BorderRadius.circular(15)
				),
				child: FittedBox
				(
					child:  IconButton
					(
						onPressed: ()
						{
							Navigator.pop(context);
						},
						icon: Icon(Icons.arrow_back_ios),
						color: Colors.black,
					),
				)
			),
		);
	}

}