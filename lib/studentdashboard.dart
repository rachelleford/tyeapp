import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'chapter1/chapterone.dart';
import 'chaptertwo.dart';
import 'chapterthree.dart';
import 'chapterfour.dart';
import 'timeline.dart';
import 'profilepage.dart';
import 'resourcespage.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    _DashboardHome(),
    TimelinePage(),
    ResourcesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F6F9), // Updated background color
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Timeline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _DashboardHome extends StatefulWidget {
  @override
  State<_DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<_DashboardHome> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    // Initialize the VideoPlayerController with the local asset
    _videoController = VideoPlayerController.asset('lib/assets/introvideo.mp4')
      ..initialize().then((_) {
        setState(() {}); // Refresh the UI after initialization
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Course Outline',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 16),
              _videoController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          VideoPlayer(_videoController),
                          VideoProgressIndicator(
                            _videoController,
                            allowScrubbing: true,
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (_videoController.value.isPlaying) {
                                    _videoController.pause();
                                  } else {
                                    _videoController.play();
                                  }
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
                  : Center(child: CircularProgressIndicator()),
              SizedBox(height: 20),
              _buildCollapsibleSection(
                'Here’s what you can expect:',
                [
                  _buildTextSection(
                    'Purpose of the Course:',
                    '- Not just about numbers, but about changing your mindset.\n'
                        '- Understand the story behind your finances.\n'
                        '- Create a sustainable plan for success.',
                  ),
                  _buildTextSection(
                    'Who It’s For:',
                    '- Ideal for budding entrepreneurs and established business owners.\n'
                        '- Designed to bridge the gap between your current financial status and your goals.',
                  ),
                  _buildTextSection(
                    'Course Structure:',
                    '- Delivered in an engaging, step-by-step format through our dedicated app.\n'
                        '- Includes interactive activities, guided reflections, and actionable exercises.',
                  ),
                  _buildTextSection(
                    'Key Areas of Focus (over 4 weeks):',
                    '- Week 1: Mastering personal financial principles.\n'
                        '- Week 2: Developing a business financial blueprint.\n'
                        '- Week 3: Financial planning and growth strategies.\n'
                        '- Week 4: Creating a lasting financial legacy.',
                  ),
                  _buildTextSection(
                    'By the End of the Course, You Will Gain:',
                    '- A deep understanding of your financial habits and mindset.\n'
                        '- Practical tools to manage personal and business finances effectively.\n'
                        '- A roadmap to scale your business and create a lasting financial legacy.',
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Your Progress:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.25,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(height: 30),
              Text(
                'Course Curriculum:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.7,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final weeks = [
                    'The Foundation of Success – Mastering Personal Finances',
                    'Building a Business Financial Blueprint',
                    'Scaling with Strategy – Financial Planning and Growth',
                    'Future-Proofing Your Financial Legacy'
                  ];
                  final weekTitles = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                  return _buildCourseCard(
                      context, weekTitles[index], weeks[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsibleSection(String title, List<Widget> content) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      children: content,
    );
  }

  Widget _buildTextSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
      BuildContext context, String week, String description) {
    return GestureDetector(
      onTap: () {
        switch (week) {
          case 'Week 1':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChapterOne()),
            );
            break;
          case 'Week 2':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChapterTwo()),
            );
            break;
          case 'Week 3':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChapterThree()),
            );
            break;
          case 'Week 4':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChapterFour()),
            );
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        padding:
            EdgeInsets.symmetric(horizontal: 6, vertical: 6), // Reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 15, 120, 247),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                week,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 6),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
