import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mingle/bloc/authentication/authentication_bloc.dart';
import 'package:mingle/bloc/authentication/authentication_event.dart';
import 'package:mingle/bloc/signup/bloc.dart';
import 'package:mingle/repositories/userRepository.dart';
import 'package:mingle/ui/constants.dart';

class SignUpForm extends StatefulWidget {
  final UserRepository _userRepository;
  SignUpForm({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignUpBloc _signUpBloc;
  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _signUpBloc = SignUpBloc(userRepository: _userRepository);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }

  void _onFormSubmitted() {
    _signUpBloc.add(SignUpWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener(
      bloc: _signUpBloc,
      listener: (BuildContext context, SignUpState state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..showSnackBar(SnackBar(
                content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Sign Up Failed"),
                Icon(Icons.error),
              ],
            )));
        }
        if (state.isSubmitting) {
          print("isSubmitting");
          Scaffold.of(context)
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Signing Up..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          print("Success");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder(
        bloc: _signUpBloc,
        builder: (BuildContext context, SignUpState state) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: backgroundColor,
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Mingle",
                      style: TextStyle(
                          fontSize: size.width * 0.2, color: Colors.white),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Divider(
                      height: size.height * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: TextFormField(
                      controller: _emailController,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isEmailValid ? "Invalid Email" : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: size.height * 0.03),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: TextFormField(
                      controller: _passwordController,
                      autocorrect: false,
                      obscureText: true,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isPasswordValid ? "Invalid Password" : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: size.height * 0.03),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.2),
                    child: GestureDetector(
                      onTap: isSignUpButtonEnabled(state)
                          ? _onFormSubmitted
                          : null,
                      child: Container(
                        width: size.width * 0.8,
                        height: size.height *0.86,
                        decoration: BoxDecoration(
                          color: isSignUpButtonEnabled(state)? Colors.white : Colors.grey,
                          borderRadius: BorderRadius.circular(size.height*0.05),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.blue
                            ),

                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChanged() {
    _signUpBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}