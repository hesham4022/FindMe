import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/date_time_helper.dart';
import 'package:find_me_app/core/helpers/enums/date.dart';
import 'package:find_me_app/core/resources/images.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/features/profile/data/model/user_profile_model.dart';

class InfoTileModel {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;

  const InfoTileModel({
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
  });
}

class ProfileInfoModel {
  final String? leadingImg;
  final String? titleKey;
  final String? titleValue;
  final String? subtitle1;
  final String? subtitle2;

  const ProfileInfoModel({
    this.leadingImg,
    this.titleKey,
    this.titleValue,
    this.subtitle1,
    this.subtitle2,
  });
}

//! Personal Info ----------------------------------------------------
List<ProfileInfoModel> kPersonalInfoList(UserProfileModel profileData) {
  return [
    if (profileData.personalInfo?.fullName != null)
      ProfileInfoModel(
        //  leadingImg: AppImages.fullName,
        titleKey: AppStrings.fullName,
        titleValue: profileData.name ?? '',
      ),
    if (profileData.personalInfo?.nationality != null)
      ProfileInfoModel(
        //leadingImg: AppImages.nationality,
        titleKey: AppStrings.nationality,
        titleValue: profileData.personalInfo?.nationality ?? '',
      ),
    if (profileData.personalInfo?.nationalNum != null)
      ProfileInfoModel(
        //leadingImg: AppImages.nationalId,
        titleKey: AppStrings.nationalId,
        titleValue: profileData.personalInfo?.nationalNum ?? '',
      ),
    if (profileData.personalInfo?.gender != null)
      ProfileInfoModel(
        //leadingImg: AppImages.gender,
        titleKey: AppStrings.gender,
        titleValue: profileData.personalInfo?.gender,
      ),
    if (profileData.personalInfo?.birthDate != null)
      ProfileInfoModel(
        // leadingImg: AppImages.birthDate,
        titleKey: AppStrings.birthDate,
        titleValue: DateTimeHelper.formatterCustom2
                .format(profileData.personalInfo?.birthDate) ??
            "",
      ),
    if (profileData.personalInfo?.religion != null)
      ProfileInfoModel(
        // leadingImg: AppImages.religion,
        titleKey: AppStrings.religion,
        titleValue: profileData.personalInfo?.religion,
      ),
    if (profileData.personalInfo?.maritalStatus != null)
      ProfileInfoModel(
        // leadingImg: AppImages.martialStatus,
        titleKey: AppStrings.maritalStatus,
        titleValue: profileData.personalInfo?.maritalStatus,
      ),
    if (profileData.personalInfo?.homeCountry != null)
      ProfileInfoModel(
        //   leadingImg: AppImages.home,
        titleKey: AppStrings.homeCountry,
        titleValue: profileData.personalInfo?.homeCountry,
      ),
    if (profileData.personalInfo?.address != null)
      ProfileInfoModel(
        // leadingImg: AppImages.city,
        titleKey: AppStrings.homeCity,
        titleValue: profileData.personalInfo?.address,
      ),
    if (profileData.personalInfo?.email != null)
      ProfileInfoModel(
        //   leadingImg: AppImages.email,
        titleKey: AppStrings.email,
        titleValue: profileData.personalInfo?.email,
      ),
    if (profileData.personalInfo?.mobile != null)
      ProfileInfoModel(
        //  leadingImg: AppImages.mobile,
        titleKey: AppStrings.mobile,
        titleValue: profileData.personalInfo?.mobile,
      ),
  ];
}

//! Financial Info ----------------------------------------------------
List<ProfileInfoModel> kFinancialInfoList(UserProfileModel profileData) {
  return [
    if (profileData.financialInfo?.basicSalary != null)
      ProfileInfoModel(
        titleKey: AppStrings.basicSalary,
        titleValue: "${profileData.financialInfo?.basicSalary ?? ''} SAR",
      ),
    if (profileData.financialInfo?.grossSalary != null)
      ProfileInfoModel(
        titleKey: AppStrings.grossSalary,
        titleValue: "${profileData.financialInfo?.grossSalary ?? ''} SAR",
      ),
    ProfileInfoModel(
      titleKey: AppStrings.yearlySalary,
      titleValue: profileData.financialInfo?.yearlySalaries?.toString() ?? '',
    ),
    if (profileData.financialInfo?.paymentMethod != null)
      ProfileInfoModel(
        titleKey: AppStrings.paymentMethod,
        titleValue: profileData.financialInfo?.paymentMethod,
      ),
    if (profileData.financialInfo?.bankName != null)
      ProfileInfoModel(
        titleKey: AppStrings.bankName,
        titleValue: profileData.financialInfo?.bankName,
      ),
    if (profileData.financialInfo?.endOfServiceIncluded != null)
      ProfileInfoModel(
        titleKey: AppStrings.endOfService,
        titleValue: profileData.financialInfo?.endOfServiceIncluded,
      ),
    if (profileData.financialInfo?.gosi != null)
      ProfileInfoModel(
        titleKey: AppStrings.gosi,
        titleValue: profileData.financialInfo?.gosi,
      ),
    if (profileData.personalInfo?.homeCountry != null)
      ProfileInfoModel(
        titleKey: AppStrings.homeCountry,
        titleValue: profileData.personalInfo?.homeCountry,
      ),
    if (profileData.personalInfo?.homeCity != null)
      ProfileInfoModel(
        titleKey: AppStrings.homeCity,
        titleValue: profileData.personalInfo?.homeCity,
      ),
    if (profileData.personalInfo?.email != null)
      ProfileInfoModel(
        titleKey: AppStrings.email,
        titleValue: profileData.personalInfo?.email,
      ),
    if (profileData.personalInfo?.mobile != null)
      ProfileInfoModel(
        titleKey: AppStrings.mobile,
        titleValue: profileData.personalInfo?.mobile,
      ),
  ];
}

