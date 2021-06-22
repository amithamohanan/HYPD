import 'dart:io';
// import 'package:camerawesome/camerawesome_plugin.dart';
// import 'package:camerawesome/video_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hypd/Widgets/Influencer/InBottomNavBar.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_player/video_player.dart';


// class RecordVideo extends StatefulWidget
// {
// 	@override
// 	_RecordVideoState createState() => _RecordVideoState();
// }

// class _RecordVideoState extends State<RecordVideo>
// {
	
// 	bool randomPhotoName = true;

// 	late VideoPlayerController _controller = VideoPlayerController.network("");

// 	late VideoController _videoController;
// 	PictureController _pictureController = new PictureController();


// 	ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.PHOTO);
// 	ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
// 	ValueNotifier<Size> _photoSize = ValueNotifier(Size.infinite);

// 	File video = new File("");
//   	final picker = ImagePicker();

// 	var height;
// 	var width;

// 	bool isVideoUploaded = false;
// 	bool isVideoPlaying = false;
// 	bool isButtonPressed = true;
// 	bool _isRecordingVideo = false;

// 	String _lastVideoPath = "";

// 	@override
// 	void initState()
// 	{
// 		super.initState();
// 		_controller.initialize();
// 	}

// 	@override
// 	void dispose()
// 	{
// 		_controller.dispose();
// 		super.dispose();
// 	}

// 	@override
// 	Widget build(BuildContext context)
// 	{
// 		height = MediaQuery.of(context).size.height;
// 		width = MediaQuery.of(context).size.width;


// 		return SafeArea
// 		(
// 			top: !isVideoUploaded ? false : true,
// 			bottom: true,
// 			child: Scaffold
// 			(
// 				backgroundColor: Colors.white,
// 				body: !isVideoUploaded
// 					? videoViewer()
// 					: Center
// 					(
// 						child: GestureDetector
// 						(
// 							child: Text
// 							(
// 								"Tap to record a video"
// 							),
// 							onTap: ()
// 							{
// 								popUpModal(context);
// 							},
// 						),
// 					),
// 				bottomNavigationBar: InBottomNavBar(pageInd: 2,),
// 			)
// 		);
// 	}

// 	// play the video after recoding
// 	videoPlayer()
// 	{
// 		return Container
// 		(
// 			height: height,
// 			width: width,
// 			child: 	Stack
// 			(
// 				children:
// 				[
// 					VideoPlayer(_controller),
// 					Align
// 					(
// 						alignment: Alignment.bottomCenter,
// 						child: IconButton
// 						(
// 							onPressed: ()
// 							{
// 								isVideoPlaying ? _controller.pause() : _controller.play();
// 								setState(()
// 								{
// 									isVideoPlaying = !isVideoPlaying;
// 								});
// 							},
// 							icon: isVideoPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
// 							color: Colors.white,
// 							iconSize: 35,
// 						),
// 					),
// 					Align
// 					(
// 						alignment: Alignment.topRight,
// 						child: IconButton
// 						(
// 							onPressed: ()
// 							{
// 								exitVideo(context);
// 							},
// 							icon: Icon(Icons.close),
// 							color: Colors.white,
// 							iconSize: 35,
// 						),
// 					),
// 				],
// 			),
// 		);
// 	}

// 	// get video from gallery
// 	Future getGalleryVideo() async
// 	{
//     	final pickedFile = await picker.getVideo(source: ImageSource.gallery);

//     	setState(()
// 		{
//       		if (pickedFile != null)
// 			{
//         		video = File(pickedFile.path);
// 				isVideoUploaded = true;
// 				_controller = VideoPlayerController.file(video)..initialize();
// 				_controller.setVolume(0);
// 				_controller.play();
// 				_controller.setLooping(true);

// 				setState(()
// 				{
// 					isVideoPlaying = true;
// 				});

//       		}
// 			else
// 			{
//         		print('No image selected.');
//       		}
//     	});
//   	}

