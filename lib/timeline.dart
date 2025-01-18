import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TimelinePage extends StatelessWidget {
  final String zoomUrl = 'YOUR_ZOOM_URL_HERE'; // Replace with actual Zoom URL

  Future<void> _launchZoom() async {
    if (await canLaunch(zoomUrl)) {
      await launch(zoomUrl);
    } else {
      throw 'Could not launch $zoomUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: Text(
          'Student Newsfeed',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: InkWell(
                onTap: _launchZoom,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Live Sessions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Click Here to Enter our Zoom Classroom',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildPost(
              'Teri Evans',
              'Sed feugiat libero vel nisi luctus vehicula vestibulum luctus...',
              273,
              115,
              true,
            ),
            _buildPost(
              'Spruce Springclean',
              'Quisque venenatis velit sit amet sed ultrices dictum nunc...',
              273,
              115,
              false,
            ),
            _buildPost(
              'Ruby Von Rails',
              'Phasellus quis odio commodo, metus facilisis diam a, tincidunt',
              273,
              115,
              false,
            ),
            _buildPost(
              'Norman Gordon',
              'Aenean nec volutpat nisi. Ut facilisis tincidunt magna lorem, eget...',
              273,
              115,
              false,
            ),
            _buildPost(
              'Wisteria Ravenclaw',
              'Sed tincidunt consectetur enim and consectetur mauris eu est...',
              273,
              115,
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPost(
      String name, String content, int likes, int comments, bool isVerified) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[300],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (isVerified)
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child:
                            Icon(Icons.verified, color: Colors.blue, size: 16),
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.favorite_border,
                        size: 20, color: Colors.blue[300]),
                    SizedBox(width: 4),
                    Text('$likes'),
                    SizedBox(width: 16),
                    Icon(Icons.chat_bubble_outline,
                        size: 20, color: Colors.blue[300]),
                    SizedBox(width: 4),
                    Text('$comments'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
