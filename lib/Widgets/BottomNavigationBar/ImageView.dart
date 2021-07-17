import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyImageView extends StatelessWidget
{

	final String imgPath;
 
  	MyImageView(this.imgPath);
 
  	@override
  	Widget build(BuildContext context) 
	{
    	return Container
		(
			color: Colors.yellow,
			height: MediaQuery.of(context).size.height,
			width: MediaQuery.of(context).size.width,
       		child: FittedBox
			(
         		fit: BoxFit.cover,
         		child: Image.network(imgPath),
       		)
    	);
  	}
}