import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChapterOne extends StatefulWidget {
  @override
  _ChapterOneState createState() => _ChapterOneState();
}

class _ChapterOneState extends State<ChapterOne> {
  late VideoPlayerController _videoController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset('lib/assets/oneone.mp4')
      ..initialize().then((_) {
        setState(() {}); // Refresh the UI after initialization
      }).catchError((error) {
        print('Error initializing video player: $error'); // Log any errors
      })
      ..setLooping(true); // Enable looping
  }

  @override
  void dispose() {
    _videoController
        .dispose(); // Dispose of the controller to release resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F6F9), // Light background color
      appBar: AppBar(
        title: Text('Week 1'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center content
          children: [
            Text(
              'The Foundation of Success – Mastering Personal Finances',
              textAlign: TextAlign.center, // Center the paragraph
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16),

            // Video Player with Play Button Overlay
            _videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(_videoController),
                        if (!_isPlaying) // Show the play button if video is not playing
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _videoController.play();
                                _isPlaying = true;
                              });
                            },
                            child: Container(
                              color: Colors.black45, // Semi-transparent overlay
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        if (_isPlaying) // Pause the video on tap
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _videoController.pause();
                                _isPlaying = false;
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator()),

            SizedBox(height: 16),

            // Focus Area
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Focus Area:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Personal Financial Foundations',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10),

            // Progress Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Progress',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  width: 150,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[300],
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.3, // 30% progress
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Lessons List
            _buildLessonItem(
              context,
              title:
                  '1.1 The Connection Between Personal and Business Finances',
              route: '/oneone',
            ),
            _buildLessonItem(
              context,
              title: '1.2 Budgeting Basics',
              route: '/onetwo',
            ),
            _buildLessonItem(
              context,
              title: '1.3 Credit Management and Debt Reduction',
            ),
            _buildLessonItem(
              context,
              title: '1.4 Creating a Financial Snapshot',
            ),
            SizedBox(height: 10),

            // Test Your Knowledge Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your onPressed logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Test Your Knowledge',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Lesson Item Builder
  Widget _buildLessonItem(BuildContext context,
      {required String title, String? route}) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // Changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            // Lesson Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.grey), // Optional icon
          ],
        ),
      ),
    );
  }
}
