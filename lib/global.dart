import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';


late VideoPlayerController _controller;

bool isInfluencer = false;

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