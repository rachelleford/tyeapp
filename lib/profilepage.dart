import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue rectangle at top
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),

            // Profile section
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile image and settings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.mail_outline),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Name and description
                  Text(
                    'Valentino Morose',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This could be a space that will feature the students ultimate goal or current thoughts as a reminder to them.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 24),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Add new Post'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Add new Goal'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Completed forms list
                  _buildCompletedForm(Icons.lock_outline, 'Completed Form'),
                  _buildCompletedForm(
                      Icons.notifications_none, 'Completed Form'),
                  _buildCompletedForm(Icons.share_outlined, 'Completed Form'),
                  _buildCompletedForm(Icons.phone_iphone, 'Completed Form'),
                  _buildCompletedForm(
                      Icons.file_copy_outlined, 'Completed Form'),
                  _buildCompletedForm(
                      Icons.computer_outlined, 'Completed Form'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedForm(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.grey[600], size: 24),
          ),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
          Spacer(),
          Icon(Icons.chevron_right, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
