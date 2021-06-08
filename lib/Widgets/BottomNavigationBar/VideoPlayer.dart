import 'package:flutter/cupertino.dart';
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
		_controller = VideoPlayerController.asset("assets/images/introPlayer.mp4");
		_controller.initialize();
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