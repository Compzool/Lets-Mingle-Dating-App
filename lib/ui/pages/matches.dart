import 'package:mingle/bloc/matches/bloc.dart';
import 'package:mingle/models/user.dart';
import 'package:mingle/repositories/matchesRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';


class Matches extends StatefulWidget {
  final String userId;

  const Matches({this.userId});

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  MatchesRepository matchesRepository = MatchesRepository();
  MatchesBloc _matchesBloc;

  int difference;

  getDifference(GeoPoint userLocation) async {
    Position position = await Geolocator().getCurrentPosition();

    double location = await Geolocator().distanceBetween(userLocation.latitude,
        userLocation.longitude, position.latitude, position.longitude);

    difference = location.toInt();
  }

  @override
  void initState() {
    _matchesBloc = MatchesBloc(matchesRepository: matchesRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<MatchesBloc, MatchesState>(
      bloc: _matchesBloc,
      builder: (BuildContext context, MatchesState state) {
        if (state is LoadingState) {
          _matchesBloc.add(LoadListsEvent(userId: widget.userId));
          return CircularProgressIndicator();
        }
        if (state is LoadUserState) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                title: Text(
                  "Matched User",
                  style: TextStyle(color: Colors.black, fontSize: 30.0),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: state.matchedList,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SliverToBoxAdapter(
                      child: Container(),
                    );
                  }
                  if (snapshot.data.documents != null) {
                    final user = snapshot.data.documents;

                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                       return GestureDetector(
                       onTap: () async {
                         User selectedUser = await matchesRepository.getUserDetails(user[index].documentID);
                         User currentUser = await matchesRepository.getUserDetails(widget.userId);
                         await getDifference(selectedUser.location);
                         showDialog()
                    }
                        );
                 },
                );
              }
                  },
              )
          ],
        );
      }

                      return Container();
      },
                    );
                  }
}
