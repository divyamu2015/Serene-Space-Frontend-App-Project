import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MentalHealthVideoScreen extends StatefulWidget {
  const MentalHealthVideoScreen({super.key});

  @override
  State<MentalHealthVideoScreen> createState() => _MentalHealthVideoScreenState();
}

class _MentalHealthVideoScreenState extends State<MentalHealthVideoScreen> {
  @override
  Widget build(BuildContext context) {
    final List<VideoItem> videos = [
      VideoItem(
        title: "Understanding ADHD in Adults",
        videoUrl: "https://www.youtube.com/watch?v=J0Rz3Kx8p_8",
        category: "ADHD",
      ),
      VideoItem(
        title: "Coping with Depression: Tips & Strategies",
        videoUrl: "https://www.youtube.com/watch?v=GJ6O7lE1X04",
        category: "Depression",
      ),
      VideoItem(
        title: "ADHD Symptoms & Diagnosis Explained",
        videoUrl: "https://www.youtube.com/watch?v=ssK0FZaaN1E",
        category: "ADHD",
      ),
      VideoItem(
        title: "Mental Health Self-Care for Depression",
        videoUrl: "https://www.youtube.com/watch?v=Yp3mFjV7A3o",
        category: "Depression",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("ADHD & Depression Videos"),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return VideoCard(video: video);
          },
        ),
      ),
    );
  }
}

class VideoItem {
  final String title;
  final String videoUrl;
  final String category;

  VideoItem({
    required this.title,
    required this.videoUrl,
    required this.category,
  });
}

class VideoCard extends StatelessWidget {
  final VideoItem video;

  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenVideoPlayer(
              videoUrl: video.videoUrl,
              title: video.title,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 48,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: video.category == "ADHD"
                            ? const Color(0xFFE91E63).withOpacity(0.15)
                            : const Color(0xFF2196F3).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        video.category,
                        style: TextStyle(
                          color: video.category == "ADHD"
                              ? const Color(0xFFE91E63)
                              : const Color(0xFF2196F3),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String title;

  const FullScreenVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.pink,
      ),
    );
  }
}
