part of 'profile_bloc.dart';

@immutable
class ProfileState{
  final bool isPhotoEmpty;
  final bool isNameEmpty;
  final bool isAgeEmpty;
  final bool isGenderEmpty;
  final bool isInterestedInEmpty;
  final bool isLocationEmpty;
  final bool isFailure;
  final bool isSubmitting;
  final bool isSuccess;

  bool get isFormValid => isPhotoEmpty && isNameEmpty  && isAgeEmpty & isGenderEmpty && isInterestedInEmpty;

  ProfileState({
    @required this.isPhotoEmpty,
    @required this.isNameEmpty,
    @required this.isAgeEmpty,
    @required this.isGenderEmpty,
    @required this.isInterestedInEmpty,
    @required this.isLocationEmpty,
    @required this.isFailure,
    @required this.isSubmitting,
    @required this.isSuccess,
});

  factory ProfileState.empty(){
    return ProfileState(isPhotoEmpty: false,
        isNameEmpty: false, isAgeEmpty: false,
        isGenderEmpty: false,
        isInterestedInEmpty: false,
        isLocationEmpty: false,
        isFailure: false,
        isSubmitting: false,
        isSuccess: false);
  }

  factory ProfileState.loading(){
    return ProfileState(isPhotoEmpty: false,
        isNameEmpty: false,
        isAgeEmpty: false,
        isGenderEmpty: false,
        isInterestedInEmpty: false,
        isLocationEmpty: false,
        isFailure: false,
        isSubmitting: true,
        isSuccess: false);
  }

  factory ProfileState.failure(){
    return ProfileState(isPhotoEmpty: false,
        isNameEmpty: false,
        isAgeEmpty: false,
        isGenderEmpty: false,
        isInterestedInEmpty: false,
        isLocationEmpty: false,
        isFailure: true,
        isSubmitting: false,
        isSuccess: false);
  }

  factory ProfileState.success(){
    return ProfileState(isPhotoEmpty: false,
        isNameEmpty: false,
        isAgeEmpty: false,
        isGenderEmpty: false,
        isInterestedInEmpty: false,
        isLocationEmpty: false,
        isFailure: false,
        isSubmitting: false,
        isSuccess: true);
  }

  ProfileState update({
    bool isPhotoEmpty,
    bool isNameEmpty,
    bool isAgeEmpty,
    bool isGenderEmpty,
    bool isInterestedInEmpty,
    bool isLocationEmpty,
  }){
    return copyWith(
        isPhotoEmpty: isPhotoEmpty,
        isNameEmpty: isNameEmpty,
        isAgeEmpty: isAgeEmpty,
        isGenderEmpty: isGenderEmpty,
        isInterestedInEmpty: isInterestedInEmpty,
        isLocationEmpty: isLocationEmpty,
        isFailure: false,
        isSubmitting: false,
        isSuccess: false
    );
  }

  ProfileState copyWith({
    bool isPhotoEmpty,
    bool isNameEmpty,
    bool isAgeEmpty,
    bool isGenderEmpty,
    bool isInterestedInEmpty,
    bool isLocationEmpty,
    bool isFailure,
    bool isSubmitting,
    bool isSuccess,
  }) {
    return ProfileState(
        isPhotoEmpty: isPhotoEmpty ?? this.isPhotoEmpty,
        isNameEmpty: isNameEmpty ?? this.isNameEmpty,
        isAgeEmpty: isAgeEmpty ?? this.isAgeEmpty,
        isGenderEmpty: isGenderEmpty ?? this.isGenderEmpty,
        isInterestedInEmpty: isInterestedInEmpty ?? this.isInterestedInEmpty,
        isLocationEmpty: isLocationEmpty ?? this.isLocationEmpty,
        isFailure: false ?? this.isFailure,
        isSubmitting: false ?? this.isSubmitting,
        isSuccess: false ?? this.isSuccess,
    );
  }
}