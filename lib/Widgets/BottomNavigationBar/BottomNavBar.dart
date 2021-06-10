import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypd/Widgets/BottomNavigationBar/HomePage.dart';
import 'package:hypd/Widgets/Utilities/LiveSessionPage.dart';
import 'package:hypd/Widgets/UserAccount.dart';

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
  	// final Connectivity _connectivity = Connectivity();
	bool hasNetwork = true;

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
				onWillPopScope(_currentIndex);
				return Future.value(true);
			}
		);
	}

	// Handle back press to exit
	Future<bool> onWillPopScope(_currentIndex)
	{
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
}