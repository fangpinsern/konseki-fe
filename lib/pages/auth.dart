import 'package:flutter/material.dart';
import 'package:konseki_app/main.dart';
import 'package:konseki_app/providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: const [
                Text(
                  "Welcome to Konseki",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AuthCard(),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
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
  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  var _isLoading = false;

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    // setState(() {
    //   _isLoading = true;
    // });
    if (_authMode == AuthMode.Login) {
      Provider.of<Auth>(context, listen: false).login(
        _authData['email']!,
        _authData['password']!,
      );
    } else {
      Provider.of<Auth>(context, listen: false).register(
        _authData['name']!,
        _authData['email']!,
        _authData['password']!,
      );
    }
    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pushReplacementNamed("/home");
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
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
        constraints: BoxConstraints(minHeight: 260),
        width: deviceSize.width * 0.8,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
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
                      _authData['email'] = val;
                    },
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
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
                  decoration: InputDecoration(labelText: "Password"),
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
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: Container(
                      width: deviceSize.width * 0.8,
                      child: Text(
                        _authMode == AuthMode.Login ? "Login" : "Register",
                        textAlign: TextAlign.center,
                      )),
                ),
                TextButton(
                  onPressed: _switchAuthMode,
                  child:
                      Text(_authMode == AuthMode.Login ? "Register" : "Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
