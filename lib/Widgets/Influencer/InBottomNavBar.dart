import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypd/Widgets/BottomNavigationBar/VideoPlayer.dart';
import 'package:hypd/Widgets/Influencer/InProfilePage.dart';
import 'package:hypd/Widgets/Influencer/InfluencerShoppinPage.dart';
import 'package:hypd/Widgets/Influencer/InfluencerWatchVideo.dart';
import 'package:hypd/Widgets/Influencer/RecordVideo.dart';
import 'package:hypd/Widgets/Influencer/Test.dart';
import 'package:hypd/global.dart';

class InBottomNavBar extends StatefulWidget
{
	InBottomNavBar({this.pageInd});
	final pageInd;

	@override
	_InBottomNavBarState createState() => _InBottomNavBarState();
}

class _InBottomNavBarState extends State<InBottomNavBar>
{
    int _currentIndex = 0;
	var currentBackPressTime;

	bool hasNetwork = true;

	late Player playing;

	static List<Widget> _widgetOptions = <Widget>
	[
		InfluecnerWatchVideo(),
		InfluencerShoppingPage(false),
		// RecordVideo(),
		Test(),
		InProfilePage(),
	];

	@override
	void initState()
	{
		super.initState();
		_currentIndex = widget.pageInd != null ? widget.pageInd : 0;
	}

	void _onItemTapped(int index)
	{
		print(index);

		if (_currentIndex == index)
		{
			return;
		}

		setState(()
		{
			_currentIndex = index;

			// if(hasNetwork == true)
			// {
				if(_currentIndex != 0)
				{
					playVideo(null);
				}
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
				elevation: 25,
				type: BottomNavigationBarType.fixed,
				backgroundColor: Colors.white,
				items: const <BottomNavigationBarItem>
				[
					BottomNavigationBarItem(label: "", icon: Icon(Icons.home_outlined)),
					BottomNavigationBarItem(label: "", icon: Icon(Icons.shopping_bag_outlined)),
					BottomNavigationBarItem(label: "", icon: Icon(Icons.add_circle_outline_sharp)),
					BottomNavigationBarItem(label: "", icon: Icon(Icons.account_circle_outlined))
				],
				currentIndex: _currentIndex,
				selectedItemColor: Color(int.parse("0xff2d1b57")),
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
			Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => InfluecnerWatchVideo()));
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