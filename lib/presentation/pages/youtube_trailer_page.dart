import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeTrailerPage extends StatefulWidget {
  final String videoId;

  const YoutubeTrailerPage({super.key, required this.videoId});

  @override
  State<YoutubeTrailerPage> createState() => _YoutubeTrailerPageState();
}

class _YoutubeTrailerPageState extends State<YoutubeTrailerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(title: const Text('Ver tráiler')),
          body: player,
        );
      },
    );
  }
}
