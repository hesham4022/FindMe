import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/profile/data/model/user_profile_model.dart';
import 'package:find_me_app/features/profile/data/source/profile_remote.dart';

class ProfileRepo {
  final ProfileRemote _remoteSource;

  ProfileRepo(this._remoteSource);

  //! Comment Endpoints --------------------------------------------------------

  Future<Either<Failure, UserProfileModel>> getProfileData(int employeeId) {
    return executeFunctionality<UserProfileModel>(
      function: () async {
        final json = await _remoteSource.getProfileData(employeeId);
        return UserProfileModel.fromJson(json);
      },
    );
  }
}
