import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hypd/Widgets/Influencer/Influencerdashboard.dart';
import 'package:hypd/Widgets/Influencer/PendingVerification.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/HomePage.dart';
import 'package:hypd/Widgets/Utilities/SnackBar.dart';
import 'package:hypd/global.dart';

class AddUserDetails extends StatefulWidget
{
	@override
	_AddUserDetailsState createState() => _AddUserDetailsState();
}

class _AddUserDetailsState extends State<AddUserDetails>
{
	final _profileKey = GlobalKey<FormState>();

	TextEditingController nameController = new TextEditingController();
	TextEditingController phoneController = new TextEditingController();
	TextEditingController emailController = new TextEditingController();
	TextEditingController dobController = new TextEditingController();
	TextEditingController dateController = new TextEditingController();
	TextEditingController monthController = new TextEditingController();
	TextEditingController yearController = new TextEditingController();

	File _image = new File("");
  	final picker = ImagePicker();

	var height;
	var width;
	var fontSize;

	bool isDateEnter = true;
	bool isFemale = false;
	bool isMale = false;
	bool isOther = false;
	bool isImageUploaded = false;


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
		fontSize = getFontSize(context);
		height = getHeight(context);
		width = getWidth(context);

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
							profileText(),
							SizedBox(height: height / 15,),
							details1(),
							details2(),
							SizedBox(height: height / 22,),
							imageUpload(),
							SizedBox(height: height / 15,),
							textFormField(),
							// SizedBox(height: height / 15,),
							// submitButton()
						],
					)
				),
			),
		);
	}

	Widget profileText()
	{
		return Text
		(
			"Your Profile",
			style: GoogleFonts.montserrat
			(
				fontSize: fontSize / 20,
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
				fontSize: fontSize / 35,
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
				fontSize: fontSize / 35,
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
							child: isImageUploaded ? Image.file(_image, fit: BoxFit.cover,) : SizedBox.shrink()
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
		return  Form
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
					SizedBox(height: height / 15,),
					Text
					(
						"Phone Number",
						style: GoogleFonts.montserrat
						(
							color: Colors.black38,
							fontSize: 12,
						),
					),
					SizedBox(height: height / 25,),
					TextFormField
					(
						keyboardType: TextInputType.phone,
						controller: phoneController,
						maxLength: 10,
						style:  GoogleFonts.montserrat
						(
							fontWeight: FontWeight.bold,
							color: Colors.black,
							fontSize: 12
						),
						decoration: InputDecoration
						(
							errorStyle: GoogleFonts.montserrat
							(
								color: Colors.pink,
								fontSize: 12,
							),
							hintStyle:  GoogleFonts.montserrat
							(
								color: Colors.grey,
								fontSize: 12
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
						onSaved: (value) => phoneController.text = value.toString(),
					),
					SizedBox(height: height / 15,),
					Text
					(
						"Email",
						style: GoogleFonts.montserrat
						(
							color: Colors.black38,
							fontSize: 12,
						),
					),
					SizedBox(height: height / 25,),
					TextFormField
					(
						controller: emailController,
						keyboardType: TextInputType.emailAddress,
						style:  GoogleFonts.montserrat
						(
							fontWeight: FontWeight.bold,
							color: Colors.black,
							fontSize: 12
						),
						decoration: InputDecoration
						(
							hintStyle:  GoogleFonts.montserrat
							(
								color: Colors.grey,
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
								return "*Email cannot be empty";
							}
							else
							{
								if (!value.contains("@"))
								{
									return 'Enter a valid email';
								}
								else
								{
									return null;
								}
							}
						},
						onSaved: (value) => emailController.text = value.toString(),
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
										hintText: "DD",
										hintStyle:  GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w500,
											color: Colors.black26,
											fontSize: fontSize / 35
										),
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
										hintText: "MM",
										hintStyle:  GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w500,
											color: Colors.black26,
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
										hintText: "YYYY",
										hintStyle:  GoogleFonts.montserrat
										(
											fontWeight: FontWeight.w500,
											color: Colors.black26,
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
										var x = date.toString().split("-");
										var temp = x[2].toString().split(" ");

										yearController.text = x[0];
										monthController.text = x[1];
										dateController.text = temp[0];
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
							fontSize: fontSize / 30
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
									});
								}
							)
						],
					),
					SizedBox(height: height / 15,),
					Container
					(
						height: MediaQuery.of(context).size.height / 12,
						width: double.infinity,
						child: ElevatedButton
						(
							child: Text
							(
								"Submit",
								style: TextStyle(fontSize: fontSize / 23)
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

								print(isInfluencer);
								
								if(dateController.text != "0" && monthController.text != "0" && yearController.text != "0")
								{
									setState(()
									{
										isDateEnter = false;
									});
								}
								// if(_profileKey.currentState!.validate())
								// {
									// showSnackBar(context, "Profile Added Successfully");
									!isInfluencer  ? Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()))
									: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PendingVerification()));
								// }
							}
						)
					),
					SizedBox(height: 10),
				],
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
      		} 
			else 
			{
        		print('No image selected.');
      		}
    	});
  	}

}