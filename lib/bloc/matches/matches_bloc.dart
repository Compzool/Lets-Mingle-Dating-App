import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'matches_event.dart';
part 'matches_state.dart';

//class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
//  MatchesBloc() : super(MatchesInitial());

  @override
  Stream<MatchesState> mapEventToState(
    MatchesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
