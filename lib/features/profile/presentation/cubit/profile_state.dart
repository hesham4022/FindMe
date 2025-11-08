part of 'profile_cubit.dart';

enum ProfileStatus {
  initial,
  fetchProfileDataLoading,
  fetchProfileDataSuccess,
  fetchProfileDataError,
}

class ProfileState extends Equatable {
  final UserProfileModel? profileData;
  final ProfileStatus status;
  final SuccessResponse? success;
  final Failure? failure;

  const ProfileState({
    this.profileData,
    required this.status,
    this.success,
    this.failure,
  });

  bool get isInitial => status == ProfileStatus.initial;
  bool get isLoading => status == ProfileStatus.fetchProfileDataLoading;
  bool get isSuccess => status == ProfileStatus.fetchProfileDataSuccess;
  bool get isError => status == ProfileStatus.fetchProfileDataError;

  factory ProfileState.initial() {
    return const ProfileState(
      status: ProfileStatus.initial,
    );
  }

  ProfileState copyWith({
    UserProfileModel? profileData,
    ProfileStatus? status,
    SuccessResponse? success,
    Failure? failure,
  }) {
    return ProfileState(
      profileData: profileData ?? this.profileData,
      status: status ?? this.status,
      success: success ?? this.success,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        profileData,
        status,
        success,
        failure,
      ];
}