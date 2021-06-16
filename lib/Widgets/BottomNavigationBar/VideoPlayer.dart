import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:hypd/global.dart';

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

	var _controller;

	@override
	void initState()
	{
		_controller = playVideo(url);
		// _controller = VideoPlayerController.network(url.toString());

		// _controller.initialize();
		// _controller.play();
		// isPlaying = true;
		// _controller.setLooping(true);

		// playVideo(url.toString());
		super.initState();
	}

  	@override
  	void dispose() 
	{
    	super.dispose();
    	_controller.pause();
    	_controller.dispose();
  	}

	// playVideo(value)
	// {
	// 	value ? _controller.play() : _controller.pause();
	// }

	@override
	Widget build(BuildContext context)
	{
		return GestureDetector
		(
			child: Container
			(
				color: Colors.black,
				child: VideoPlayer(_controller),
			),
			onTap: ()
			{
				isPlaying ? _controller.pause() : _controller.play();
				setState(()
				{
					isPlaying = !isPlaying;
				});
			}
		);
	}
}