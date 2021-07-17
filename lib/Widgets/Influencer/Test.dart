import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hypd/Widgets/BottomNavigationBar/HomePage.dart';
import 'package:hypd/Widgets/Influencer/InBottomNavBar.dart';
import 'package:hypd/Widgets/Influencer/InfluencerWatchVideo.dart';
import 'package:hypd/Widgets/Influencer/MarqueePage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';

class Test extends StatefulWidget 
{
	@override
	_TestState createState() => _TestState();
}

class _TestState extends State<Test> with TickerProviderStateMixin 
{	
	GlobalKey<FormState> _key = new GlobalKey();
	final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

	final assetsAudioPlayer = AssetsAudioPlayer();

	CameraController? controller;
	AnimationController? _animationController;
	late Animation _sizeAnimation;

	PanelController _pc1 = new PanelController();

	VideoPlayerController? videoController;
	late VoidCallback videoPlayerListener;

	String videoPath = "";
	String audioFile = "";
	String description = "";
	String audioFileName = "";

	List<CameraDescription> cameras = [];

	late Timer timer;

	int selectedCameraIdx = 0;
	int seconds = 1;
	int privacy = 0;

	double videoLength = 15.0;
	double videoProgressPercent = 0;
	double uploadProgress = 0;


	bool videoRecorded = false;
	bool isUploading = false;
	bool showLoader = false;
	bool isVideoRecorded = false;
	bool showProgressBar = false;
	bool reverse = false;
	bool cameraCrash = false;

	@override
	void initState()
	{
		super.initState();
		availableCameras().then((availableCameras) 
		{
      		cameras = availableCameras;
      		if (cameras.length > 0) 
			{
        		setState(() 
				{
          			selectedCameraIdx = 0;
        		});
        		_onCameraSwitched(cameras[selectedCameraIdx]).then((void v) {});
      		}
    	}).catchError((err) 
		{
      		print('Error: $err.code\nError Message: $err.message');
    	});

		_animationController = AnimationController(vsync: this, duration: Duration(seconds: seconds))..addStatusListener((status) 
		{
            if (status == AnimationStatus.completed) 
			{
            	_animationController!.repeat(reverse: !reverse);
              	setState(() 
				{
                	reverse = !reverse;
              	});
            }
        });
    	_sizeAnimation = Tween<double>(begin: 60.0, end: 70.0).animate(_animationController!);
	}

	@override
	Widget build(BuildContext context) 
 	{
		var size = MediaQuery.of(context).size;

		if (size != null) 
		{
			var deviceRatio = size.width / size.height;

			SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.black54));

