import 'package:mingle/bloc/authentication/authentication_bloc.dart';
import 'package:mingle/bloc/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mingle/ui/constants.dart';
import 'package:mingle/ui/pages/matches.dart';
import 'package:mingle/ui/pages/messages.dart';
import 'package:mingle/ui/pages/search.dart';


class Tabs extends StatelessWidget {
  final String userId;
  const Tabs({this.userId});
  @override
  Widget build(BuildContext context) {
    List<Widget> pages =[
      Search(),
      Matches(),
      Messages(),
    ];
    return Theme(data: ThemeData(
      primaryColor: backgroundColor,
      accentColor: Colors.white,
    ), child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Chill",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: (){})
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Container(
              height: 48.0,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TabBar(
                      tabs: <Widget>[
                        Tab(icon: Icon(Icons.search)),
                        Tab(icon: Icon(Icons.people)),
                        Tab(icon: Icon(Icons.message)),
                      ]
                  )
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
