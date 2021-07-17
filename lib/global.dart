import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';


late VideoPlayerController _controller;

bool isInfluencer = false;

List categoriesList = [];
List newArrivedList = [];
List brandList = [];

var user =
{
	"email": "",
	"phone": "",
	"password": "",
	"isLoggedIn": false,
	"token": "",
	"image": "",
	"dob": ""
};

getFontSize(context)
{
	return MediaQuery.of(context).size.width;
}

getHeight(context)
{
	return MediaQuery.of(context).size.height;
}


getWidth(context)
{
	return MediaQuery.of(context).size.width;
}

bool isPlaying = false;


playVideo(url)
{
	if(url == null)
	{
		_controller.pause();
	}
	else
	{
		_controller = VideoPlayerController.network(url.toString());
		_controller.initialize();
		_controller.play();
		isPlaying = true;
		_controller.setLooping(true);
		return _controller;
	}
}

showPopup(String type, String description, BuildContext context)
{
	String title = "";
	Icon icon = Icon(Icons.ac_unit);
	var fontSize = getFontSize(context);

	switch(type)
	{
		case "error":
			title = "Ooops! Error";
			icon = Icon(Icons.dangerous);
			break;
		case "success":
			title = "Info";
			icon = Icon(Icons.done);
			break;
		case "phoneNumber":
			title = "Ooops! Error";
			icon = Icon(Icons.info);
			break;
		case "chooseSlots":
			title = "Choose the slots";
			icon = Icon(Icons.warning);
			break;
	}

	return showDialog<void>
	(
		context: context,
		barrierDismissible: false,
		builder: (BuildContext context)
		{
			return AlertDialog
			(
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
				title: Row
				(
					children:
					[
						icon,
						Text
						(
							" " + title, 
							style: GoogleFonts.montserrat(fontSize: fontSize / 20,)
						),
					]
				),
				content: SingleChildScrollView
				(
					child: Column
					(
						children:
						[
							Text
							(
								description,
								style: GoogleFonts.montserrat(fontSize: fontSize / 20,)
							),
							SizedBox(height: 10),
							ElevatedButton
							(
								child: Text
								(
									"OK",
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
											borderRadius: BorderRadius.circular(8.5),
											side: BorderSide(color: Colors.white38)
										)
									)
								),
								onPressed: ()
								{
									Navigator.pop(context);
								}
							)
						]
					)
				)
			);
		}
	);
}

