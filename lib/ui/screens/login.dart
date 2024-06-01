import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:chiventis/routes.dart';
import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/ui/components/custom_text_input.dart';
import 'package:local_auth/local_auth.dart';
import 'package:chiventis/ui/components/finger_print_authentication.dart';
import '../components//toast_message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final LocalAuthentication auth;
  bool wantToLoginWithBiometrics = false;
  bool _initialized = false;
  bool _isLoading = false;
  bool _fingerPrintLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAsyncLogic();
  }

  Future<void> _initializeAsyncLogic() async {
    await Future.delayed(Duration.zero);
    bool fingerPrint = await AuthService.getFingerPrint();
    if (fingerPrint) {
      bool isAuthenticated = await FingerPrintAuthentication.authentication();
      if (isAuthenticated) {
        toastSuccess(context, "Authentication successful.",
            'You can continue your journey.', true);
        Navigator.pushReplacementNamed(context, Routes.home);
      } else {
        toastSuccess(context, "Authentication failed.", 'Try again.', false);
      }
    }
    setState(() {
      _initialized = true;
      _isLoading = false;
      _fingerPrintLoading = false;
    });
  }

  void _login(BuildContext context, bool isFingerPrint) async {
    setState(
        () => isFingerPrint ? _fingerPrintLoading = true : _isLoading = true);

    String email = _emailController.text;
    String password = _passwordController.text;
    final Map<String, dynamic> res =
        await AuthService.login(context, email, password);
    await AuthService.useFingerPrint(wantToLoginWithBiometrics);
    setState(() {
      _isLoading = false;
      _fingerPrintLoading = false;
    });

    if (res['succes'] == true || res['status'] == true) {
      toastSuccess(
          context, 'Verification Successful!', 'Please login now.', true);
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      toastSuccess(
          context,
          'Wrong Credentials!',
          'Please try again. Forgotten your password? tap Forgot password below.',
          false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      // Return a loading indicator or placeholder until the initialization is complete
      return const CircularProgressIndicator();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        // Light gray background color

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: screenHeight * 0.02),
                  Image(
                      image: const AssetImage('assets/logos/logo_small.png'),
                      height: screenWidth * 0.5,
                      width: screenWidth * 0.5),
                  const Text(
                    'Hello, Welcome to ChiVenDIS',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SourceSansPro',
                        color: Color(0xFF424242)),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  SizedBox(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.05,
                    child: CustomTextInput(
                      labelText: 'Email or Mobile no.',
                      controller: _emailController,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.05,
                    child: CustomTextInput(
                      labelText: 'Password',
                      controller: _passwordController,
                      isPassword: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.15),
                    child: Transform.translate(
                      offset: const Offset(
                          0, -12), // This moves the widget 10 pixels up
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.forgotPassword);
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                                fontSize: 12, fontFamily: 'SourceSansPro'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => {
                          wantToLoginWithBiometrics = true,
                          _login(context, true)
                        },
                        icon: Icon(Icons.fingerprint,
                            color: _fingerPrintLoading ? Colors.black26 : null),
                        iconSize: screenWidth * 0.1,
                      ),
                      Transform.translate(
                        offset: const Offset(-20,
                            0), // This moves the widget 10 pixels to the left
                        child: TextButton(
                          onPressed: () {
                            wantToLoginWithBiometrics = true;
                            _login(context, true);
                          },
                          child: Text(
                            'I want to login with Biometrics next time',
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color:
                                  _fingerPrintLoading ? Colors.black26 : null,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                      height: screenHeight > 750
                          ? screenHeight * 0.2
                          : screenHeight * 0.1),
                  ElevatedButton(
                    onPressed: () => _login(context, false),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(128, 40),
                      backgroundColor: _isLoading ? Colors.grey : null,
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(
                        0, 14), // This moves the widget 10 pixels up
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'SourceSansPro',
                        color: Color(0xFF424242),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.signUp);
                    },
                    child: const Text(
                      'SIGN UP!',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
