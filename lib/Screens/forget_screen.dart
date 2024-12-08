import 'package:flutter/material.dart';
import '../api_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  String message = '';

  /// Validate Email
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  /// Handle Forgot Password Request
  void handleForgotPassword() async {
    final email = emailController.text.trim();

    if (!_isValidEmail(email)) {
      setState(() {
        message = "Please enter a valid email address.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      final response = await ApiService.requestPasswordReset(email);

      setState(() {
        isLoading = false;
        message = response['message'] ?? 'Check your email for further instructions.';
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        message = 'Failed to send reset instructions. Please try again later.';
      });
      print('Error during forgot password: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: InkWell(
        splashColor: Colors.white,
        highlightColor: Colors.white,
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double height = constraints.maxHeight;
            double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
            double availableHeight = height - keyboardHeight;

            return SingleChildScrollView(
              child: Center(
                child: Padding(

                  padding: EdgeInsets.only(top: availableHeight > 300 ? 50.0 : 20.0, bottom: 20.0,left:20,right:20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Forgot Password",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      _buildTextField("Your Email", emailController),
                      _buildSubmitButton(),
                      if (message.isNotEmpty) _buildMessage(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }



  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 24.0),
      child: isLoading
          ? CircularProgressIndicator()
          : ElevatedButton(
        onPressed: handleForgotPassword,
        //child: Text("Send Reset Instructions"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : Text(
          'Send Reset Instructions',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: message.contains('Check your email') ? Colors.green : Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
