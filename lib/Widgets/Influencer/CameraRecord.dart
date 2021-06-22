import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:hypd/Widgets/Influencer/InBottomNavBar.dart';
import 'package:video_player/video_player.dart';

List<CameraDescription> cameras = [];

class CameraApp extends StatefulWidget
{
	@override
	_CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp>
{
	final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

	XFile? videoFile;

	late CameraController controller;
	VideoPlayerController? videoController;
	VoidCallback? videoPlayerListener;


	bool videoRecored = false;

  	@override
  	void initState()
	{
    	super.initState();
  		getCameras();
    	controller = CameraController(cameras[0], ResolutionPreset.max);
    	controller.initialize().then((_)
		{
      		if (!mounted)
			{
        		return;
     		}
      		setState(() {});
    	});
  }

	@override
	void dispose()
	{
		controller.dispose();
		super.dispose();
	}

	getCameras() async
	{
		cameras = await availableCameras();
		setState(() 
		{
		});
	}

	@override
	Widget build(BuildContext context)
	{
		if (!controller.value.isInitialized)
		{
			return Container();
		}
		return  Scaffold
			(
				key: _scaffoldKey,
				body: Stack
				(
					children:
					[
						videoRecored ? _thumbnailWidget() : CameraPreview(controller),
						cameraFlip(),
						_captureControlRowWidget()
					],
				),
				bottomNavigationBar: InBottomNavBar(pageInd: 2),
		);
	}

	// camear flip button
	Widget cameraFlip()
	{
		return Align
		(
			alignment: Alignment.topRight,
			child: IconButton
			(
				icon: Icon(Icons.flip_camera_android_outlined),
				iconSize: 35,
				color: Colors.white,
				onPressed: ()
				{
					controller = CameraController(cameras[1], ResolutionPreset.max);
					controller.initialize().then((_)
					{
						if (!mounted)
						{
							return;
						}
						setState(() {});
					});
				},
			),
		);
	}

	//play and pause button
	/// Display the control bar with buttons to take pictures and record videos.
	Widget _captureControlRowWidget()
	{
		final CameraController? cameraController = controller;

		return Align
		(
			alignment: Alignment.bottomCenter,
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				mainAxisSize: MainAxisSize.max,
				children: <Widget>
				[
					IconButton
					(
						iconSize: 30,
						icon: const Icon(Icons.video_call),
						color: Colors.white,
						onPressed: cameraController != null && cameraController.value.isInitialized && !cameraController.value.isRecordingVideo
						? onVideoRecordButtonPressed
						: null
					),
					IconButton
					(
						iconSize: 30,
						icon: Icon(Icons.pause, color: Colors.white,),
						// cameraController.value.isRecordingPaused ? Icon(Icons.play_arrow) : Icon(Icons.pause),
						onPressed: cameraController != null && cameraController.value.isInitialized && cameraController.value.isRecordingVideo
							? (cameraController.value.isRecordingPaused) ? onResumeButtonPressed : onPauseButtonPressed : null,
					),
					IconButton
					(
						iconSize: 30,
						icon: const Icon(Icons.stop, color: Colors.red),
						onPressed: cameraController != null && cameraController.value.isInitialized && cameraController.value.isRecordingVideo
						? onStopButtonPressed
						: null,
					)
				]
			)
		);
	}

	void onVideoRecordButtonPressed()
	{
		startVideoRecording().then((_)
		{
			if (mounted) setState(() {});
		});
	}

	void onStopButtonPressed()
	{
		stopVideoRecording().then((file)
		{
			if (mounted) setState(() {});
			if (file != null)
			{
				showInSnackBar('Video recorded');
				videoFile = file;
				_startVideoPlayer();
				setState(() 
				{
					videoRecored = true;
				});
			}
		});
	}

	void onPauseButtonPressed()
	{
		pauseVideoRecording().then((_)
		{
			if (mounted) setState(() {});
			showInSnackBar('Video recording paused');
		});
	}

	void onResumeButtonPressed()
	{
		resumeVideoRecording().then((_)
		{
			if (mounted) setState(() {});
			showInSnackBar('Video recording resumed');
		});
	}

	Future<void> startVideoRecording() async
	{
		final CameraController? cameraController = controller;

		if (cameraController == null || !cameraController.value.isInitialized)
		{
			showInSnackBar('Error: select a camera first.');
			return;
		}

		if (cameraController.value.isRecordingVideo)
		{
			// A recording is already started, do nothing.
			return;
		}

		try
		{
			await cameraController.startVideoRecording();
		} on CameraException catch (e)
		{
			_showCameraException(e);
			return;
		}
	}

  	Future<XFile?> stopVideoRecording() async 
	{
    	final CameraController? cameraController = controller;

    	if (cameraController == null || !cameraController.value.isRecordingVideo) 
		{
      		return null;
    	}

    	try
		{
			setState(() {
			  videoRecored = true;
			});
      		return cameraController.stopVideoRecording();

    	}
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		return null;
    	}
  	}

  	Future<void> pauseVideoRecording() async 
	{
    	final CameraController? cameraController = controller;

    	if (cameraController == null || !cameraController.value.isRecordingVideo) 
		{
      		return null;
    	}

    	try 
		{
      		await cameraController.pauseVideoRecording();
    	} 
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		rethrow;
    	}
  	}

  	Future<void> resumeVideoRecording() async 
	{
    	final CameraController? cameraController = controller;

    	if (cameraController == null || !cameraController.value.isRecordingVideo) 
		{
      		return null;
    	}

    	try 
		{
      		await cameraController.resumeVideoRecording();
    	} 
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		rethrow;
    	}
  	}

	Widget _thumbnailWidget()
	{
		final VideoPlayerController? localVideoController = videoController;

		return Container
		(	
			child: localVideoController == null 
			? Container()
			: SizedBox
			(
				child: Container
				(
					margin: EdgeInsets.all(0),
					child: Center
					(
						child: AspectRatio
						(
							aspectRatio:
							localVideoController.value.size != null
							? localVideoController
							.value.aspectRatio
							: 1.0,
							// play the recoreded video
							child: VideoPlayer(localVideoController)
						),
					),
					decoration: BoxDecoration(border: Border.all(color: Colors.pink)),
				),
				width: double.infinity,
				height: double.infinity,
			),
		);
	}

	Future<void> _startVideoPlayer() async 
	{
    	if (videoFile == null) 
		{
      		return;
    	}

    	final VideoPlayerController vController = VideoPlayerController.file(File(videoFile!.path));
    	videoPlayerListener = () 
		{
      		if (videoController != null && videoController!.value.size != null) 
			{
        		// Refreshing the state to update video player with the correct ratio.
        		if (mounted) setState(() {});
        		videoController!.removeListener(videoPlayerListener!);
      		}
    	};
    	vController.addListener(videoPlayerListener!);
    	await vController.setLooping(true);
    	await vController.initialize();
    	await videoController?.dispose();

    	if (mounted) 
		{
      		setState(() 
			{
        		videoController = vController;
      		});
    	}
    	await vController.play();
  	}

	void showInSnackBar(String message)
	{
		// ignore: deprecated_member_use
		_scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  	}

	
	void _showCameraException(CameraException e) 
	{
		logError(e.code, e.description);
		showInSnackBar('Error: ${e.code}\n${e.description}');
	}

	void logError(String code, String? message)
	{
		if (message != null)
		{
			print('Error: $code\nError Message: $message');
		}
		else
		{
			print('Error: $code');
		}
	}

}