import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  String selectedRole = 'Student'; // Default selected role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 40),
              color: Color.fromARGB(255, 222, 232, 241), // Dark teal background
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/tye.png',
                    height: 100, // Adjust the height as needed
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            // Rest of the content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 40),
                        // Subtitle
                        Text(
                          'Mastering Financial Health for Business Success',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'A Transformative 4-Week Journey to Strengthen Personal and Business Finances',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 80),
                        // Role Selection
                        Text(
                          'Choose Your Role',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildRoleCard(
                                'Student', selectedRole == 'Student'),
                            SizedBox(width: 20),
                            _buildRoleCard(
                                'Teacher', selectedRole == 'Teacher'),
                          ],
                        ),
                      ],
                    ),
                    // Create Account Button
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (selectedRole == 'Student') {
                              Navigator.pushNamed(context, '/login');
                            } else {
                              print('Teacher role selected.');
                              // Implement teacher role navigation here
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            child: Text(
                              'Create an Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
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

  Widget _buildRoleCard(String role, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
        if (role == 'Student') {
          Navigator.pushNamed(context, '/login');
        } else {
          print('Teacher role selected.');
          // Implement teacher role navigation here
        }
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : const Color.fromARGB(255, 255, 177, 59),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected ? Colors.blue : const Color.fromARGB(255, 16, 6, 6),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            role,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