			return ModalProgressHUD
			(
				progressIndicator: showLoaderSpinner(),
				inAsyncCall: showLoader,
				child: Scaffold
					(
						backgroundColor: Colors.transparent,
						key: _scaffoldKey,
						body: SafeArea
						(
							child: Stack
							(
								children: <Widget>
								[
									GestureDetector
									(
										child: Center
										(
											child: Transform.scale
											(
												scale: (!controller!.value.isInitialized)
												? 1
												: controller!.value.aspectRatio / deviceRatio,
												child: new AspectRatio
												(
													aspectRatio: (!controller!.value.isInitialized)
													? 1
													: controller!.value.aspectRatio,
													child: Column
													(
														children: <Widget>
														[
															Expanded
															(
																child: Container
																(
																	child: Padding
																	(
																		padding: const EdgeInsets.all(1.0),
																		child: Center
																		(
																			// child: (!controller!.value.isInitialized)
																			// ? CircularProgressIndicator()
																			// : 
																			child: _cameraPreviewWidget(),
																		)
																	),
																	decoration: BoxDecoration(color: Colors.transparent),
																),
															),
														],
													),
												),
											),
										),
										onDoubleTap: () 
										{
											_onSwitchCamera();
										},
									),
									Positioned
									(
										bottom: 35,
										left: 0,
										child: _cameraTogglesRowWidget(),
									),
									// Positioned
									// (
									// 	bottom: 35,
									// 	left: 85,
									// 	child: _cameraFlashRowWidget(),
									// ),
									Positioned
									(
										bottom: 20,
										child: Container(
										width: MediaQuery.of(context).size.width,
										child: Align(
											alignment: Alignment.bottomCenter,
											child: _captureControlRowWidget11(),
										),
										),
									),
									(controller == null || !controller!.value.isInitialized || !controller!.value.isRecordingVideo)
									? Positioned
									(
										bottom: 110,
										child: Container
										(
											width: MediaQuery.of(context).size.width,
											child: Center
											(
												child: Row
												(
													mainAxisSize: MainAxisSize.min,
													mainAxisAlignment: MainAxisAlignment.center,
													children: <Widget>
													[
														Container
														(
															height: 35.0,
															width: 35.0,
															padding: EdgeInsets.all(3),
															decoration: BoxDecoration
															(
																color: Colors.black38,
																borderRadius: BorderRadius.circular(10),
																border: (videoLength == 15.0)
																? Border.all(color: Colors.white70, width: 2)
																: Border.all(color: Colors.white70, width: 0),
															),
															child: GestureDetector
															(
																onTap: () 
																{
																	setState(() 
																	{
																		videoLength = 15.0;
																	});
																	print(videoLength);
																},
																child: Center
																(
																	child: Text
																	(
																		"15s",
																		style: TextStyle
																		(
																			color: Colors.white,
																			fontSize: 12,
																		),
																	),
																),
															)
														),
														SizedBox(width: 10),
														Container
														(
															height: 35.0,
															width: 35.0,
															padding: EdgeInsets.all(3),
															decoration: BoxDecoration
															(
																color: Colors.black38,
																borderRadius: BorderRadius.circular(10),
																border: (videoLength == 30.0)
																	? Border.all(color: Colors.white70,width: 2)
																	: Border.all(color: Colors.white70, width: 0),
															),
															child: GestureDetector
																(
																onTap: () 
																{
																	setState(() 
																	{
																		videoLength = 30.0;
																	});
																	print(videoLength);
																},
																child: Center
																(
																	child: Text
																	(
																		"30s",
																		style: TextStyle
																		(
																			color: Colors.white,
																			fontSize: 12,
																		),
																	),
																),
															)
														)
													],
												),
											)
										),
									)
									: Container(),

									(showProgressBar)
									? Positioned
									(
										top: 10,
										child: LinearPercentIndicator
										(
											width: MediaQuery.of(context).size.width,
											lineHeight: 5.0,
											animationDuration: 100,
											percent: videoProgressPercent,
											progressColor: Color(0xffec4a63),
										),
									)
									: Container(),

									(controller == null || !controller!.value.isInitialized || !controller!.value.isRecordingVideo)
									? Positioned
									(
										top: 30,
										child: Container
										(
											width: MediaQuery.of(context).size.width,
											child: Align
											(
												alignment: Alignment.bottomCenter,
												child: GestureDetector
												(
													child: SizedBox
													(
														width: 140.0,
														child: MarqueeWidget
														(
															direction: Axis.horizontal,
															child: Row
															(
																mainAxisAlignment: MainAxisAlignment.center,
																children: <Widget>
																[
																	Text
																	(
																		audioFileName != ""
																			? audioFileName
																			: "Select Sound ",
																			style: TextStyle
																			(
																				color: Colors.white,
																				fontSize: 16,
																			),
																	),
																	Icon
																	(
																		Icons.queue_music,
																		size: 22,
																		color: Colors.white,
																	),
																],
															),
														),
													),
													onTap: () 
													{
														// Navigator.push(context, MaterialPageRoute( builder: (context) => 	SoundList((sound) 
														// {
														// 	setState(() 
														// 	{
														// 		audioFileName = sound.title;
														// 		audioFile = sound.url;
														// 		audioId = sound.soundId;
														// 		assetsAudioPlayer.open(Audio.network(sound.url),autoStart:false);
														// 	});
														// 	Navigator.pop(context);
														// })));
													},
												),
											),
										),
									)
									: Container(),

									(controller != null && controller!.value.isInitialized && controller!.value.isRecordingVideo)
									? Positioned
									(
										bottom: 35,
										right: 90,
										child: Container
										(
											width: MediaQuery.of(context).size.width,
											child: Align
											(
												alignment: Alignment.bottomRight,
												child: SizedBox.fromSize
												(
													size: Size(50, 50), // button width and height
													child: ClipOval
													(
														child: Container
														(
															color: Colors.transparent,
															child: Material
															(
																color: Colors.transparent,
																child: InkWell
																(
																	splashColor: Colors.pinkAccent, // splash color
																	onTap: () 
																	{
																		setState(() 
																		{
																			reverse = reverse;
																		});
																		if (!videoRecorded) 
																		{
																			onResumeButtonPressed();
																			_animationController!.forward();
																		} 
																		else 
																		{
																			onPauseButtonPressed();
																			_animationController!.stop();
																		}
																	},
																	child: Column
																	(
																		mainAxisAlignment: MainAxisAlignment.center,
																		children: <Widget>
																		[
																			Image.asset(!videoRecorded
																			? "assets/icons/play-icon.png"
																			: "assets/icons/pause-icon.png",
																			width: 50,
																			height: 50), // icon
																		],
																	),
																),
															),
														),
													),
												),
											),
										),
									)
									: Container(),

									Positioned
									(
										bottom: 35,
										right: 0,
										child: TextButton
										(
											child: Image.asset('assets/icons/gallery.png', width: 50),
											onPressed: _uploadGalleryVideo,
										),
									),

									// (isUploading == )
									// ? Container
									// (
									// 	width: MediaQuery.of(context).size.width,
									// 	height: MediaQuery.of(context).size.height,
									// 	decoration: BoxDecoration(color: Colors.black54),
									// 	child: Center
									// 	(
									// 		child: Container
									// 		(
									// 			decoration: BoxDecoration
									// 			(
									// 				borderRadius: BorderRadius.circular(20),
									// 				color: Colors.black87,
									// 			),
									// 			width: 200,
									// 			height: 170,
									// 			child: Padding
									// 			(
									// 				padding: const EdgeInsets.all(20.0),
									// 				child: Column
									// 				(
									// 					children: <Widget>
									// 					[
									// 						Center
									// 						(
									// 						// child: Text("Circular progress Indicator"),
									// 							child: CircularPercentIndicator
									// 							(
									// 								progressColor: Colors.pink,
									// 								percent: uploadProgress,
									// 								radius: 120.0,
									// 								lineWidth: 8.0,
									// 								circularStrokeCap:
									// 								CircularStrokeCap.round,
									// 								center: Text
									// 								(
									// 									(uploadProgress * 100).toStringAsFixed(2) + "%",
									// 									style: TextStyle(color: Colors.white),
									// 								),
									// 							),
									// 						),
									// 					],
									// 				),
									// 			),
									// 		),
									// 	),
									// )
									// : Container(),

									_thumbnailWidget(),
								],
							),
						),
						bottomNavigationBar: InBottomNavBar(pageInd: 2),
					),
			);
		} 
		else 
		{
			return Center
			(
				child: CircularProgressIndicator
				(
					valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
				),
			);
		}
	}

	static showLoaderSpinner() 
	{
    	return Center
		(
      		child: Container
			(
        		width: 20,
        		height: 20,
        		child: CircularProgressIndicator
				(
          			strokeWidth: 2,
          			valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        		),
      		),
    	);
  	}

	Widget _thumbnailWidget() 
	{
    	return SlidingUpPanel
		(
      		isDraggable: false,
      		backdropEnabled: true,
      		backdropColor: Colors.black54,
      		panelSnapping: false,
      		color: Colors.transparent,
			controller: _pc1,
			maxHeight: MediaQuery.of(context).size.height,
			minHeight: 0,
			body: Container
			(
				width: MediaQuery.of(context).size.width,
				height: MediaQuery.of(context).size.height,
				child: videoController == null
					? Container()
					: Stack
					(
						children: <Widget>
						[
							SizedBox.expand
							(
								child: (videoController == null)
								? Container()
								: FittedBox
								(
									fit: BoxFit.cover,
									child: SizedBox
									(
										width: double.maxFinite,
										height: double.maxFinite,
										child: Center
										(
											child: AspectRatio
											(
												aspectRatio: videoController!.value.aspectRatio,
												child: VideoPlayer(videoController!)
											),
										),
									),
								),
							),
							Positioned
							(
								bottom: 50,
								right: 20,
								child: RawMaterialButton
								(
									onPressed: () 
									{
										videoController!.pause();
										_pc1.open();
									},
									elevation: 2.0,
									fillColor: Colors.white,
									child: Icon
									(
										Icons.check_circle,
										size: 35.0,
									),
									padding: EdgeInsets.all(15.0),
									shape: CircleBorder(),
								),
							),
							Positioned
							(
								bottom: 50,
								left: 20,
								child: RawMaterialButton
								(
									onPressed: () 
									{
										videoController!.pause();
										setState(() 
										{
											isUploading = false;
											timer.cancel();
											videoController = VideoPlayerController.network("");
										});
									},
									elevation: 2.0,
									fillColor: Colors.white,
									child: Icon
									(
										Icons.close,
										size: 35.0,
									),
									padding: EdgeInsets.all(15.0),
									shape: CircleBorder(),
								),
							),
						]
					),
      		),
      		panelBuilder: (sc) 
			{
				// return Text("Video panel");
        		return publishPanel();
      		},
    	);
  	}

	Widget publishPanel() 
	{
		const Map<String, int> privacies = 
		{
			'Public': 0,
			'Private': 1,
			'Only Followers': 2
		};

    	return MediaQuery.removePadding(
		context: context,
		removeTop: true,
		child: Container(
			color: Colors.black,
        /*decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),*/
        height: MediaQuery.of(context).size.height,
		// color: Colors.white,
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Center(
                  child: Text(
                    "New Post",
                    style: TextStyle(
                      fontFamily: 'RockWellStd',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 1,
                  child: Container(
                    color: Colors.white30,
                  ),
                ),
              ),
              Container(
                height: 500,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(
                                fontFamily: 'RockWellStd',
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            //   validator: valid/ateDescription,
                              onSaved: ( val) {
                                description = val.toString();
                              },
                              onChanged: (String val) {
                                description = val;
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 2.0,
                                ),
						//                    contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 15.0),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.pinkAccent,
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.pinkAccent,
                                    width: 0.5,
                                  ),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                hintText: "Enter Video Description",
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 175,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors
                                            .pinkAccent, //                   <--- border color
                                        width: 0.5,
                                      ),
                                      color: Color(0xff2e2f34),
                                      borderRadius: BorderRadius.all(
                                          new Radius.circular(6.0)),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/logo.png"),
                                        fit: BoxFit.fitWidth,
                                      )),

                                  /* child: CachedNetworkImage(
                                    imageUrl: thumbPath,
                                    height: 175,
                                  ),*/
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.lock_outline,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Privacy Setting",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
										//canvasColor: Color(0xffffffff),
                                        canvasColor: Colors.black87,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          isExpanded: true,
                                          hint: new Text(
                                            "Select Type",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          iconEnabledColor: Colors.white,
                                          style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                          value: privacy,
                                          onChanged: (newValue) {
                                            setState(() {
                                              privacy = int.parse(newValue.toString());
                                            });
                                          },
                                          items: privacies
                                              .map((text, value) {
                                                return MapEntry(
                                                  text,
                                                  DropdownMenuItem<int>(
                                                    value: value,
                                                    child: new Text(
                                                      text,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                              .values
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: RaisedButton(
                              color: Color(0xff15161a),
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 45,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                //   gradient: Gradients.blush,
                                ),
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'RockWellStd',
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // Validate returns true if the form is valid, otherwise false.
                                // Navigator.of(context).pushReplacement(
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return VideoRe();
                                //     },
                                //   ),
                                // );
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RaisedButton(
                              color: Color(0xff15161a),
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 45,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                //   gradient: Gradients.blush,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Share",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'RockWellStd',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // Validate returns true if the form is valid, otherwise false.
                                if (_key.currentState!.validate()) 
								{
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                //   enableVideo();
                                } else 
								{
                                  	Scaffold.of(context).showSnackBar(SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                      content:
                                          Text("Enter Video Description")));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

	_willPopScope(context) 
	{
    	if (isVideoRecorded == true) 
		{
      		return exitConfirm(context);
    	} 
		else 
		{
      		Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfluecnerWatchVideo()));
    	}
  	}

	Widget _captureControlRowWidget11() 
	{
    	return SizedBox.fromSize
		(
      		size: Size(80, 80), // button width and height
      		child: ClipOval
			(
        		child: Container
				(
          			child: Material
					(
            			child: InkWell
						(
							onTap: controller != null && controller!.value.isInitialized && !controller!.value.isRecordingVideo
								? _onRecordButtonPressed
								: _onStopButtonPressed,
							// onTap:  _onRecordButtonPressed,
								child: Column
								(
									mainAxisAlignment: MainAxisAlignment.center,
									children: <Widget>
									[
										controller != null && controller!.value.isInitialized && !controller!.value.isRecordingVideo
										? Image.asset
										(
											"assets/icons/video-recording-icon.png",
											height: 70,
											width: 70,
										)
										: AnimatedBuilder
										(
											animation: _sizeAnimation,
											builder: (context, child) => Image.asset
											(
												"assets/icons/stop-video.png",
												height: _sizeAnimation.value,
												width: _sizeAnimation.value,
											),
										), // icon
									],
								),
            			),
          			),
        		),
      		),
    	);
  	}

	
  	Widget _cameraPreviewWidget() 
	{
    	if (controller == null || !controller!.value.isInitialized) 
		{
      		return const Text
			(
        		'Loading',
        		style: TextStyle
				(
					color: Colors.white,
					fontSize: 20.0,
					fontWeight: FontWeight.w900,
        		),
      		);
    	} 
		else 
		{
      		return AspectRatio
			(
        		aspectRatio: 9 /16,
        		child: CameraPreview(controller!),
      		);
    	}
  	}

	Widget _cameraTogglesRowWidget() 
	{
    	if (cameras == null) 
		{
      		return Row();
    	}

    	return TextButton
		(
      		child: Image.asset('assets/icons/flip-camera.png', width: 50),
      		onPressed: _onSwitchCamera,
    	);
  	}

  final Trimmer _trimmer = Trimmer();


	Future _uploadGalleryVideo() async 
	{
    	File file = new File(videoPath);
    	final picker = ImagePicker();

    	print("videoLength");
    	print(videoLength);

    	final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    	setState(() 
		{
      		if (pickedFile != null) 
			{
        		file = File(pickedFile.path);
      		} 
			else 
			{
        		print('No image selected.');
      		}
    	});
    
    	if (file != null) 
		{

			print("TIMEER");
      		await _trimmer.loadVideo(videoFile: file);
      		Navigator.of(context).push(MaterialPageRoute(builder: (context) 
			{
        		return TrimmerView
				(
          			_trimmer,
          			(output) async 
					{
            			setState(() 
						{
              				videoPath = output;
            			});
            			print("videoPath");
            			Navigator.pop(context);
            			setState(() 
						{
              				isUploading = true;
            			});
            			String responseVideo = "";
            			// responseVideo = await uploadVideo();
            			// if (responseVideo != "") 
						// {
              				_pc1.open();
            			// }
          			},
          			videoLength,
          			audioFile,
        		);
      		}));
    	}
  	}

	void exitConfirm(context) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Container(
        height: 210.0,
        width: 300.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          //color: Colors.white,
          borderRadius: BorderRadius.all(new Radius.circular(12.0)),
        ),
        child: Column(
          children: <Widget>[
            Container(
                height: 150,
                decoration: BoxDecoration(
                  //color: Color(0xff2e2f34),
                  borderRadius: BorderRadius.all(new Radius.circular(12.0)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset('assets/images/logo.png',
                            width: 25, height: 25, fit: BoxFit.fill),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            "Do you really want to discard "
                            "the video?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop("Discard");
              },
              child: Container(
                  decoration: BoxDecoration(
                    //color: Color(0xff2e2f34),
                    borderRadius: BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            VideoCompress.cancelCompression();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomePage();
                                },
                              ),
                              (Route<dynamic> route) => false,
                            );
                            // return "true";
                          },
                          child: Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                            //   gradient: Gradients.blush,
                              borderRadius:
                                  BorderRadius.all(new Radius.circular(5.0)),
								  color: Colors.red
                            ),
                            child: Center(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'RockWellStd'),
                              ),
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop("Discard");
                          },
                          child: Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                            //   gradient: Gradients.blush,
								  color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(new Radius.circular(5.0), ),
                            ),
                            child: Center(
                              child: Text(
                                "No",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'RockWellStd'),
                              ),
                            ),
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

	//   functions
	void _onSwitchCamera() 
	{
    	selectedCameraIdx = selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
		setState(() {

		});
    	CameraDescription selectedCamera = cameras[selectedCameraIdx];
    	_onCameraSwitched(selectedCamera);

    	setState(() 
		{
      		selectedCameraIdx = selectedCameraIdx;
    	});
  	}

  	void onPauseButtonPressed() 
	{
		assetsAudioPlayer.pause();
		pauseVideoRecording().then((_) 
		{
			if (mounted)
				setState(() 
				{
					videoRecorded = false;
					timer.cancel();
				});
		});
	}

  	void onResumeButtonPressed() 
	{
		assetsAudioPlayer.play();
		resumeVideoRecording().then((_) 
		{
			if (mounted)
				setState(() 
				{
					videoRecorded = true;
					startTimer();
				});
		});
	}

	Future<void> _onCameraSwitched(CameraDescription cameraDescription) async 
	{
    	if (controller != null) 
		{
      		await controller!.dispose();
    	}

    	controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    	controller!.addListener(() 
		{
      		if (mounted) 
			{
        		setState(() {});
      		}

      		if (controller!.value.hasError) 
			{
        		print('Camera error ${controller!.value.errorDescription}');
				/*Fluttertoast.showToast(
					msg: 'Camera error ${controller.value.errorDescription}',
					toastLength: Toast.LENGTH_SHORT,
					gravity: ToastGravity.CENTER,
					timeInSecForIosWeb: 1,
					backgroundColor: Colors.red,
					textColor: Colors.white);*/
			}
    	});

    	try 
		{
      		await controller!.initialize();
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

	Future<void> pauseVideoRecording() async 
	{
    	if (!controller!.value.isRecordingVideo) 
		{
      		return null;
    	}

    	try 
		{
      		await controller!.pauseVideoRecording();
    	} 
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		rethrow;
    	}
  	}

	
  	Future<void> resumeVideoRecording() async 
	{
    	if (!controller!.value.isRecordingVideo) 
		{
      		return null;
    	}

    	try 
		{
      		await controller!.resumeVideoRecording();
    	} 
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		rethrow;
    	}
  	}

	startTimer() 
	{
    	timer = Timer.periodic(new Duration(milliseconds: 100), (timer) 
		{
      		setState(() 
			{
        		videoProgressPercent += 1 / (videoLength * 10);
        		if (videoProgressPercent >= 1) 
				{
          			videoProgressPercent = 1;
          			timer.cancel();
          			_onStopButtonPressed();
        		}
      		});
    	});
  	}

	void _onStopButtonPressed() 
	{
    	setState(() 
		{
			isUploading = true;
			videoRecorded = false;
    	});
    	_stopVideoRecording().then((outputVideo) async 
		{
			print(outputVideo);
			print("outputVideo00000000000000000000");
      		print("_loadingStreamCtrl.true");
      		if (mounted) setState(() {});
      		if (outputVideo != null) {}
    	});
  	}


	void _showCameraException(CameraException e) 
	{
		String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
		print(errorText);
		setState(() 
		{
			cameraCrash = true;
		});
    	showDialog
		(
      		context: context,
      		builder: (BuildContext context) => Dialog
			(
        		shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
				elevation: 0.0,
				backgroundColor: Colors.transparent,
				// child: dialogContent(context),
			),
    	);
  	}

	Future<void> _startVideoPlayer(outputVideo) async {
    setState(() {
      showLoader = true;
    });
    print("outputVideo");
    print(outputVideo);
    final VideoPlayerController vcontroller =
        VideoPlayerController.network(outputVideo);
    videoPlayerListener = () {
      if (videoController != null && videoController!.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoController!.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(true);
    await vcontroller.initialize();
    await videoController!.dispose();
    if (mounted) {
      setState(() {
//        imagePath = null;
        videoController = vcontroller;
      });
    }
    await vcontroller.play();
    setState(() {
      showLoader = false;
    });
  }


	Future<String> _stopVideoRecording() async 
	{
    	setState(() 
		{
      		isUploading = true;
      		print("_loadingStreamCtrllllllllllllllllllllllllllllllllll.true");
   		});
    	assetsAudioPlayer.pause();
    	if (!controller!.value.isRecordingVideo) 
		{
      		return "null";
    	}

    	try 
		{
			stopVideoRecording().then((file) async
			{
				if (mounted) setState(() {});
				if (file != null) 
				{
					setState(() 
					{
						videoPath = file.toString();
					});
				}
			});
      		// await controller!.stopVideoRecording();
    	} 
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		return "null";
    	}

		// final appDirectory = await getApplicationDocumentsDirectory();
		// print("1");
		// print(appDirectory);
		// print("appDirectory");

		// final String outputDirectory = '${appDirectory.path}/outputVideos';
		// print("2");
		// print(outputDirectory);
		// print("outputDirectory");

		// await Directory(outputDirectory).create(recursive: true);
		// print("3");
		
		// final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
		// print("4");
		// print(currentTime);
		// print("currentTime");

		// final  outputVideo = '$outputDirectory/$currentTime.mp4';
		// print("5");
		// print(outputVideo);
		// print("outputVideo");

		// print(appDirectory.path);
		// print("APP DIR PATH");

		// final dir = await getExternalStorageDirectory();


		// String responseVideo = "";

		// final directory  = await getExternalStorageDirectory();

    	final info = await VideoCompress.compressVideo
		(
			videoPath,
			quality: VideoQuality.MediumQuality,
			deleteOrigin: true,
    	);

		print(info);
    
    	setState(() 
		{
      		// videoPath = info!.path.toString();
    	});

	
    	// responseVideo = await uploadVideo();
    	// if (progress >= 100.0) 
		{
      		print("progress 1000000000000000000000000000000000000000000000000000000");
    	}

    	// if (responseVideo != '') 
		// {
      		await _startVideoPlayer(videoPath);
    	// }
    	return videoPath;
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

	void _onRecordButtonPressed() 
	{
    	setState(() 
		{
			isVideoRecorded = true;
			videoRecorded = true;
    	});
    	_startVideoRecording().then((String filePath) 
		{
      		if (filePath != null) 
			{
        		setState(() 
				{
					showProgressBar = true;
					startTimer();
        		});
      		}
    	});
  	}

	Future<String> _startVideoRecording() async 
	{
    	if (!controller!.value.isInitialized) 
		{
      		return "null";
    	}
    	assetsAudioPlayer.play();

    // Do nothing if a recording is on progress
    	if (controller!.value.isRecordingVideo) 
		{
      		return "null";
    	}

    	var appDirectory = await getApplicationDocumentsDirectory();
		print("11");
    	final String videoDirectory = '${appDirectory.path}/Videos';
		print("22");
    	await Directory(videoDirectory).create(recursive: true);
		print("33");
    	// final String currentTime ="$countVideos" + DateTime.now().millisecondsSinceEpoch.toString();
		final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
		print("44");
		final String filePath = '$videoDirectory/$currentTime.mp4';
		print("55555555555555555555555555555555555555555555555555555555555555555");
		print(filePath);
		print("filePath");

    	try 
		{
      		await controller!.startVideoRecording();
      		videoPath = filePath;

			print(videoPath);
			print("VIDEO PATHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHh");
    	} 
		on CameraException catch (e) 
		{
      		_showCameraException(e);
      		return "null";
    	}
    	return filePath;
  	}
}




class TrimmerView extends StatefulWidget {
  final Trimmer _trimmer;
  final ValueSetter<String> onVideoSaved;
  final double maxLength;
  final String sound;
  TrimmerView(this._trimmer, this.onVideoSaved, this.maxLength, this.sound);
  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  double _startValue = 0.0;
  double _endValue = 0.0;
  AssetsAudioPlayer assetsAudioPlayer = new AssetsAudioPlayer();
  bool _isPlaying = false;
  bool _progressVisibility = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    assetsAudioPlayer.dispose();
  }

  /*void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Video Length Alert"),
          content: new Text("Video should not exceed 15 secs"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
//                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/

  Future<String> _saveVideo() async {
    setState(() {
      if (_startValue + widget.maxLength * 1000 < _endValue) {
        _endValue = _startValue + widget.maxLength * 1000;
      }
      _progressVisibility = true;
    });
    print("_startValue");
    print(_startValue);
    print("_endValue");
    print(_endValue);
    print("widget.maxLength");
    print(widget.maxLength);
    String _value = "";

    await widget._trimmer
        .saveTrimmedVideo(
            applyVideoEncoding: true,
            startValue: _startValue,
            endValue: _endValue,
//            maxLength: widget.maxLength,
            customVideoFormat: '.mp4')
        .then((value) {
      setState(() {
        _progressVisibility = true;
        _value = value;
      });
    });
    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(" "),
      ),
      body: Builder(
        builder: (context) => Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Visibility(
                  visible: _progressVisibility,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
                RaisedButton(
                  color: Color(0xff15161a),
                  padding: EdgeInsets.all(0),
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
						color: Colors.red,
                        borderRadius: BorderRadius.circular(3.0)),
                        // gradient: Gradients.blush),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'RockWellStd',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onPressed: _progressVisibility
                      ? null
                      : () async {
                          _saveVideo().then((outputPath) {
                            print('OUTPUT PATH: $outputPath');
                            final snackBar = SnackBar(
                              content: Text('Video Saved successfully'),
                            );
                            widget.onVideoSaved(outputPath);
                            Scaffold.of(context).showSnackBar(snackBar);
                          });
                        },
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: VideoViewer(trimmer: Trimmer()),
                ),
                Center(
                  child: TrimEditor(
					  trimmer: Trimmer(),
                    viewerHeight: 50.0,
                    // sound: widget.sound,
                    viewerWidth: MediaQuery.of(context).size.width,
                    maxVideoLength: Duration(seconds: widget.maxLength.toInt()),
                    onChangeStart: (value) {
                      _startValue = value;
                    },
                    onChangeEnd: (value) {
                      print("End changed");
                      _endValue = value;
                    },
                    onChangePlaybackState: (value) {
                      print("onChangePlaybackState $_endValue $_startValue");
                      if (_endValue - _startValue >=
                          widget.maxLength * 1000 + 0.1) {
                        setState(() {
                          _endValue = _startValue + widget.maxLength * 1000;
                        });
                      }
                      if (widget.sound != "") {
                        // if (assetsAudioPlayer.currentPosition.value.inMilliseconds.toDouble() >=_endValue) 
						// {
                        //   assetsAudioPlayer.playOrPause();
                        // }
                        if (!value) {
                          assetsAudioPlayer.pause();
                          assetsAudioPlayer.seek(Duration(seconds: 0));
                        } else {
                          assetsAudioPlayer.play();
                        }
                      }
                      setState(() {
                        _isPlaying = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                RaisedButton(
                  color: Color(0xff15161a),
                  padding: EdgeInsets.all(0),
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
						color: Colors.red,
                        borderRadius: BorderRadius.circular(3.0)),
                        // gradient: Gradients.blush),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            _isPlaying ? "Pause" : "Play",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'RockWellStd',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (widget.sound != "") {
                      if (assetsAudioPlayer.current == null) {
                        AssetsAudioPlayer.allPlayers().forEach((key, value) {
                          value.pause();
                        });
                        await assetsAudioPlayer
                            .open(Audio.network("http://media-ice.musicradio.com/HeartLondon"), autoStart: true);
                      } else {
                        AssetsAudioPlayer.allPlayers().forEach((key, value) {
                          value.pause();
                        });
                        assetsAudioPlayer.pause();
                      }
                    }
                    bool playbackState =
                        await widget._trimmer.videPlaybackControl(
                      startValue: _startValue,
                      endValue: _endValue,
                    );

                    setState(() {
                      _isPlaying = playbackState;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String durationToString(Duration duration) {
    String twoDigits(var n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes =
        twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
    String twoDigitSeconds =
        twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}