import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  bool isFullScreen = false;
  String? selectedVideoID;

  final List<Map<String, String>> videos = [
    {'title': 'Rahasia kesepian yang merubah hidup saya', 'id': 'S8iicLSO8pQ'},
    {'title': 'Jangan Jahat Sama Diri Sendiri ', 'id': '4x58uUawlZM'},
    {
      'title': 'Ketika kamu sedih dan Putus Asa | Merry Riana',
      'id': 'NWQ13Y4G0fw'
    },
    {'title': 'Mengubah Konsep Diri (Self Concept)', 'id': 'gaBunBYSgOU'},
    {'title': 'Ketika kamu sedih, kecewa dan menderita', 'id': 'HflyqEIZto0'},
    {
      'title': 'Nasihat dan motivasi terbaik tentang hidup',
      'id': 'SCfxVgtcDVs'
    },
    // Add more videos here
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: selectedVideoID ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    _controller.addListener(() {
      if (_controller.value.isFullScreen != isFullScreen) {
        setState(() {
          isFullScreen = _controller.value.isFullScreen;
        });
      }
    });
  }

  void _onCardTap(String videoID) {
    setState(() {
      selectedVideoID = videoID;
      _controller.load(videoID);
    });
    
  }

  void _clearSelectedVideo() {
    setState(() {
      selectedVideoID = null;
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        setState(() {
          isFullScreen = false;
        });
      },
      player: YoutubePlayer(
        controller: _controller,
        liveUIColor: Colors.amber,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) => Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   title: Text(
        //     'Video Edukasi',
        //     style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
        //   ),
        //   flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //         image: AssetImage('assets/bg_mentioners.png'),
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        // ),
        // backgroundColor: Color(0xFF3C877C),
        body: Stack(
          children: [
            Positioned.fill(
            child: Image.asset(
              'assets/bg_mentioners.png',
              fit: BoxFit.cover,
            ),
          ),
            SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/bg_mentioners.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.all(40),
                        child: Text(
                          'SELAIN DARI BUKU DIGITAL, KAMU JUGA BISA MENDAPAT EDUKASI LEWAT VIDEO DIBAWAH INI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (selectedVideoID != null)
                      Stack(
                        children: [
                          player,
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.close, color: Colors.white),
                              onPressed: _clearSelectedVideo,
                            ),
                          ),
                        ],
                      ),
                    Expanded(
                      child: Container(
                        color: Color(0xFF3C877C),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.85,
                            ),
                            itemCount: videos.length,
                            itemBuilder: (context, index) {
                              final video = videos[index];
                              final videoID = video['id']!;
                              final thumbnailUrl = YoutubePlayer.getThumbnail(
                                videoId: videoID,
                                quality: ThumbnailQuality.high,
                              );
                          
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Card(
                                  child: InkWell(
                                    onTap: () => _onCardTap(videoID),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          thumbnailUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 150,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            video['title']!,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
