import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


showSizeModal(context, height, width, size)
{
	return showModalBottomSheet
	(	
		// isScrollControlled: true,
		shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
		context: context,
		builder: (context) 
		{
			return FractionallySizedBox
			(
				heightFactor: 0.7,
				child: Container
				(
					margin: EdgeInsets.only(left: 10, right: 10),
					decoration: BoxDecoration
					(
						borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
					),
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: 
						[
							topButton(),
							SizedBox(height: height / 25,),
							sizeTitle(),
							SizedBox(height: height / 25,),
							selectSizeText(),
							SizedBox(height: 3,),
							chooseSize(height, width, size),
							SizedBox(height: height / 25,),
							submitButton(),
							SizedBox(height: 5,),
						],
					),
				)
			);
		}
	);
}
	topButton()
	{
		return Center
		(
			child: Container
			(
				decoration: BoxDecoration
				(
					color: Colors.grey,
					borderRadius: BorderRadius.circular(5)
				),
				margin: EdgeInsets.only(top: 15),
				height: 4,
				width: 50,
			),
		);
	}


	sizeTitle()
	{
		return Center
		(
			child: Text
			(
				"Details",
				style: GoogleFonts.montserrat
				(
					fontWeight: FontWeight.w500,
					color: Colors.black,
					fontSize: 18
				),
			),
		);
	}

	selectSizeText()
	{
		return Text
		(
			"Select size",
			style: GoogleFonts.montserrat
			(
				fontWeight: FontWeight.w500,
				color: Colors.black38,
				fontSize: 18
			),
		);
	}

	chooseSize(height, width, size)
	{
		return Container
		(
			height: height / 15,
			width: width,
			child: ListView.builder
			(
				scrollDirection: Axis.horizontal,
				itemCount: size.length,
				itemBuilder: (BuildContext context, int index)
				{
					return  Container
					(
						margin: EdgeInsets.only(left: 15),
						height: 30,
						width: 50,
						decoration: BoxDecoration
						(
							border: Border.all(color: Colors.black12),
							borderRadius: BorderRadius.circular(15)
						),
						child: Center
						(
							child: Text
							(
								size[index].toString(),
								style: GoogleFonts.montserrat
								(
									color: Colors.black,
									fontWeight: FontWeight.bold
								),
							),
						)
					);
				}
			),
		);
	}

	submitButton()
	{
		return 
		// Expanded
		// (
		// 	child: 
			Container
			(
				margin: EdgeInsets.only(right: 15),
				height: 50,
				width: double.infinity,
				child: ElevatedButton
				(
					child: Text
					(
						"Done",
						style: TextStyle(fontSize: 14)
					),
					style: ButtonStyle
					(
						foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
						backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xffEF5C99"))),
						shape: MaterialStateProperty.all<RoundedRectangleBorder>
						(
							RoundedRectangleBorder
							(
								borderRadius: BorderRadius.circular(15.5),
								side: BorderSide(color: Colors.white38)
							)
						)
					),
					onPressed: () => null
				)
			// )
		);
	}