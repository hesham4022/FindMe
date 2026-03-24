import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/profile/data/model/update_profile_model.dart';
import 'package:find_me_app/features/profile/data/source/update_profile_remote.dart';

class UpdateProfileRepo {
  final UpdateProfileRemote _updateProfileRemote;
  UpdateProfileRepo(this._updateProfileRemote);

  Future<Either<Failure, UpdateProfileResponse>> updateProfile(
    UpdateProfileRequest request,
  ) {
    print('📡 [AuthRepo] Sending signup request again: ${request.toJson()}');
    return executeFunctionality<UpdateProfileResponse>(
      function: () async {
        final json = await _updateProfileRemote.updateProfile(request);
        final response = UpdateProfileResponse.fromMap(json);
        print('📩 [AuthRepo] Signup Response: $response');

        return response;
      },
    );
  }
}
