import 'package:flutter/material.dart';
import 'package:konseki_app/models/http_exceptions.dart';
import 'package:konseki_app/providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { signup, login }

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Welcome to Konseki",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 20,
              ),
              const AuthCard(),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.login;

  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  var _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      // return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['name']!,
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = 'This email address is already used';
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = 'Email address is not valid';
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = 'Use a stronger password';
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = 'Cannot find user with this email';
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = 'Invalid email or password';
      } else {
        errorMessage = 'something went wrong';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Could not authenticate. Please try again later';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Error",
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Okay",
            ),
          )
        ],
      ),
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        // height: deviceSize.height * 0.2,
        constraints: const BoxConstraints(
          minHeight: 260,
        ),
        width: deviceSize.width * 0.8,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null) {
                        return 'Name is required';
                      }
                      if (val.isEmpty) {
                        return 'Name is required';
                      }

                      return null;
                    },
                    onSaved: (val) {
                      if (val == null) {
                        return;
                      }
                      _authData['name'] = val;
                    },
                  ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null) {
                      return 'Invalid email.';
                    }
                    if (val.isEmpty || !val.contains('@')) {
                      return 'Invalid email!';
                    }

                    return null;
                  },
                  onSaved: (val) {
                    if (val == null) {
                      return;
                    }
                    _authData['email'] = val;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (val) {
                    if (val == null) {
                      return 'Invalid password.';
                    }
                    if (val.isEmpty || val.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    if (val == null) {
                      return;
                    }
                    _authData['password'] = val;
                  },
                ),
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.signup,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    obscureText: true,
                    validator: _authMode == AuthMode.signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                        : null,
                  ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: SizedBox(
                      width: deviceSize.width * 0.8,
                      child: Text(
                        _authMode == AuthMode.login ? "Login" : "Register",
                        textAlign: TextAlign.center,
                      )),
                ),
                TextButton(
                  onPressed: _switchAuthMode,
                  child:
                      Text(_authMode == AuthMode.login ? "Register" : "Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
