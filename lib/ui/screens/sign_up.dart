import 'package:flutter/material.dart';
import 'package:chiventis/routes.dart';
import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:chiventis/ui/components/toast_message.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _createAccount(BuildContext context) async {
    setState(() => _isLoading = true);
    if (_formKey.currentState!.validate()) {
      // Mocked API call
      String email = _emailController.text;
      String password = _passwordController.text;
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String phone = _phoneController.text;

      if (phone.length != 11) {
        toastSuccess(context, 'Invalid phone number!',
            'Please enter a valid phone number.', false);
        setState(() => _isLoading = false);
        return;
      }

      // Replace this with your actual API call logic
      // For demonstration purposes, I'm just printing the email and password
      Map<String, dynamic> res = await AuthService.register(
        context,
        email,
        password,
        password,
        firstName,
        lastName,
        phone,
      );

      setState(() => _isLoading = false);

      if (res['success'] == true || res['status'] == true) {
        toastSuccess(context, 'Sign up successful!',
            'Check your email for your activation code.', true);
        Navigator.pushNamed(context, Routes.signUpSuccess, arguments: email);
      } else {
        print(res);
        toastSuccess(context, 'Sign up failed!', 'Please try again.', false);
      }
      // After successful creation, you can navigate to another page or do any other action
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Image(
                      image: const AssetImage('assets/logos/logo_small.png'),
                      height: screenWidth * 0.2,
                      width: screenWidth * 0.2),
                  SizedBox(height: screenHeight * 0.01),
                  const Text(
                    'Sign UP and start making cheap payments',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SourceSansPro',
                        color: Color(0xFF424242)),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.1,
                        left: screenHeight * 0.1,
                        right: screenHeight * 0.1,
                        bottom: 0,
                      ),
                      child: SizedBox(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          CustomTextInput(
                            labelText: 'First Name',
                            controller: _firstNameController,
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          CustomTextInput(
                            labelText: 'Last Name',
                            controller: _lastNameController,
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          CustomTextInput(
                            labelText: 'Email',
                            controller: _emailController,
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          CustomTextInput(
                            labelText: 'Mobile no.',
                            controller: _phoneController,
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          CustomTextInput(
                            labelText: 'Password',
                            controller: _passwordController,
                            isPassword: true,
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          CustomTextInput(
                            labelText: 'Re-enter Password',
                            controller: _confirmPasswordController,
                            isPassword: true,
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          ElevatedButton(
                            onPressed: () => _createAccount(context),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Adjust the border radius as needed
                                ),
                                backgroundColor:
                                    _isLoading ? Colors.grey : null),
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'SourceSansPro',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ))),
                  SizedBox(
                      height: screenHeight > 750
                          ? screenHeight * 0.15
                          : screenHeight * 0.05),
                  Transform.translate(
                    offset: const Offset(
                        0, 12), // This moves the widget 10 pixels down
                    child: const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SourceSansPro',
                        color: Color(0xFF424242),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: Text('LOGIN',
                        style: TextStyle(
                            fontSize: screenHeight * 0.015,
                            fontFamily: 'SourceSansPro',
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
