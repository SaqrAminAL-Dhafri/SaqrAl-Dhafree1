import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensure this is true
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A), // Dark blue
              Color(0xFF3B82F6), // Medium blue
              Color(0xFF8B5CF6), // Purple
              Color(0xFFEC4899), // Pink
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Stars background
            ...List.generate(50, (index) {
              return Positioned(
                left: (index * 37) % MediaQuery.of(context).size.width,
                top: (index * 67) % MediaQuery.of(context).size.height,
                child: Container(
                  width: 2,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
            
            // Main content
            SafeArea(
              child: SingleChildScrollView( // <--- Added SingleChildScrollView here
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Back button
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 20, bottom: 40),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      
                      // Lock icon with glow effect
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Glow effect
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF00D4FF).withOpacity(0.5),
                                    blurRadius: 30,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                            // Lock icon
                            Icon(
                              Icons.lock_reset_outlined,
                              size: 80,
                              color: Color(0xFF00D4FF),
                            ),
                          ],
                        ),
                      ),
                      
                      // "Change Password" text
                      Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      
                      SizedBox(height: 60),
                      
                      // Current password input field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.15),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _currentPasswordController,
                          obscureText: true,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Current Password',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            suffixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.white.withOpacity(0.7),
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                      
                      // New password input field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.15),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _newPasswordController,
                          obscureText: true,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'New Password',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            suffixIcon: Icon(
                              Icons.lock_open_outlined,
                              color: Colors.white.withOpacity(0.7),
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                      
                      // Confirm password input field
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.15),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            suffixIcon: Icon(
                              Icons.check_circle_outline,
                              color: Colors.white.withOpacity(0.7),
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                      
                      // Change password button
                      Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFEC4899), // Pink
                              Color(0xFFF97316), // Orange
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFEC4899).withOpacity(0.4),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle change password logic here
                            print('Change password pressed');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 30),
                      
                      // Bottom text
                      Text(
                        'Secure your account with a new password',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 40), // Added some bottom padding
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    @override
    void dispose() {
      _currentPasswordController.dispose();
      _newPasswordController.dispose();
      _confirmPasswordController.dispose();
      super.dispose();
    }
  }