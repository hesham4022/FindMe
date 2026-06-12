import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/age_filter/data/source/age_filter_remote.dart';

class AgeFilterRepo {
  AgeFilterRemote _ageFilterRemote;
  AgeFilterRepo(this._ageFilterRemote);

  Future<Either<Failure, String>> applyAgeFilter(AgeFilterRequest request) {
    return executeFunctionality<String>(
      function: () async {
        final imageUrl = await _ageFilterRemote.applyAgeFilter(request);
        print('📩 [AgeFilterRepo] Result URL: $imageUrl');
        return imageUrl;
      },
    );
  }
}