// 	// record the video instantly
// 	Future getCameraVideo() async
// 	{
//     	final pickedFile = await picker.getVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 30));

//     	setState(()
// 		{
//       		if (pickedFile != null)
// 			{
//         		video = File(pickedFile.path);
// 				isVideoUploaded = true;
// 				_controller = VideoPlayerController.file(video)..initialize();
// 				_controller.setVolume(0);
// 				_controller.play();
// 				_controller.setLooping(true);

// 				setState(()
// 				{
// 					isVideoPlaying = true;
// 				});
//       		}
// 			else
// 			{
//         		print('No image selected.');
//       		}
//     	});
//   	}



// 	// play the captured video
// 	videoViewer()
// 	{
// 		return Container
// 		(
// 			height: height,
// 			width: width,
// 			child: Stack
// 			(
// 				children: 
// 				[
					
// 					Align
// 					(
// 						alignment: Alignment.bottomCenter,
// 						child: IconButton
// 						(
// 							onPressed: () async
// 							{
// 								var filePath = getApplicationDocumentsDirectory();
// 								await _videoController.recordVideo(filePath.toString());
// 							},
// 							icon: isVideoPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
// 							color: Colors.white,
// 							iconSize: 35,
// 						),
// 					),
// 					Align
// 					(
// 						alignment: Alignment.topRight,
// 						child: IconButton
// 						(
// 							onPressed: ()
// 							{
// 								var filePath = getApplicationDocumentsDirectory();
// 								_videoController.recordVideo(filePath.toString());
// 							},
// 							icon: Icon(Icons.close),
// 							color: Colors.white,
// 							iconSize: 35,
// 						),
// 					),
// 				],
// 			),
// 		);
// 	}


// 	// built inteface
	
// 	// show options to choose from gallery or live recording
// 	popUpModal(context)
// 	{
// 		return showModalBottomSheet
// 		(
// 			isScrollControlled: false,
// 			shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
// 			context: context,
// 			builder: (BuildContext context)
// 			{
//     			return Padding
// 				(
//         			padding: MediaQuery.of(context).viewInsets,
// 					child: Container
// 					(
// 						decoration: BoxDecoration
// 						(
// 							borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
// 						),
// 						child: Column
// 						(
// 							mainAxisSize: MainAxisSize.min,
// 							children:
// 							[
// 								Padding
// 								(
// 									padding: EdgeInsets.only(left: 15, right: 15),
// 									child: Row
// 									(
// 										mainAxisAlignment: MainAxisAlignment.spaceBetween,
// 										children:
// 										[
// 											Text
// 											(
// 												"Create",
// 												style: GoogleFonts.montserrat
// 												(
// 													fontWeight: FontWeight.w300,
// 													color: Colors.black38,
// 													fontSize: 15
// 												),
// 											),
// 											IconButton
// 											(
// 												onPressed: () => Navigator.pop(context),
// 												icon: Icon(Icons.close),
// 												color: Colors.black38,
// 											)
// 										],
// 									),
// 								),
// 								Divider(),
// 								ListTile
// 								(
// 									leading: Icon(Icons.upload),
// 									title: Text
// 									(
// 										"Upload a video",
// 										style: GoogleFonts.montserrat
// 										(
// 											fontWeight: FontWeight.w300,
// 											color: Colors.black38,
// 											fontSize: 15
// 										),
// 									),
// 									onTap: () => getGalleryVideo(),
// 								),
// 								Divider(),
// 								ListTile
// 								(
// 									leading: Icon(Icons.camera_alt_outlined),
// 									title: Text
// 									(
// 										"Create a short",
// 										style: GoogleFonts.montserrat
// 										(
// 											fontWeight: FontWeight.w300,
// 											color: Colors.black38,
// 											fontSize: 15
// 										),
// 									),
// 									onTap: () => getCameraVideo(),
// 								)
// 							],
// 						)
// 					)
// 				);
// 			}
// 		);
// 	}

