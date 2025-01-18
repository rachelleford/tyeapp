import 'package:flutter/material.dart';

class ChapterFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Back Button and Header
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.blue[700],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Week 1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Objective:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Lay the groundwork for financial success by mastering personal finance skills essential for building a thriving business.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Focus Areas:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildFocusArea(
                          'The Connection Between Personal and Business Finances: Understanding how personal financial health influences business stability.',
                        ),
                        _buildFocusArea(
                          'Budgeting for Impact: Learn practical strategies to create a zero-based budget tailored to your lifestyle and business goals.',
                        ),
                        _buildFocusArea(
                          'Credit Mastery: Explore the basics of credit management, improving credit scores, and leveraging credit effectively.',
                        ),
                        _buildFocusArea(
                          'Debt Elimination: Identify high-impact methods to reduce debt while building wealth.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Activities Section
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activities & Deliverables:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildActivityItem('1',
                        'Create a detailed personal budget using provided templates.'),
                    _buildActivityItem('2',
                        'Assess spending habits with a "Money Mindset Journal" exercise.'),
                    _buildActivityItem('3',
                        'Set SMART (Specific, Measurable, Achievable, Relevant, Time-Bound) financial goals to achieve within the next 6 months.'),
                    _buildActivityItem('4',
                        'Receive curated tools to track personal financial progress.'),
                    Spacer(),
                    // Quiz Button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add quiz navigation logic here
                        },
                        child: Text('Complete the Quiz'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFA726),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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

  Widget _buildFocusArea(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: Colors.white, fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
