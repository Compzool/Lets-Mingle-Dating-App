import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mingle/bloc/blocdelegate.dart';
import 'package:mingle/repositories/userRepository.dart';
import 'package:mingle/ui/pages/home.dart';
import 'bloc/authentication/bloc.dart';


main(){
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository _userRepository = UserRepository();
  BlocSupervisor.delegate = SimpleBlocDelegate();


  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: _userRepository)
        ..add(AppStarted()),
      child: Home(userRepository: _userRepository)));

}

