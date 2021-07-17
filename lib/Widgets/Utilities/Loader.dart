import 'package:flutter/material.dart';

void popup(BuildContext context)
{
	AlertDialog alert = AlertDialog
	(
		// backgroundColor: Colors.black38,
		content: Column
		(
        	mainAxisAlignment: MainAxisAlignment.center,
        	mainAxisSize: MainAxisSize.min,
        	children: <Widget>
			[
          		SizedBox
				(
					width: 60,
					height: 60,
					child: CircularProgressIndicator
					(
						backgroundColor: Colors.black12,
						valueColor: AlwaysStoppedAnimation(Color(int.parse("0xffEF5C99"))),
					),
          		),
        	],
      	),
	);

	showDialog
	(
		context: context,
		barrierDismissible: false,
		builder: (BuildContext context)
		{
			return alert;
		}
	);
}
