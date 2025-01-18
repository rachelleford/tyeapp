import 'package:business_course/journalentries.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OneOne extends StatefulWidget {
  @override
  _OneOneState createState() => _OneOneState();
}

class _OneOneState extends State<OneOne> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('lib/assets/onetwo.mp4')
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
      backgroundColor: Color(0xFFF1F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '1.1 The Connection Between Personal and Business Finances',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          maxLines: 2,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoPlayer(),
            SizedBox(height: 16),
            Text(
              'Activities',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(221, 0, 15, 154)),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            SizedBox(height: 14),
            _buildCheckboxTile(context,
                title:
                    'Reflection Activity: Identify One personal financial habit to improve'),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return _videoController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_videoController),
                if (!_videoController.value.isPlaying)
                  GestureDetector(
                    onTap: () => setState(() => _videoController.play()),
                    child: Container(
                      color: Colors.black45,
                      child:
                          Icon(Icons.play_arrow, color: Colors.white, size: 50),
                    ),
                  ),
              ],
            ),
          )
        : Container(
            height: 200,
            color: Colors.grey[200],
            child: Center(child: CircularProgressIndicator()),
          );
  }

  Widget _buildCheckboxTile(BuildContext context, {required String title}) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isChecked = false;
        return GestureDetector(
          onTap: () => _showReflectionDialog(context),
          child: Container(
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ],
            ),
            child: ListTile(
              title: Text(title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
              trailing: Checkbox(
                value: isChecked,
                onChanged: (bool? value) =>
                    setState(() => isChecked = value ?? false),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showReflectionDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reflection Activity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Identify one personal financial habit to improve.'),
              SizedBox(height: 10),
              TextField(
                controller: _controller,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your response here',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                JournalEntries.addEntry(
                    '1.1. The connections between personal and business finances',
                    _controller.text);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Journal entry saved')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
