import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mingle/bloc/blocdelegate.dart';
import 'package:mingle/ui/pages/home.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate = SimpleBlocDelegate();

  await Firebase.initializeApp();

  runApp(Home());

}