// 	// close and exit video
// 	exitVideo(context)
// 	{
// 		return showDialog
// 		(
// 			context: context,
// 			builder: (BuildContext context)
// 			{
// 				return AlertDialog
// 				(
// 					title: Text
// 					(
// 						"Discard all changes!",
// 						style: GoogleFonts.montserrat
// 						(
// 							color: Colors.black38,
// 							fontSize: 15
// 						),
// 					),
// 					content: Text
// 					(
// 						"Do you want to cancel the video?",
// 						style: GoogleFonts.montserrat
// 						(
// 							color: Colors.black38,
// 							fontSize: 15
// 						),
// 					),
// 					actions: 
// 					[
// 						continueButton(context),
// 						cancelButton(context)
// 					],
// 				);
// 			},
// 		);
// 	}

// 	continueButton(context) => TextButton
// 	(
//     	child: Text
// 		(
// 			"Continue",
// 			style: GoogleFonts.montserrat
// 			(
// 				color: Colors.black38,
// 				fontSize: 15
// 			),
// 		),
//     	onPressed: ()
// 		{
// 			Navigator.pop(context);
// 		},
//   	);

// 	cancelButton(context) => TextButton
// 	(
//     	child: Text
// 		(
// 			"Cancel",
// 			style: GoogleFonts.montserrat
// 			(
// 				color: Colors.black38,
// 				fontSize: 15
// 			),
// 		),
//     	onPressed: ()
// 		{
// 			video.delete();
// 			Navigator.pop(context);
// 			setState(() 
// 			{
// 				isVideoUploaded = false;
// 			});
// 		},
//   	);
// }


























import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypd/Widgets/Influencer/InBottomNavBar.dart';
import 'package:hypd/global.dart';
import 'package:video_player/video_player.dart';

