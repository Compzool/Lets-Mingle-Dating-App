import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mingle/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mingle/bloc/authentication/bloc.dart';
import 'package:mingle/repositories/userRepository.dart';
import 'package:mingle/ui/constants.dart';
import 'package:mingle/ui/pages/matches.dart';
import 'package:mingle/ui/pages/messages.dart';
import 'package:mingle/ui/pages/profile.dart';
import 'package:mingle/ui/pages/search.dart';
import 'package:mingle/ui/widgets/profileForm.dart';

import '../../main.dart';

class Tabs extends StatelessWidget {
  final  _userRepository;
  final  userId;
  Tabs({@required UserRepository userRepository, String userId})
      : assert(userRepository != null),
        _userRepository = userRepository,userId = userId;




  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Search(
        userId: userId,
      ),
      Matches(
        userId: userId,
      ),
      Messages(
        userId: userId,
      ),
    ];
    return Theme(
        data: ThemeData(
          primaryColor: backgroundColor,
          accentColor: Colors.white,
        ),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: Icon(Icons.account_circle ,color:Colors.black) ,
                  onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(userRepository: _userRepository,userId: userId,)));}),
              centerTitle: true,
              title: Text(
                "Mingle",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),

              actions: <Widget>[

                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
                    })
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(48.0),
                child: Container(
                  height: 48.0,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TabBar(tabs: <Widget>[
                        Tab(icon: Icon(Icons.search)),
                        Tab(icon: Icon(Icons.people)),
                        Tab(icon: Icon(Icons.message)),
                      ])
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: pages,
            ),
          ),
        ));
  }
}
