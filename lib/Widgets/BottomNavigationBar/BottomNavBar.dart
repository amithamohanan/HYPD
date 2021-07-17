import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/BottomNavigationBar/HomePage.dart';
import 'package:hypd/Widgets/BottomNavigationBar/VideoPlayer.dart';
import 'package:hypd/Widgets/Utilities/LiveSessionPage.dart';
import 'package:hypd/Widgets/UserAccount.dart';
import 'package:hypd/global.dart';

class BottomNavBar extends StatefulWidget
{
	BottomNavBar({this.pageInd});
	final pageInd;

	@override
	_BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
{
    int _currentIndex = 0;
	var currentBackPressTime;
	bool hasNetwork = true;

	late Player playing;

	static List<Widget> _widgetOptions = <Widget>
	[
		HomePage(),
		LiveSession(),
		UserAccount(),
	];

	@override
	void initState()
	{
		super.initState();
		_currentIndex = widget.pageInd != null ? widget.pageInd : 0;
	}

	void _onItemTapped(int index)
	{
		if(_currentIndex != 2)
		{
			playVideo(null);
		}
		if (_currentIndex == index)
		{
			return;
		}

		setState(()
		{
			_currentIndex = index;

			// if(hasNetwork == true)
			// {
				Navigator.push(context,MaterialPageRoute(builder: (context) => _widgetOptions[_currentIndex]));
			// }
			// else
			// {
				// Fluttertoast.showToast(msg: "Lost network connection", backgroundColor: Colors.white, textColor: Colors.black);
				// Navigator.push(context,MaterialPageRoute(builder: (context) => DownloadPage()));
			// }
		});
	}

	@override
	Widget build(BuildContext context)
	{
		return WillPopScope
		(
			child:  BottomNavigationBar
			(
				elevation: 0,
				type: BottomNavigationBarType.fixed,
				backgroundColor: Colors.white,
				items: const <BottomNavigationBarItem>
				[
					BottomNavigationBarItem(label: "", icon: Icon(Icons.home_outlined)),
					BottomNavigationBarItem(label: "", icon: Icon(Icons.smart_display_outlined)),
					BottomNavigationBarItem(label: "", icon: Icon(Icons.account_circle_outlined))
				],
				currentIndex: _currentIndex,
				selectedItemColor: Color(int.parse("0xff352646")),
				unselectedLabelStyle: TextStyle(color: Colors.white),
				unselectedItemColor: Colors.grey,
				onTap: _onItemTapped,
			),
			onWillPop:()
			{
				// showExitConfirm();
				onWillPopScope(_currentIndex);
				return Future.value(true);
			}
		);
	}

	// Handle back press to exit
	Future<bool> onWillPopScope(_currentIndex)
	{
		if(_currentIndex == 0)
		{
			showExitConfirm();
		}
		if(widget.pageInd != 0)
		{
			Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage()));
		}
		else
		{
			DateTime now = DateTime.now();

			if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(milliseconds: 1000))
			{
				currentBackPressTime = now;
				// Fluttertoast.showToast(msg: "Press again to exit.");
				return Future.value(true);
			}
			// return SystemNavigator.pop();
    		// return Future.value(true);
		}

		return Future.value(true);
	}

	showExitConfirm()
	{
		return showModalBottomSheet
		(	
			isScrollControlled: true,
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
			context: context,
			builder: (BuildContext context) 
			{
    			return Padding
				(
        			padding: MediaQuery.of(context).viewInsets,
					child: Container
					(
						decoration: BoxDecoration
						(
							borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
						),
						child: SingleChildScrollView
						(
							child: Form
							(
								// key: _fo/rmKey,
								child:  Column
								(
									mainAxisSize: MainAxisSize.min,
									children: 
									[
										SizedBox(height: 25),
										Text
										(
											"Do you want to Exit?",
											style: GoogleFonts.montserrat
											(
												fontWeight: FontWeight.bold,
												fontSize: 18
											),
										),
										SizedBox(height: 25),
										Container
										(
											child: Row
											(
												children: 
												[
													Expanded
													(
														child: Container
														(
															margin: EdgeInsets.only(bottom:15, left: 15, right: 15 ),
															height: MediaQuery.of(context).size.height / 12,
															width: double.infinity,
															child: ElevatedButton
															(
																child: Text
																(
																	"YES",
																	style: TextStyle(fontSize: 16)
																),
																style: ButtonStyle
																(
																	foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
																	backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xffEF5C99"))),
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
																	SystemNavigator.pop();
																}
															)
														)
													),
													Expanded
													(
														child: Container
														(
															margin: EdgeInsets.only(bottom:15, left: 15, right: 15 ),
															height: MediaQuery.of(context).size.height / 12,
															width: double.infinity,
															child: ElevatedButton
															(
																child: Text
																(
																	"NO",
																	style: TextStyle(fontSize: 16)
																),
																style: ButtonStyle
																(
																	foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
																	backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xffEF5C99"))),
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
																	Navigator.pop(context);
																}
															)
														)
													)
												],
											),
										),
										SizedBox(height: 25),
									],
								)
							)
						)
					)
				);
			}
		);
	}
}