//! Allowances Info ----------------------------------------------------
List<ProfileInfoModel> kAllowancesList(UserProfileModel profileData) {
  return profileData.allowances
      .map((item) => ProfileInfoModel(
            titleKey: item?.allowanceType ?? '',
            titleValue: "${item?.amount ?? ""} SAR",
          ))
      .toList();
}

List<ProfileInfoModel> kNonPayrollBenefitsList(UserProfileModel profileData) {
  return profileData.noPayBenefits
      .map((item) => ProfileInfoModel(
            titleKey: item?.description ?? '',
            titleValue: "${item?.amount ?? ""} SAR",
          ))
      .toList();
  // return [
  //   ProfileInfoModel(
  //     titleKey: AppStrings.gymSubscription,
  //     titleValue: "Ends on 25-Oct-2024",
  //   ),
  //   ProfileInfoModel(
  //     titleKey: AppStrings.parking,
  //     titleValue: "Available",
  //   ),
  // ];
}

List<ProfileInfoModel> kPermanentDeductionsList(UserProfileModel profileData) {
  return profileData.deductions
      .map((item) => ProfileInfoModel(
            titleKey: item?.deductionType ?? '',
            titleValue: "${item?.amount ?? ""} SAR",
          ))
      .toList();
}

List<ProfileInfoModel> kHealthInsuranceList(UserProfileModel profileData) {
  return profileData.deductions
      .map((item) => ProfileInfoModel(
            titleKey: item?.deductionType ?? '',
            titleValue: "${item?.amount ?? ""} SAR",
          ))
      .toList();
}

List<ProfileInfoModel> kBankInfoList(UserProfileModel profileData) {
  // final UserProfileModel? profileData =
  //     context.watch<ProfileCubit>().state.profileData;
  return [
    if (profileData.financialInfo?.bankName != null)
      ProfileInfoModel(
        titleKey: AppStrings.bankName,
        titleValue: profileData.financialInfo?.bankName ?? "",
      ),
    if (profileData.financialInfo?.iban != null)
      ProfileInfoModel(
        titleKey: AppStrings.iban,
        titleValue: profileData.financialInfo?.iban ?? "",
      ),
  ];
}

//! Employment Info ----------------------------------------------------
List<ProfileInfoModel> kEmploymentInfoList(UserProfileModel profileData) {
  return [
    ProfileInfoModel(
      titleKey: AppStrings.company,
      titleValue: profileData.employmentInfo?.company ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.branch,
      titleValue: profileData.employmentInfo?.branch ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.sponsor,
      titleValue: profileData.employmentInfo?.sponsor ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.hierarchy,
      titleValue: profileData.employmentInfo?.hierarchy ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.hiringDate,
      titleValue: profileData.employmentInfo?.hiringDate?.toYMDFormat ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.joinDate,
      titleValue: profileData.employmentInfo?.joinDate?.toYMDFormat ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.contractType,
      titleValue: profileData.employmentInfo?.contractType ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.contractStartDate,
      titleValue:
          profileData.employmentInfo?.contractStartDate?.toYMDFormat ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.contractEndDate,
      titleValue:
          profileData.employmentInfo?.contractEndDate?.toYMDFormat ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.employmentType,
      titleValue: profileData.employmentInfo?.employmentType ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.workClass,
      titleValue: profileData.employmentInfo?.workClass ?? "",
    ),
    ProfileInfoModel(
      titleKey: AppStrings.salaryScale,
      titleValue: profileData.employmentInfo?.salaryScalePackage ?? "",
    ),
  ];
}

List<ProfileInfoModel> kContractsList(UserProfileModel? profileData) {
  return profileData?.employmentInfo?.contracts
          .map((item) => ProfileInfoModel(
                titleKey: item.contractType ?? '',
                // titleValue: "${item.fromDate ?? ""} SAR",
                subtitle1: "${item.fromDate ?? ""} SAR",
                subtitle2: "${item.toDate ?? ""} SAR",
              ))
          .toList() ??
      []; // Ensure it returns an empty list if profileData is null
}
