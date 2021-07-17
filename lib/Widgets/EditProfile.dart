import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/API/Server.dart';
import 'package:hypd/Widgets/Utilities/Loader.dart';
import 'package:hypd/Widgets/Utilities/SnackBar.dart';
import 'package:hypd/global.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget
{
	@override
	_EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
{
	final _profileKey = GlobalKey<FormState>();

	TextEditingController dateController = new TextEditingController();
	TextEditingController monthController = new TextEditingController();
	TextEditingController yearController = new TextEditingController();
	TextEditingController nameController = new TextEditingController();

	var height;
	var width;
	var fontSize;
	var dob;
	var gender;

	bool isMale = false;
	bool isFemale = false;
	bool isOther = false;
	bool isDateEnter = false;
	bool isImageUploaded = false;

	String image = "";

	File _image = new File("");
  	final picker = ImagePicker();

	@override
	void initState()
	{
		super.initState();
		print(user);
		dob = user["dob"].toString().split("/");
		user["gender"] == "male" ? isMale = true : user["gender"] == "female" ? isFemale = true : isOther = true;
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
			child: scaffold()
		);
	}

	Widget scaffold()
	{
		print(user);
		return Scaffold
		(
			body: Container
			(
				padding: EdgeInsets.all(25),
				height: height,
				width: width,
				child: SingleChildScrollView
				(
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children:
						[
							SizedBox(height: height / 15,),
							closeButton(),
							SizedBox(height: height / 15,),
							profileText(),
							SizedBox(height: height / 15,),
							details1(),
							details2(),
							SizedBox(height: height / 22,),
							imageUpload(),
							SizedBox(height: height / 15,),
							textFormField(),
							SizedBox(height: height / 15,),
							// submitButton()
						],
					)
				),
			),
			// bottomNavigationBar: BottomNavBar(pageInd: 2,),
		);
	}

	Widget closeButton()
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.end,
			children:
			[
				Container
				(
					margin: EdgeInsets.only(top: 5),
					padding: EdgeInsets.all(5),
					decoration: BoxDecoration
					(
						color: Colors.black12,
						borderRadius: BorderRadius.circular(20)
					),
					height: 50,
					width: 50,
					child: FittedBox
					(
						child: IconButton
						(
							iconSize: 25,
							onPressed: ()
							{
								Navigator.pop(context);
							},
							icon: Icon(Icons.close),
							color: Colors.black,
						),
					),
				)
			],
		);
	}


	Widget profileText()
	{
		return Text
		(
			"Your Profile",
			style: GoogleFonts.montserrat
			(
				fontSize: 25,
			),
		);
	}

	Widget details1()
	{
		return Text
		(
			"Enter the following details and",
			style: GoogleFonts.montserrat
			(
				fontSize: 12,
				color: Colors.black38
			),
		);
	}

	Widget details2()
	{
		return Text
		(
			"get connected...",
			style: GoogleFonts.montserrat
			(
				fontSize: 12,
				color: Colors.black38
			),
		);
	}

	Widget imageUpload()
	{
		return Stack
		(
			children:
			[
				Container
				(
					height: 100,
					width: 100,
					child: Container
					(
						margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
						height: 50,
						width: 60,
						decoration: BoxDecoration
						(
							color: Colors.black,
							borderRadius: BorderRadius.circular(25)
						),
						child: ClipRRect
						(
							borderRadius: BorderRadius.circular(15),
							child: isImageUploaded ? Image.file(_image, fit: BoxFit.fill,) : Image.network(user["image"].toString(), fit: BoxFit.fill)
						)
					),
				),
				Positioned
				(
					bottom: 3,
					right: 0,
					child: CircleAvatar
					(
						backgroundColor: Color(int.parse("0xffEF5C99")),
						child: IconButton
						(
							color: Colors.white,
							onPressed: () => _onButtonPressed(),
							icon: Icon(Icons.camera_alt)
						)
					)
				)
			],
		);
	}

	Widget textFormField()
	{
		return Form
		(
			key: _profileKey,
			child: Column
			(
				crossAxisAlignment: CrossAxisAlignment.start,
				children:
				[
					Text
					(
						"Your Full Name",
						style: GoogleFonts.montserrat
						(
							color: Colors.black38,
							fontSize: 12,
						),
					),
					SizedBox(height: height / 25,),
					TextFormField
					(
						keyboardType: TextInputType.name,
						controller: nameController,
						style:  GoogleFonts.montserrat
						(
							fontWeight: FontWeight.bold,
							color: Colors.black,
							fontSize: 12
						),
						decoration: InputDecoration
						(
							hintText: user["name"].toString() == "null" ? "" : user["name"].toString(),
							hintStyle:  GoogleFonts.montserrat
							(
								fontWeight: FontWeight.bold,
								color: Colors.black,
								fontSize: 12
							),
							errorStyle: GoogleFonts.montserrat
							(
								color: Colors.pink,
								fontSize: 12,
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
								return "*Name cannot be empty";
							}
						},
						onSaved: (value) => nameController.text = value.toString(),
					),
					SizedBox(height: height / 25,),
					Text
					(
						"Date of birth",
						style: GoogleFonts.montserrat
						(
							color: Colors.black38,
							fontSize: 12,
						),
					),
					SizedBox(height: height / 25,),
					Row
					(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children:
						[
							Container
							(
								height: 25,
								width: 25,
								child: TextFormField
								(
									controller: dateController,
									keyboardType: TextInputType.number,
									maxLength: 2,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									textAlign: TextAlign.center,
									decoration: InputDecoration
									(
										hintStyle:  GoogleFonts.montserrat
										(
											fontWeight: FontWeight.bold,
											color: Colors.black,
											fontSize: 12
										),
										hintText: user["dob"].toString() == "null" ? "DD" : dob[2],
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										isDense: true,
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
									onSaved: (value) => dateController.text = value.toString(),
								),
							),
							SizedBox(width: 5,),
							Container
							(
								height: 25,
								width: 25,
								child: TextFormField
								(
									controller: monthController,
									keyboardType: TextInputType.number,
									maxLength: 2,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									textAlign: TextAlign.center,
									decoration: InputDecoration
									(
										hintText: user["dob"].toString() == "null" ? "MM" : dob[1],
										hintStyle:  GoogleFonts.montserrat
										(
											fontWeight: FontWeight.bold,
											color: Colors.black,
											fontSize: fontSize / 35
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										isDense: true,
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
								),
							),
							SizedBox(width: 5,),
							Container
							(
								height: 25,
								width: 40,
								child: TextFormField
								(
									controller: yearController,
									keyboardType: TextInputType.number,
									maxLength: 4,
									style:  GoogleFonts.montserrat
									(
										fontWeight: FontWeight.bold,
										color: Colors.black,
										fontSize: 12
									),
									textAlign: TextAlign.center,
									decoration: InputDecoration
									(
										hintText: user["dob"].toString() == "null" ? "YYYY" : dob[0],
										hintStyle:  GoogleFonts.montserrat
										(
											fontWeight: FontWeight.bold,
											color: Colors.black,
											fontSize: fontSize / 35
										),
										counterText: "",
										contentPadding: EdgeInsets.all(0),
										isDense: true,
										enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
										focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
									),
								),
							),
							SizedBox(width: width / 3),
							Container
							(
								child: IconButton
								(
									color: isDateEnter ? Colors.black12 : Color(int.parse("0xffEF5C99")),
									icon: Icon(Icons.calendar_today_outlined),
									onPressed: () async
									{
										FocusScope.of(context).requestFocus(new FocusNode());
										var date = await showDatePicker
										(
											context: context,
											initialDate:DateTime.now(),
											firstDate:DateTime(1900),
											lastDate: DateTime(2100)
										);
										var x = date.toString().split("-").join("/");
										var temp = x.split(" ");
										var temp1  = temp[0].toString().split("/");

										dob = temp[0].toString();

										yearController.text = temp1[0];
										monthController.text = temp1[1];
										dateController.text = temp1[2];
									},
								),
							)
						],
					),
					SizedBox(height: height / 25,),
					Text
					(
						"Gender",
						style: GoogleFonts.montserrat
						(
							color: Colors.black38,
							fontSize: 12,
						),
					),
					Row
					(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children:
						[
							OutlinedButton
							(
								child: Text
								(
									"Male",
									style: GoogleFonts.montserrat
									(
										fontSize: fontSize / 30,
										color: isMale ? Colors.white : Colors.black26
									),
								),
								style: ButtonStyle
								(
									backgroundColor: isMale ? MaterialStateProperty.all<Color>(Color(int.parse("0xffEF5C99"))) :  MaterialStateProperty.all<Color>(Colors.white),
								),
								onPressed: ()
								{
									setState(()
									{
										isMale = true;
										isOther = false;
										isFemale = false;
										gender = "male";
									});
								}
							),
							OutlinedButton
							(
								child: Text
								(
									"Female",
									style: GoogleFonts.montserrat
									(
										fontSize: fontSize / 30,
										color: isFemale ? Colors.white : Colors.black26
									),
								),
								style: ButtonStyle
								(
									backgroundColor: isFemale ? MaterialStateProperty.all<Color>(Color(int.parse("0xffEF5C99"))) :  MaterialStateProperty.all<Color>(Colors.white),
								),
								onPressed: ()
								{
									setState(()
									{
										isFemale = true;
										isMale = false;
										isOther = false;
										gender = "female";
									});
								}
							),
							OutlinedButton
							(
								style: ButtonStyle
								(
									backgroundColor: isOther ? MaterialStateProperty.all<Color>(Color(int.parse("0xffEF5C99"))) :  MaterialStateProperty.all<Color>(Colors.white),
								),
								child: Text
								(
									"Other",
									style: GoogleFonts.montserrat
									(
										fontSize: fontSize / 35,
										color: isOther ? Colors.white : Colors.black26
									),
								),
								onPressed: ()
								{
									setState(()
									{
										isOther = true;
										isMale = false;
										isFemale = false;
										gender = "other";
									});
								}
							)
						],
					),
					SizedBox(height: 20),
					Center
					(
						child: Container
						(
							height: height / 14,
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
								onPressed: ()
								{
									popup(context);
									editProfile();
								}

							)
						)
					),
					SizedBox(height: 10)
				]
			)
		);
	}

	//Show bottom sheet
	void _onButtonPressed()
	{
		showModalBottomSheet
		(
			context: context,
			builder: (builder)
			{
				return  Container
				(
					height: 190.0,
					color: Colors.transparent, //could change this to Color(0xFF737373),
					child: new Container
					(
						decoration: new BoxDecoration
						(
							color: Color.fromRGBO(34, 34, 34, 1.0),
							borderRadius: new BorderRadius.only
							(
								topLeft: const Radius.circular(10.0),
								topRight: const Radius.circular(10.0)
							)
						),
						child: bottomSheet()
					),
				);
			}
		);
	}

	// Creating bottom sheet for selecting profile picture
	Widget bottomSheet()
	{
		return Container
		(
			child: Column
			(
				children: <Widget>
				[
					InkWell
					(
						onTap: ()
						{
							getCameraImage();
							Navigator.pop(context);
						},
						child: Padding
						(
							padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
							child: Row
							(
								crossAxisAlignment: CrossAxisAlignment.center,
								mainAxisAlignment: MainAxisAlignment.start,
								children: <Widget>
								[
									Icon(Icons.camera, color: Color.fromRGBO(34,34,34,1.0), size: 35,),
									Container
									(
										width: 250.0,
										child:  ListTile
										(
											title: Text('Camera',style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1.0)),),
											subtitle: Text("Click profile picture from camera.",style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1.0)),),
										),
									)
								],
							),
						)
					),
					InkWell
					(
						onTap: ()
						{
							getGalleryImage();
							Navigator.pop(context);
						},
						child: Padding
						(
							padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
							child: Row
							(
								crossAxisAlignment: CrossAxisAlignment.center,
								mainAxisAlignment: MainAxisAlignment.start,
								children: <Widget>
								[
									Icon(Icons.photo, color: Color.fromRGBO(34,34,34,1.0), size: 35,),
									Container
									(
										width: 260.0,
										child:  ListTile
										(
											title: Text('Gallery',style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1.0)),),
											subtitle: Text("Choose profile picture from gallery.",style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1.0))),
										),
									)
								],
							),
						)
					),
				],
			),
			decoration: BoxDecoration
			(
				color: Colors.white,
				borderRadius: BorderRadius.only
				(
					topLeft: const Radius.circular(10.0),
					topRight: const Radius.circular(10.0),
				),
			),
		);
	}

	Future getGalleryImage() async
	{
    	final pickedFile = await picker.getImage(source: ImageSource.gallery);

    	setState(()
		{
      		if (pickedFile != null)
			{
        		_image = File(pickedFile.path);
				isImageUploaded = true;
				image = pickedFile.path;
      		}
			else
			{
        		print('No image selected.');
      		}
    	});
  	}

	Future getCameraImage() async
	{
    	final pickedFile = await picker.getImage(source: ImageSource.camera);

    	setState(()
		{
      		if (pickedFile != null)
			{
        		_image = File(pickedFile.path);
				isImageUploaded = true;
				image = pickedFile.path;
				print(image);
      		}
			else
			{
        		print('No image selected.');
      		}
    	});
  	}

	editProfile() async
	{

		var response = await Server.editUserDetails(nameController.text, gender, dob, image);

		if(response == "User Added Successfully")
		{
			var userData = await Server.getUserDetails(user["id"]);

			print(userData);
			print("USERDATA");

			Navigator.pop(context);
			showSnackBar(context, "Updated");
		}
		else
		{
			showPopup("error", "Updating Failed", context);
		}
	}
}