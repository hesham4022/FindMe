import 'package:find_me_app/core/shared/models/userdata.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserState {
  final UserModel? user;

  UserState({this.user});

  UserState copyWith({
    UserModel? user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }
}

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  void setUser(UserModel user) {
    emit(UserState(user: user));
  }

  void updateProfileImageLocal(String localPath) {
    if (state.user != null) {
      final updatedUser = state.user!.copyWith(localImage: localPath);
      emit(state.copyWith(user: updatedUser));

      // simulate upload
      uploadProfileImage(localPath);
    }
  }

  Future<void> uploadProfileImage(String localPath) async {
    await Future.delayed(const Duration(seconds: 2));

    const fakeServerUrl = "'https://i.pravatar.cc/120?img=12'";
    final updatedUser = state.user!.copyWith(
      imageUrl: fakeServerUrl,
      localImage: null,
    );

    emit(state.copyWith(user: updatedUser));
  }
}
