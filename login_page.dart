import 'package:flutter/material.dart';
import 'package:app_login/login/login_page.dart';
import 'package:app_login/login/register_page.dart';
import 'package:app_login/login/theme.dart';
import 'package:app_login/login/widgets/custom_checkbox.dart';
import 'package:app_login/login/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'theme.dart';

class login_page extends StatefulWidget {
  @override
  login_page createState() => login_page();
}

class login_page extends State<login_page> {
  bool passwordVisible = false;

  get value => null;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  Future<bool> _loginProses() async {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final prefs = await SharedPreferences.getInstance();
    var response = await http
        .post(Uri.parse('http://192.168.106.91:8000/api/Login'), body: {});

    saveDataSF() async {
      final localStorage = await SharedPreferences.getInstance();
      localStorage.setString('email', _emailController.toString());
      localStorage.setString('password', value.toString());

      if (localStorage.containsKey('myData')) {
        localStorage.clear();
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login to your\naccount',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/accent.png',
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: heading6.copyWith(color: textGrey),
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomCheckbox(),
                    SizedBox(
                      width: 12,
                    ),
                    Text('Remember me', style: regular16pt),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                CustomPrimaryButton(
                  buttonColor: primaryBlue,
                  textValue: 'Login',
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text(
                    'OR',
                    style: heading6.copyWith(color: textGrey),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                CustomPrimaryButton(
                  buttonColor: Color(0xfffbfbfb),
                  textValue: 'Login with Google',
                  textColor: textBlack,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        'Register',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      ;
    }
  }
}
