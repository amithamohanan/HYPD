import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget 
{

	final url;
 
  	Player(this.url);
 
	@override
	_PlayerState createState() => _PlayerState(this.url);
}

class _PlayerState extends State<Player> 
{
	_PlayerState(this.url);
	final url;

	late VideoPlayerController _controller;

	@override
	void initState()
	{
		print(url);
		print("url");
		_controller = VideoPlayerController.network(url.toString());

		_controller.addListener(() 
		{
			if (_controller.value.hasError) 
			{
				print(_controller.value.errorDescription);
			}
			if (_controller.value.isInitialized)
			{
				SnackBar(content: Text("Initialised"));
			}
			if (_controller.value.isBuffering)
			{
				SnackBar(content: Text("Buffering"));
			}
		});
		// _controller.initialize();
		_controller.play();
		_controller.setLooping(true);
		super.initState();
	}



	@override
	Widget build(BuildContext context) 
	{
		return videoPlayer();
	}

		// player
	Widget videoPlayer()
	{
		return VideoPlayer(_controller);
	}

}