class RecordVideo extends StatefulWidget
{
	@override
	_RecordVideoState createState()
	{
		return _RecordVideoState();
  	}
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction)
{
  	switch (direction)
	{
    	case CameraLensDirection.back:
      		return Icons.camera_rear;
		case CameraLensDirection.front:
      		return Icons.camera_front;
    	case CameraLensDirection.external:
      		return Icons.camera;
		default:
			throw ArgumentError('Unknown lens direction');
  	}
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

class _RecordVideoState extends State<RecordVideo> with WidgetsBindingObserver, TickerProviderStateMixin
{

	List<CameraDescription> cameras = [];

	CameraController? controller;
	XFile? imageFile;
	XFile? videoFile;

	VideoPlayerController? videoController;
	VoidCallback? videoPlayerListener;

	late AnimationController _flashModeControlRowAnimationController;
	late Animation<double> _flashModeControlRowAnimation;
	late AnimationController _exposureModeControlRowAnimationController;
	late Animation<double> _exposureModeControlRowAnimation;
	late AnimationController _focusModeControlRowAnimationController;
	late Animation<double> _focusModeControlRowAnimation;

	double _minAvailableZoom = 1.0;
	double _maxAvailableZoom = 1.0;
	double _currentScale = 1.0;
	double _baseScale = 1.0;
	double _minAvailableExposureOffset = 0.0;
	double _maxAvailableExposureOffset = 0.0;
	double _currentExposureOffset = 0.0;

	bool enableAudio = true;
	bool isCameraFrontSelected = false;
	bool videoRecored = false;
	bool isPlayingVideo = true;
	// Counting pointers (number of user fingers on screen)
	int _pointers = 0;

	var height;
	var width;

	@override
	void initState()
	{
		super.initState();
		WidgetsBinding.instance?.addObserver(this);


		getCameras();

		_flashModeControlRowAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
		_flashModeControlRowAnimation = CurvedAnimation(parent: _flashModeControlRowAnimationController, curve: Curves.easeInCubic);
		_exposureModeControlRowAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
		_exposureModeControlRowAnimation = CurvedAnimation(parent: _exposureModeControlRowAnimationController, curve: Curves.easeInCubic);
		_focusModeControlRowAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
		_focusModeControlRowAnimation = CurvedAnimation(parent: _focusModeControlRowAnimationController, curve: Curves.easeInCubic);
	}

	getCameras() async
	{
		cameras = await availableCameras();
		setState(() 
		{
			onNewCameraSelected(cameras[0]);
		});
	}

	@override
	void dispose()
	{
		WidgetsBinding.instance?.removeObserver(this);
		_flashModeControlRowAnimationController.dispose();
		_exposureModeControlRowAnimationController.dispose();
		super.dispose();
	}

	@override
	void didChangeAppLifecycleState(AppLifecycleState state)
	{
		final CameraController? cameraController = controller;

		// App state changed before we got the chance to initialize.
		if (cameraController == null || !cameraController.value.isInitialized)
		{
			return;
		}

		if (state == AppLifecycleState.inactive)
		{
			cameraController.dispose();
		}
		else if (state == AppLifecycleState.resumed)
		{
			onNewCameraSelected(cameraController.description);
		}
	}

		final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

	@override
	Widget build(BuildContext context)
	{
		SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
		

		height = getHeight(context);
		width = getWidth(context);

		return SafeArea
		(
			top: true,
			bottom: true,
			child: videoRecored ? playVideo()
			: Scaffold
			(
				key: _scaffoldKey,
				body: Stack
				(
					children: <Widget>
					[
						Container
						(
							height: height,
							width: width,
							child: _cameraPreviewWidget(),
							decoration: BoxDecoration
							(
								color: Colors.black,
							),
						),
						_captureControlRowWidget(),
						Align
						(
							alignment: Alignment.bottomRight,
							child: Padding
							(
								padding: EdgeInsets.only(bottom: 70),
								child:  _modeControlRowWidget(),
							)
						),
						_cameraTogglesRowWidget(),
						// _thumbnailWidget(),

					],
				),
				// bottomNavigationBar: InBottomNavBar(pageInd: 2,),
			)
		);
	}

	playVideo()
	{
		final VideoPlayerController? localVideoController = videoController;

		localVideoController?.setVolume(0.0);

		return localVideoController == null 
			? Container()
			: Scaffold
			(
				body: Container
				(
					width: width,
					height: height,
					child: Stack
					(
						children: 
						[
							VideoPlayer(localVideoController),
							Align
							(
								alignment: Alignment.bottomCenter,
								child: IconButton
								(
									onPressed: ()
									{
										isPlayingVideo ? localVideoController.pause() : localVideoController.play();
										setState(() 
										{
											isPlayingVideo = !isPlayingVideo;
										});
									}, 
									icon: isPlayingVideo ? Icon(Icons.pause) : Icon(Icons.play_arrow),
									color: Colors.white,
									iconSize: 40,
								),
							),
							Align
							(
								alignment: Alignment.topRight,
								child: IconButton
								(
									onPressed: ()
									{
										exitVideo(context);
									}, 
									icon: Icon(Icons.close),
									color: Colors.white,
									iconSize: 30,
								),
							)
						],
					),
					decoration: BoxDecoration
					(
						border: Border.all(color: Colors.pinkAccent, width: 2)
					),
				),
			);
	}

		// close and exit video
	exitVideo(context)
	{
		return showDialog
		(
			context: context,
			builder: (BuildContext context)
			{
				return AlertDialog
				(
					title: Text
					(
						"Discard all changes!",
						style: GoogleFonts.montserrat
						(
							color: Colors.black38,
							fontSize: 15
						),
					),
					content: Text
					(
						"Do you want to cancel the video?",
						style: GoogleFonts.montserrat
						(
							color: Colors.black38,
							fontSize: 15
						),
					),
					actions: 
					[
						continueButton(context),
						cancelButton(context)
					],
				);
			},
		);
	}

	continueButton(context) => TextButton
	(
    	child: Text
		(
			"Continue",
			style: GoogleFonts.montserrat
			(
				color: Colors.black38,
				fontSize: 15
			),
		),
    	onPressed: ()
		{
			Navigator.pop(context);
		},
  	);

	cancelButton(context) => TextButton
	(
    	child: Text
		(
			"Cancel",
			style: GoogleFonts.montserrat
			(
				color: Colors.black38,
				fontSize: 15
			),
		),
    	onPressed: ()
		{
			
			Navigator.pop(context);
			setState(() 
			{
				isPlayingVideo = false;
				videoRecored = false;
			});
		},
  	);

  /// Display the preview from the camera (or a message if the preview is not available).
	Widget _cameraPreviewWidget()
	{
		final CameraController? cameraController = controller;

		if (cameraController == null || !cameraController.value.isInitialized)
		{
			return const Text
			(
				'Tap a camera',
				style: TextStyle
				(
					color: Colors.white,
					fontSize: 24.0,
					fontWeight: FontWeight.w900,
				),
			);
		}
		else
		{
			return Listener
			(
				onPointerDown: (_) => _pointers++,
				onPointerUp: (_) => _pointers--,
				child: CameraPreview
				(
					controller!,
					child: LayoutBuilder
					(
						builder: (BuildContext context, BoxConstraints constraints)
						{
							return GestureDetector
							(
								behavior: HitTestBehavior.opaque,
								onScaleStart: _handleScaleStart,
								onScaleUpdate: _handleScaleUpdate,
								onTapDown: (details) => onViewFinderTap(details, constraints),
							);
						}
					),
				),
			);
		}
	}

	void _handleScaleStart(ScaleStartDetails details)
	{
	_baseScale = _currentScale;
	}

	Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async
	{
    	// When there are not exactly two fingers on screen don't scale
    	if (controller == null || _pointers != 2)
		{
      		return;
    	}
		_currentScale = (_baseScale * details.scale).clamp(_minAvailableZoom, _maxAvailableZoom);

		await controller!.setZoomLevel(_currentScale);
  	}

	/// Display the thumbnail of the captured image or video.
	Widget _thumbnailWidget()
	{
		final VideoPlayerController? localVideoController = videoController;

		return Expanded
		(
			child: Align
			(
				alignment: Alignment.centerRight,
				child: Row
				(
					mainAxisSize: MainAxisSize.min,
					children: <Widget>
					[
						localVideoController == null && imageFile == null
						? Container()
						: SizedBox
						(
							child: (localVideoController == null)
							? Image.file(File(imageFile!.path))
							: Container
							(
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
							width: 64.0,
							height: 64.0,
						),
					],
				),
			),
		);
	}

	/// Display a bar with buttons to change the flash and exposure modes
	Widget _modeControlRowWidget()
	{
		return Column
		(
			mainAxisAlignment: MainAxisAlignment.end,
			crossAxisAlignment: CrossAxisAlignment.end,
			children:
			[
				Column
				(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					mainAxisSize: MainAxisSize.max,
					children: <Widget>
					[
						IconButton
						(
							iconSize: 30,
							icon: Icon(Icons.flash_on),
							color: Colors.white,
							onPressed: controller != null ? onFlashModeButtonPressed : null,
						),
						IconButton
						(
							iconSize: 30,
							icon: Icon(Icons.exposure),
							color: Colors.white,
							onPressed:
							controller != null ? onExposureModeButtonPressed : null,
						),
						IconButton
						(
							iconSize: 30,
							icon: Icon(Icons.filter_center_focus),
							color: Colors.white,
							onPressed: controller != null ? onFocusModeButtonPressed : null,
						),
					],
				),
				_flashModeControlRowWidget(),
				_exposureModeControlRowWidget(),
				_focusModeControlRowWidget(),
			],
		);
	}

	// flash controls
	Widget _flashModeControlRowWidget()
	{
		return SizeTransition
		(
			sizeFactor: _flashModeControlRowAnimation,
			child: ClipRect
			(
				child: Row
				(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					mainAxisSize: MainAxisSize.max,
					children:
					[
						IconButton
						(
							icon: Icon(Icons.flash_off),
							color: controller?.value.flashMode == FlashMode.off
							? Colors.orange
							: Colors.white,
							onPressed: controller != null
							? () => onSetFlashModeButtonPressed(FlashMode.off)
							: null,
						),
						IconButton
						(
							icon: Icon(Icons.flash_auto),
							color: controller?.value.flashMode == FlashMode.auto
							? Colors.orange
							: Colors.white,
							onPressed: controller != null
							? () => onSetFlashModeButtonPressed(FlashMode.auto)
							: null,
						),
						IconButton
						(
							icon: Icon(Icons.flash_on),
							color: controller?.value.flashMode == FlashMode.always
							? Colors.orange
							: Colors.white,
							onPressed: controller != null
							? () => onSetFlashModeButtonPressed(FlashMode.always)
							: null,
						),
						IconButton
						(
							icon: Icon(Icons.highlight),
							color: controller?.value.flashMode == FlashMode.torch
							? Colors.orange
							: Colors.white,
							onPressed: controller != null
							? () => onSetFlashModeButtonPressed(FlashMode.torch)
							: null,
						),
					],
				),
			),
		);
	}

	Widget _exposureModeControlRowWidget()
	{
		final ButtonStyle styleAuto = TextButton.styleFrom
		(
			primary: controller?.value.exposureMode == ExposureMode.auto
			? Colors.orange
			: Colors.blue,
		);

		final ButtonStyle styleLocked = TextButton.styleFrom
		(
			primary: controller?.value.exposureMode == ExposureMode.locked
			? Colors.orange
			: Colors.blue,
		);

		return SizeTransition
		(
			sizeFactor: _exposureModeControlRowAnimation,
			child: ClipRect
			(
				child: Container
				(
					color: Colors.grey.shade50,
					child: Column
					(
						children:
						[
							Center
							(
								child: Text("Exposure Mode"),
							),
							Row
							(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								mainAxisSize: MainAxisSize.max,
								children:
								[
									TextButton
									(
										child: Text('AUTO'),
										style: styleAuto,
										onPressed: controller != null
										? () => onSetExposureModeButtonPressed(ExposureMode.auto)
										: null,
										onLongPress: ()
										{
											if (controller != null)
											{
												controller!.setExposurePoint(null);
												showInSnackBar('Resetting exposure point');
											}
										},
									),
									TextButton
									(
										child: Text('LOCKED'),
										style: styleLocked,
										onPressed: controller != null
										? () => onSetExposureModeButtonPressed(ExposureMode.locked)
										: null
									),
								],
							),
							Center
							(
								child: Text("Exposure Offset"),
							),
							Row
							(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								mainAxisSize: MainAxisSize.max,
								children:
								[
									Text(_minAvailableExposureOffset.toString()),
									Slider
									(
										value: _currentExposureOffset,
										min: _minAvailableExposureOffset,
										max: _maxAvailableExposureOffset,
										label: _currentExposureOffset.toString(),
										onChanged: _minAvailableExposureOffset ==
										_maxAvailableExposureOffset
										? null
										: setExposureOffset,
									),
									Text(_maxAvailableExposureOffset.toString()),
								],
							),
						],
					),
				),
			),
		);
	}

	Widget _focusModeControlRowWidget()
	{
		final ButtonStyle styleAuto = TextButton.styleFrom
		(
			primary: controller?.value.focusMode == FocusMode.auto
			? Colors.orange
			: Colors.blue,
		);

		final ButtonStyle styleLocked = TextButton.styleFrom
		(
			primary: controller?.value.focusMode == FocusMode.locked
			? Colors.orange
			: Colors.blue,
		);

		return SizeTransition
		(
			sizeFactor: _focusModeControlRowAnimation,
			child: ClipRect
			(
				child: Container
				(
					color: Colors.grey.shade50,
					child: Column
					(
						children:
						[
							Center
							(
								child: Text("Focus Mode"),
							),
							Row
							(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								mainAxisSize: MainAxisSize.max,
								children:
								[
									TextButton
									(
										child: Text('AUTO'),
										style: styleAuto,
										onPressed: controller != null
										? () => onSetFocusModeButtonPressed(FocusMode.auto)
										: null,
										onLongPress: ()
										{
											if (controller != null) controller!.setFocusPoint(null);
											showInSnackBar('Resetting focus point');
										},
									),
									TextButton
									(
										child: Text('LOCKED'),
										style: styleLocked,
										onPressed: controller != null
										? () => onSetFocusModeButtonPressed(FocusMode.locked)
										: null
									)
								]
							)
						]
					)
				)
			)
		);
	}

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

	/// Display a row of toggle to select the camera (or a message if no camera is available).
	_cameraTogglesRowWidget()
	{
		if (cameras.isEmpty)
		{
			return const Text('No camera found');
		}
		else
		{
			return Align
			(
				alignment: Alignment.topRight,
				child: IconButton
				(
					icon: Icon(Icons.flip_camera_ios_outlined),
					color: Colors.white,
					iconSize: 30,
					onPressed: ()
					{ 
						print(isCameraFrontSelected);
						print("isCameraFrontSelected");

						isCameraFrontSelected ? onNewCameraSelected(cameras[1]) : onNewCameraSelected(cameras[0]);
						isCameraFrontSelected = !isCameraFrontSelected;
					},
				)
			);
		}
	}

	String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  	void showInSnackBar(String message)
	{
		// ignore: deprecated_member_use
		_scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  	}

  	void onViewFinderTap(TapDownDetails details, BoxConstraints constraints)
	{
    	if (controller == null)
		{
      		return;
    	}

    	final CameraController cameraController = controller!;

    	final offset = Offset
		(
			details.localPosition.dx / constraints.maxWidth,
			details.localPosition.dy / constraints.maxHeight,
    	);
		cameraController.setExposurePoint(offset);
		cameraController.setFocusPoint(offset);
  	}

	void onNewCameraSelected(CameraDescription cameraDescription) async
	{

		final CameraController cameraController = CameraController
		(
			cameraDescription,
			ResolutionPreset.medium,
			enableAudio: enableAudio,
			imageFormatGroup: ImageFormatGroup.jpeg,
		);
		controller = cameraController;

		// If the controller is updated then update the UI.
		cameraController.addListener(()
		{
			if (mounted) setState(() {});

			if (cameraController.value.hasError)
			{
				showInSnackBar('Camera error ${cameraController.value.errorDescription}');
			}
		});

    	try
		{
      		await cameraController.initialize();
      		await Future.wait(
				[
					cameraController.getMinExposureOffset().then(
						(value) =>
							_minAvailableExposureOffset = value
					),
					cameraController.getMaxExposureOffset().then(
						(value) =>
							_maxAvailableExposureOffset = value
					),
        			cameraController.getMaxZoomLevel().then(
						(value) =>
						_maxAvailableZoom = value
					),
        			cameraController.getMinZoomLevel().then(
						(value) => _minAvailableZoom = value
					),
      		]);
		}
		on CameraException catch (e)
		{
			_showCameraException(e);
		}

		if (mounted)
		{
			setState(() {});
		}
	}

  	void onTakePictureButtonPressed()
	{
    	takePicture().then((XFile? file)
		{
      		if (mounted)
			{
        		setState(()
				{
          			imageFile = file;
          			videoController?.dispose();
          			videoController = null;
        		});
        		if (file != null) showInSnackBar('Picture saved to ${file.path}');
      		}
    	});
  	}

	void onFlashModeButtonPressed()
	{
		if (_flashModeControlRowAnimationController.value == 1)
		{
			_flashModeControlRowAnimationController.reverse();
		}
		else
		{
			_flashModeControlRowAnimationController.forward();
			_exposureModeControlRowAnimationController.reverse();
			_focusModeControlRowAnimationController.reverse();
		}
	}

	void onExposureModeButtonPressed()
	{
		if (_exposureModeControlRowAnimationController.value == 1)
		{
			_exposureModeControlRowAnimationController.reverse();
		}
		else
		{
			_exposureModeControlRowAnimationController.forward();
			_flashModeControlRowAnimationController.reverse();
			_focusModeControlRowAnimationController.reverse();
		}
	}

	void onFocusModeButtonPressed()
	{
		if (_focusModeControlRowAnimationController.value == 1)
		{
			_focusModeControlRowAnimationController.reverse();
		}
		else
		{
			_focusModeControlRowAnimationController.forward();
			_flashModeControlRowAnimationController.reverse();
			_exposureModeControlRowAnimationController.reverse();
		}
	}

	void onAudioModeButtonPressed()
	{
		enableAudio = !enableAudio;
		if (controller != null)
		{
			onNewCameraSelected(controller!.description);
		}
	}

	void onCaptureOrientationLockButtonPressed() async
	{
		if (controller != null)
		{
			final CameraController cameraController = controller!;

			if (cameraController.value.isCaptureOrientationLocked)
			{
				await cameraController.unlockCaptureOrientation();
				showInSnackBar('Capture orientation unlocked');
			}
			else
			{
				await cameraController.lockCaptureOrientation();
				// showInSnackBar(
				// 'Capture orientation locked to ${cameraController.value.lockedCaptureOrientation.toString().split('.').last}');
			}
		}
	}

	void onSetFlashModeButtonPressed(FlashMode mode)
	{
		setFlashMode(mode).then((_)
		{
			if (mounted) setState(() {});
			// showInSnackBar('Flash mode set to ${mode.toString().split('.').last}');
		});
	}

	void onSetExposureModeButtonPressed(ExposureMode mode)
	{
		setExposureMode(mode).then((_)
		{
			if (mounted) setState(() {});
			// showInSnackBar('Exposure mode set to ${mode.toString().split('.').last}');
		});
	}

	void onSetFocusModeButtonPressed(FocusMode mode)
	{
		setFocusMode(mode).then((_)
		{
			if (mounted) setState(() {});
			// showInSnackBar('Focus mode set to ${mode.toString().split('.').last}');
		});
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

  	Future<void> setFlashMode(FlashMode mode) async 
	{
    	if (controller == null) 
		{
      		return;
    	}

    	try 
		{
      		await controller!.setFlashMode(mode);
    	} 
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		rethrow;
    	}
  	}

  	Future<void> setExposureMode(ExposureMode mode) async 
	{
	    if (controller == null) 
		{
      		return;
    	}

    	try 
		{
      		await controller!.setExposureMode(mode);
    	} 
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		rethrow;
    	}
  	}

  	Future<void> setExposureOffset(double offset) async 
	{
    	if (controller == null) 
		{
      		return;
    	}

    	setState(() 
		{
      		_currentExposureOffset = offset;
    	});
    	try 
		{
      		offset = await controller!.setExposureOffset(offset);
    	} 
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		rethrow;
    	}
  	}

  	Future<void> setFocusMode(FocusMode mode) async 
	{
    	if (controller == null) 
		{
      		return;
    	}

    	try 
		{
      		await controller!.setFocusMode(mode);
    	} 
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		rethrow;
    	}
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
        		imageFile = null;
        		videoController = vController;
      		});
    	}
    	await vController.play();
  	}

  	Future<XFile?> takePicture() async 
	{
		final CameraController? cameraController = controller;

		if (cameraController == null || !cameraController.value.isInitialized) 
		{
			showInSnackBar('Error: select a camera first.');
			return null;
    	}

    	if (cameraController.value.isTakingPicture) 
		{
      		// A capture is already pending, do nothing.
      		return null;
    	}

    	try 
		{
      		XFile file = await cameraController.takePicture();
      		return file;
    	}
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		return null;
    	}
  	}

	void _showCameraException(CameraException e) 
	{
		logError(e.code, e.description);
		showInSnackBar('Error: ${e.code}\n${e.description}');
	}
}


