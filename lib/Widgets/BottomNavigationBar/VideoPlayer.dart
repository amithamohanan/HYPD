import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypd/global.dart';
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

		_controller.initialize();
		_controller.play();
		isPlaying = true;
		_controller.setLooping(true);
		super.initState();
	}



	@override
	Widget build(BuildContext context)
	{
		return GestureDetector
		(
			child: VideoPlayer(_controller),
			onTap: ()
			{
				isPlaying ? _controller.pause() : _controller.play();
				setState(()
				{
					isPlaying = !isPlaying;
				});
			},
		);
	}
}