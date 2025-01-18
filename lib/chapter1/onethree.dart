import 'package:business_course/chapter1/budgetbuilder.dart';
import 'package:business_course/chapter1/spendinglimits.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'budgetpage.dart';
import 'budgetsummary.dart';

class OneThree extends StatefulWidget {
  @override
  _OneThreeState createState() => _OneThreeState();
}

class _OneThreeState extends State<OneThree> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset('lib/assets/voicechanger.mp4')
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
          '1.3 Credit Management and debt reduction',
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
              'Budget Builder',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              'Create a realistic personal budget to track and control spending',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 16),
            _buildCheckboxTile(context,
                title: 'Credit Tracker with improvement tips',
                navigateTo: BudgetBuilder()),
            // _buildCheckboxTile(context,
            //     title: 'Spending Limits', navigateTo: Spendinglimits()),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _launchURL('https://example.com/register'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Register for a live class',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _launchURL('https://example.com/coaching'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Request 1-on-1 coaching',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
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

  Widget _buildCheckboxTile(BuildContext context,
      {required String title, required Widget navigateTo}) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isChecked = false;
        return GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => navigateTo)),
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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
