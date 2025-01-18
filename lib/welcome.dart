import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'studentdashboard.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late VideoPlayerController _videoController;
  List<bool> _checklistItems = List.generate(6, (_) => false);

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('lib/assets/introvideo.mp4')
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    child: Text(
                      'Welcome to Mastering Financial Health for Business Success',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2),
                _buildVideoPlayer(),
                SizedBox(height: 20),
                Text(
                  'Pre-course checklist: Financial documents you will need for this course.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                _buildChecklist(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentDashboard()),
                    );
                  },
                  child: Text('Ready to get started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return _videoController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_videoController),
                VideoProgressIndicator(_videoController, allowScrubbing: true),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _videoController.value.isPlaying
                            ? _videoController.pause()
                            : _videoController.play();
                      });
                    },
                    mini: true,
                    child: Icon(
                      _videoController.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _buildChecklist() {
    List<String> items = [
      'Proof of income (e.g., pay stubs, tax returns)',
      'Bank statements (last 3 months)',
      'EIN Letter from IRS',
      'State Incorporation Documents',
      'Copy of Driver\'s License',
      'All Accounts current with no past due balances',
    ];

    return Column(
      children: List.generate(
        items.length,
        (index) => CheckboxListTile(
          title: Text(items[index]),
          value: _checklistItems[index],
          onChanged: (bool? value) {
            setState(() {
              _checklistItems[index] = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }
}
