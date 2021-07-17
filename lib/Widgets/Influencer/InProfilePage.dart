import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/EditProfile.dart';
import 'package:hypd/Widgets/Influencer/InBottomNavBar.dart';
import 'package:hypd/global.dart';

class InProfilePage extends StatefulWidget
{
	@override
	_InProfilePageState createState() => _InProfilePageState();
}

class _InProfilePageState extends State<InProfilePage>
{
	var height;
	var width;
	var fontSize;

	String dropdownValue = 'First';

	@override
	void initState()
	{
    	super.initState();
  	}

	@override
	Widget build(BuildContext context)
	{
		height = getHeight(context);
		width = getWidth(context);
		fontSize = getFontSize(context);

		return SafeArea
		(
			top: false,
			bottom: true,
			child: Scaffold
			(
				backgroundColor: Colors.white,
				appBar: appBar(),
				body: body(),
				bottomNavigationBar: InBottomNavBar(pageInd: 3),
			)
		);
	}

	// appbar
	appBar()
	{
		print(user);
		
		return AppBar
		(
			elevation: 2,
			backgroundColor:  Colors.white,
			titleSpacing: 0.0,
			centerTitle: true,
			title: Text
			(
				user["name"].toString() == "null" ? "" : user["name"].toString(),
				style:  GoogleFonts.montserrat
				(
					fontWeight: FontWeight.bold,
					color: Colors.black,
					fontSize: 15
				),
			),
			leading: Container
			(
				margin: EdgeInsets.all(5),
				height: 10,
				width: 45,
				decoration: BoxDecoration
				(
					color: Color(int.parse("0xfff2f2f0")),
					borderRadius: BorderRadius.circular(20)
				),
				child: IconButton
				(
					onPressed: ()
					{
						// playVideo(null);
						// Navigator.push(context, MaterialPageRoute(builder: (context) => MyBag()));
					},
					icon: Icon(Icons.person_add_alt_1_outlined),
					color: Colors.black,
				)
			),
			actions:
			[
				dropDown()
				// Container
				// (
				// 	margin: EdgeInsets.all(5),
				// 	height: 10,
				// 	width: 45,
				// 	child: IconButton
				// 	(
				// 		onPressed: ()
				// 		{
				// 			dropDown();

				// 			// Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
				// 		},
				// 		icon: Icon(Icons.more_vert),
				// 		color: Colors.black,
				// 	),
				// ),
			],
		);
	}

	Widget dropDown()
	{
		return PopupMenuButton<int>
		(
			color: Colors.white10.withOpacity(1),
			itemBuilder: (context) =>
			[
				PopupMenuItem
				(
					value: 1,
					child: Text("Log Out", style: GoogleFonts.montserrat(color: Colors.black)),
				),
			],
			onCanceled: ()
			{
				print("You have cancelled the menu.");
			},
			onSelected: (value)
			{
				if (value == 1)
				{
					print("value:$value");
					// var route = MaterialPageRoute(builder: (context) => EditProfilePage());
					// Navigator.push(context, route);
				}
				else if(value == 2)
				{
					// var route = MaterialPageRoute(builder: (context) => ChangePasswordPage());
					// Navigator.push(context, route);
				}
			},
			icon: Icon(Icons.more_vert),
		);
	}

	// body
	body()
	{
		return  Container
		(
			padding: EdgeInsets.all(25),
			height: height,
			width: width,
			child: Column
			(
				crossAxisAlignment: CrossAxisAlignment.center,
				children: 
				[
					// image
					image(),
					SizedBox(height: 8),
					username(),
					SizedBox(height: 8),
					numberOfVideos(),
					SizedBox(height: 25),
					likesAndFollows(),
					SizedBox(height: 25),
					editProfile(),
					SizedBox(height: 25),
					Divider(),
					galleryAndFavourites(),
					Divider()
				],
			),
		);
	}

	username()
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.center,
			children: 
			[
				Icon(Icons.verified, color: Color(int.parse("0xffEF5C99"))),
				SizedBox(width: 5),
				Text
				(
					"@username",
					style:  GoogleFonts.montserrat
					(
						fontWeight: FontWeight.bold,
						color: Colors.black,
						fontSize: 12
					),
				),
			],
		);
	}

	// image
	image()
	{
		return Container
		(
			margin: EdgeInsets.only(left: 10),
			height: height * .2,
			width: width * 0.3,
			child: ClipRRect
			(
				borderRadius: BorderRadius.circular(10.0),
				child: Image.network(user["image"] == null ? "https://images.pexels.com/photos/3586798/pexels-photo-3586798.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500" : user["image"].toString(), fit: BoxFit.cover),
			),
		);
	}

	numberOfVideos()
	{
		return Container
		(
			decoration: BoxDecoration
			(
				borderRadius: BorderRadius.circular(15),
				color: Color(int.parse("0xfff2f2f0"))
			),
			child: Padding
			(
				padding: EdgeInsets.all(10),
				child: Text
				(
					"0 Video",
					style: GoogleFonts.montserrat
					(
						color: Colors.black45
					),
				),
			)
		);
	}

	likesAndFollows()
	{
		return IntrinsicHeight
		(
			// margin: EdgeInsets.only(left: 25, right: 25),
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: 
				[
					returnText("0", "Following"),
					VerticalDivider(color: Colors.grey,width: 1),
					returnText("0", "Followers"),
					VerticalDivider(color: Colors.grey,width: 1),
					returnText("0", "Likes")
				],
			),
		);
	}

	returnText(count, title)
	{
		return Expanded
		(
			child: Column
			(
				crossAxisAlignment: CrossAxisAlignment.center,
				children: 
				[
					Text
					(
						count,
						style:  GoogleFonts.montserrat
						(
							fontWeight: FontWeight.bold,
							color: Colors.black,
							fontSize: 15
						),
					),
					Text
					(
						title,
						style:  GoogleFonts.montserrat
						(
							color: Colors.black38,
							fontSize: 15
						),
					)
				],
			)
		);
	}

	editProfile()
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.center,
			children: 
			[
				Container
				(
					height: height / 14,
					width: width * .4,
					child: ElevatedButton
					(
						child: Text
						(
							"Edit Profile",
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
							Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
						}
					)
				),
				SizedBox(width: 10),
				Container
				(
					decoration: BoxDecoration
					(
						borderRadius: BorderRadius.circular(2),
						border: Border.all(color: Colors.black12)
					),
					height: height / 14,
					width: width * .15,
					child: FittedBox
					(
						alignment: Alignment.center,
						child: IconButton
						(
							onPressed: () => null , 
							icon: Icon
							(
								Icons.bookmark,
								color: Color(int.parse("0xffEF5C99"))
							)
						),
					),
				)
			],
		);
	}

	galleryAndFavourites()
	{
		return IntrinsicHeight
		(
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.spaceAround,
				children: 
				[
					IconButton
					(
						onPressed: () => null, 
						icon: Icon
						(
							Icons.photo_album_outlined,
							color: Colors.black54,
						)
					),
					VerticalDivider(color: Colors.grey,width: 1),
					IconButton
					(
						onPressed: () => null, 
						icon: Icon
						(
							Icons.favorite_outline,
							color: Colors.black54,
						)
					)
				],
			)
		);
	}
}