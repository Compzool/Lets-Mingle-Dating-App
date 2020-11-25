//import 'package:formz/formz.dart';
class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
// enum isValidEmail { invalid }
//
// class Email extends FormzInput<String, isValidEmail> {
//   const Email.pure() : super.pure('');
//   const Email.dirty([String value = '']) : super.dirty(value);
//
//   static final RegExp _emailRegExp = RegExp(
//     r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
//   );
//
//   @override
//   isValidEmail validator(String value) {
//     return _emailRegExp.hasMatch(value) ? null : isValidEmail.invalid;
//   }
// }
// enum isValidPassword { invalid }
//
// class Password extends FormzInput<String, isValidPassword> {
//   const Password.pure() : super.pure('');
//   const Password.dirty([String value = '']) : super.dirty(value);
//
//   static final _passwordRegExp =
//   RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
//
//   @override
//   isValidPassword validator(String password) {
//     return _passwordRegExp.hasMatch(password)
//         ? null
//         : isValidPassword.invalid;
//   }
// }