// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:find_me_app/core/helpers/enums/date.dart';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  final String? id;
  final String? name;
  final String? jobTitle;
  final String? profilePicture;
  final String? email;
  final String? directManagerName;
  final List<Experience?> experiences;
  final List<Certificate?> certificates;
  final List<Allowance?> allowances;
  final List<NoPayBenefit?> noPayBenefits;
  final List<Deduction?> deductions;
  final PersonalInfo? personalInfo;
  final FinancialInfo? financialInfo;
  final EmploymentInfo? employmentInfo;
  final Status? status;

  UserProfileModel({
    this.id,
    this.name,
    this.jobTitle,
    this.profilePicture,
    this.email,
    this.directManagerName,
    this.experiences = const [],
    this.certificates = const [],
    this.allowances = const [],
    this.noPayBenefits = const [],
    this.deductions = const [],
    this.personalInfo,
    this.financialInfo,
    this.employmentInfo,
    this.status,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"],
        name: json["name"],
        jobTitle: json["jobTitle"],
        profilePicture: json["profilePicture"],
        email: json["email"],
        directManagerName: json["directManagerName"],
        experiences: json["experiences"] == null
            ? []
            : List<Experience?>.from(json["experiences"]!
                .map((x) => x == null ? null : Experience.fromJson(x))),
        certificates: json["certificates"] == null
            ? []
            : List<Certificate?>.from(json["certificates"]
                ?.map((x) => x == null ? null : Certificate.fromJson(x))),
        allowances: json["allowances"] == null
            ? []
            : List<Allowance?>.from(json["allowances"]!
                .map((x) => x == null ? null : Allowance.fromJson(x))),
        noPayBenefits: json["noPayBenefits"] == null
            ? []
            : List<NoPayBenefit?>.from(json["noPayBenefits"]!
                .map((x) => x == null ? null : NoPayBenefit.fromJson(x))),
        deductions: json["deductions"] == null
            ? []
            : List<Deduction?>.from(json["deductions"]!
                .map((x) => x == null ? null : Deduction.fromJson(x))),
        personalInfo: json["personalInfo"] == null
            ? null
            : PersonalInfo.fromJson(json["personalInfo"]),
        financialInfo: json["financialInfo"] == null
            ? null
            : FinancialInfo.fromJson(json["financialInfo"]),
        employmentInfo: json["employmentInfo"] == null
            ? null
            : EmploymentInfo.fromJson(json["employmentInfo"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  factory UserProfileModel.fromJson(String json) =>
      UserProfileModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "jobTitle": jobTitle,
        "profilePicture": profilePicture,
        "email": email,
        "directManagerName": directManagerName,
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences.map((x) => x?.toJson())),
        "certificates": certificates == null
            ? []
            : List<dynamic>.from(certificates.map((x) => x?.toJson())),
        "allowances": allowances == null
            ? []
            : List<dynamic>.from(allowances.map((x) => x?.toJson())),
        "noPayBenefits": noPayBenefits == null
            ? []
            : List<dynamic>.from(noPayBenefits.map((x) => x?.toJson())),
        "deductions": deductions == null
            ? []
            : List<dynamic>.from(deductions.map((x) => x?.toJson())),
        "personalInfo": personalInfo?.toJson(),
        "financialInfo": financialInfo?.toJson(),
        "employmentInfo": employmentInfo?.toJson(),
        "status": status?.toJson(),
      };
}

class Allowance {
  final dynamic id;
  final dynamic allowanceId;
  final num? amount;
  final dynamic date;
  final dynamic objectHolderId;
  final dynamic organizationId;
  final dynamic remarks;
  final int? startMonth;
  final int? startYear;
  final String? status;
  final String? allowanceType;
  final dynamic statusDate;
  final DateTime? ealDate;
  final dynamic employeeId;

  Allowance({
    this.id,
    this.allowanceId,
    this.amount,
    this.date,
    this.objectHolderId,
    this.organizationId,
    this.remarks,
    this.startMonth,
    this.startYear,
    this.status,
    this.allowanceType,
    this.statusDate,
    this.ealDate,
    this.employeeId,
  });

  factory Allowance.fromJson(Map<String, dynamic> json) => Allowance(
        id: json["id"],
        allowanceId: json["allowanceId"],
        amount: json["amount"],
        date: json["date"],
        objectHolderId: json["objectHolderId"],
        organizationId: json["organizationId"],
        remarks: json["remarks"],
        startMonth: json["startMonth"],
        startYear: json["startYear"],
        status: json["status"],
        allowanceType: json["allowanceType"],
        statusDate: json["statusDate"],
        ealDate:
            json["ealDate"] == null ? null : DateTime.parse(json["ealDate"]),
        employeeId: json["employeeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "allowanceId": allowanceId,
        "amount": amount,
        "date": date,
        "objectHolderId": objectHolderId,
        "organizationId": organizationId,
        "remarks": remarks,
        "startMonth": startMonth,
        "startYear": startYear,
        "status": status,
        "allowanceType": allowanceType,
        "statusDate": statusDate,
        "ealDate": ealDate?.toYMDFormat,
        // "${ealDate!.year.toString().padLeft(4, '0')}-${ealDate!.month.toString().padLeft(2, '0')}-${ealDate!.day.toString().padLeft(2, '0')}",
        "employeeId": employeeId,
      };
}

class Certificate {
  final int? id;
  final String? type;
  final String? description;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? grade;
  final int? employeeId;

  Certificate({
    this.id,
    this.type,
    this.description,
    this.fromDate,
    this.toDate,
    this.grade,
    this.employeeId,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: json["id"],
        type: json["type"],
        description: json["description"],
        fromDate:
            json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
        toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
        grade: json["grade"],
        employeeId: json["employeeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "description": description,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "grade": grade,
        "employeeId": employeeId,
      };
}

class Deduction {
  final String? deductionType;
  final num? amount;

  Deduction({
    this.deductionType,
    this.amount,
  });

  factory Deduction.fromJson(Map<String, dynamic> json) => Deduction(
        deductionType: json["deductionType"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "deductionType": deductionType,
        "amount": amount,
      };
}

class EmploymentInfo {
  final String? company;
  final String? branch;
  final String? sponsor;
  final String? hierarchy;
  final DateTime? hiringDate;
  final DateTime? joinDate;
  final String? contractType;
  final DateTime? contractStartDate;
  final DateTime? contractEndDate;
  final String? employmentType;
  final String? workClass;
  final String? salaryScalePackage;
  final List<Contract> contracts;
  final dynamic jobHistories;
  final num? annualLeaveBalanceEoy;
  final num? annualLeaveBalanceCurrent;
  final num? annualLeaveBalanceUsed;
  final num? endOfServiceDues;

  EmploymentInfo({
    this.company,
    this.branch,
    this.sponsor,
    this.hierarchy,
    this.hiringDate,
    this.joinDate,
    this.contractType,
    this.contractStartDate,
    this.contractEndDate,
    this.employmentType,
    this.workClass,
    this.salaryScalePackage,
    this.contracts = const [],
    this.jobHistories,
    this.annualLeaveBalanceEoy,
    this.annualLeaveBalanceCurrent,
    this.annualLeaveBalanceUsed,
    this.endOfServiceDues,
  });

  factory EmploymentInfo.fromJson(Map<String, dynamic> json) => EmploymentInfo(
        company: json["company"],
        branch: json["branch"],
        sponsor: json["sponsor"],
        hierarchy: json["hierarchy"],
        hiringDate: json["hiringDate"] == null
            ? null
            : DateTime.parse(json["hiringDate"]),
        joinDate:
            json["joinDate"] == null ? null : DateTime.parse(json["joinDate"]),
        contractType: json["contractType"],
        contractStartDate: json["contractStartDate"] == null
            ? null
            : DateTime.parse(json["contractStartDate"]),
        contractEndDate: json["contractEndDate"] == null
            ? null
            : DateTime.parse(json["contractEndDate"]),
        employmentType: json["employmentType"],
        workClass: json["workClass"],
        salaryScalePackage: json["salaryScalePackage"],
        contracts: json["contracts"] == null
            ? []
            : List<Contract>.from(
                json["contracts"]!.map((x) => Contract.fromJson(x))),
        jobHistories: json["jobHistories"],
        annualLeaveBalanceEoy: json["annualLeaveBalanceEOY"],
        annualLeaveBalanceCurrent: json["annualLeaveBalanceCurrent"],
        annualLeaveBalanceUsed: json["annualLeaveBalanceUsed"],
        endOfServiceDues: json["endOfServiceDues"],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "branch": branch,
        "sponsor": sponsor,
        "hierarchy": hierarchy,
        "hiringDate": hiringDate?.toIso8601String(),
        "joinDate": joinDate?.toIso8601String(),
        "contractType": contractType,
        "contractStartDate": contractStartDate?.toIso8601String(),
        "contractEndDate": contractEndDate?.toYMDFormat,
        // "${contractEndDate!.year.toString().padLeft(4, '0')}-${contractEndDate!.month.toString().padLeft(2, '0')}-${contractEndDate!.day.toString().padLeft(2, '0')}",
        "employmentType": employmentType,
        "workClass": workClass,
        "salaryScalePackage": salaryScalePackage,
        "contracts": contracts == null
            ? []
            : List<dynamic>.from(contracts.map((x) => x.toJson())),
        "jobHistories": jobHistories,
        "annualLeaveBalanceEOY": annualLeaveBalanceEoy,
        "annualLeaveBalanceCurrent": annualLeaveBalanceCurrent,
        "annualLeaveBalanceUsed": annualLeaveBalanceUsed,
        "endOfServiceDues": endOfServiceDues,
      };
}

class Contract {
  final int? contractId;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? status;
  final String? contractType;

  Contract({
    this.contractId,
    this.fromDate,
    this.toDate,
    this.status,
    this.contractType,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        contractId: json["contractId"],
        fromDate:
            json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
        toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
        status: json["status"],
        contractType: json["contractType"],
      );

  Map<String, dynamic> toJson() => {
        "contractId": contractId,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toYMDFormat,
        // "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "contractType": contractType,
      };
}

class Experience {
  final int? id;
  final dynamic employeeId;
  final String? companyName;
  final String? country;
  final String? city;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? position;
  final num? lastSalary;
  final String? contactPerson;
  final dynamic contactPhone;
  final dynamic relevance;
  final dynamic jobPlace;
  final dynamic quitReason;
  final dynamic jobDescription;
  final dynamic natureOfWork;
  final dynamic remarks;

  Experience({
    this.id,
    this.employeeId,
    this.companyName,
    this.country,
    this.city,
    this.startDate,
    this.endDate,
    this.position,
    this.lastSalary,
    this.contactPerson,
    this.contactPhone,
    this.relevance,
    this.jobPlace,
    this.quitReason,
    this.jobDescription,
    this.natureOfWork,
    this.remarks,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"],
        employeeId: json["employeeId"],
        companyName: json["companyName"],
        country: json["country"],
        city: json["city"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        position: json["position"],
        lastSalary: json["lastSalary"],
        contactPerson: json["contactPerson"],
        contactPhone: json["contactPhone"],
        relevance: json["relevance"],
        jobPlace: json["jobPlace"],
        quitReason: json["quitReason"],
        jobDescription: json["jobDescription"],
        natureOfWork: json["natureOfWork"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeId": employeeId,
        "companyName": companyName,
        "country": country,
        "city": city,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "position": position,
        "lastSalary": lastSalary,
        "contactPerson": contactPerson,
        "contactPhone": contactPhone,
        "relevance": relevance,
        "jobPlace": jobPlace,
        "quitReason": quitReason,
        "jobDescription": jobDescription,
        "natureOfWork": natureOfWork,
        "remarks": remarks,
      };
}

class FinancialInfo {
  final num? basicSalary;
  final num? grossSalary;
  final num? yearlySalaries;
  final String? paymentMethod;
  final String? endOfServiceIncluded;
  final String? gosi;
  final String? insuranceLevel;
  final String? bankName;
  final String? iban;

  FinancialInfo({
    this.basicSalary,
    this.grossSalary,
    this.yearlySalaries,
    this.paymentMethod,
    this.endOfServiceIncluded,
    this.gosi,
    this.insuranceLevel,
    this.bankName,
    this.iban,
  });

  factory FinancialInfo.fromJson(Map<String, dynamic> json) => FinancialInfo(
        basicSalary: json["basicSalary"],
        grossSalary: json["grossSalary"],
        yearlySalaries: json["yearlySalaries"],
        paymentMethod: json["paymentMethod"],
        endOfServiceIncluded: json["endOfServiceIncluded"],
        gosi: json["gosi"],
        insuranceLevel: json["insuranceLevel"],
        bankName: json["bankName"],
        iban: json["iban"],
      );

  Map<String, dynamic> toJson() => {
        "basicSalary": basicSalary,
        "grossSalary": grossSalary,
        "yearlySalaries": yearlySalaries,
        "paymentMethod": paymentMethod,
        "endOfServiceIncluded": endOfServiceIncluded,
        "gosi": gosi,
        "insuranceLevel": insuranceLevel,
        "bankName": bankName,
        "iban": iban,
      };
}

class NoPayBenefit {
  final dynamic id;
  final num? amount;
  final String? description;
  final DateTime? fromDate;
  final DateTime? toDate;
  final dynamic employeeId;

  NoPayBenefit({
    this.id,
    this.amount,
    this.description,
    this.fromDate,
    this.toDate,
    this.employeeId,
  });

  factory NoPayBenefit.fromJson(Map<String, dynamic> json) => NoPayBenefit(
        id: json["id"],
        amount: json["amount"],
        description: json["description"],
        fromDate:
            json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
        toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
        employeeId: json["employeeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "description": description,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "employeeId": employeeId,
      };
}

class PersonalInfo {
  final String? fullName;
  final String? nationality;
  final String? nationalNum;
  final String? gender;
  final DateTime? birthDate;
  final String? religion;
  final String? maritalStatus;
  final String? homeCountry;
  final String? homeCity;
  final String? email;
  final String? mobile;
  final String? address;
  final List<Dependent> dependents;

  PersonalInfo({
    this.fullName,
    this.nationality,
    this.nationalNum,
    this.gender,
    this.birthDate,
    this.religion,
    this.maritalStatus,
    this.homeCountry,
    this.homeCity,
    this.email,
    this.mobile,
    this.address,
    this.dependents = const [],
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
        fullName: json["fullName"],
        nationality: json["nationality"],
        nationalNum: json["nationalNum"],
        gender: json["gender"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        religion: json["religion"],
        maritalStatus: json["maritalStatus"],
        homeCountry: json["homeCountry"],
        homeCity: json["homeCity"],
        email: json["email"],
        mobile: json["mobile"],
        address: json["address"],
        dependents: json["dependents"] == null
            ? []
            : List<Dependent>.from(
                json["dependents"]!.map((x) => Dependent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "nationality": nationality,
        "nationalNum": nationalNum,
        "gender": gender,
        "birthDate": birthDate?.toIso8601String(),
        "religion": religion,
        "maritalStatus": maritalStatus,
        "homeCountry": homeCountry,
        "homeCity": homeCity,
        "email": email,
        "mobile": mobile,
        "address": address,
        "dependents": dependents == null
            ? []
            : List<dynamic>.from(dependents.map((x) => x.toJson())),
      };
}

class Dependent {
  final String? name;
  final String? relation;

  Dependent({
    this.name,
    this.relation,
  });

  factory Dependent.fromJson(Map<String, dynamic> json) => Dependent(
        name: json["name"],
        relation: json["relation"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "relation": relation,
      };
}

class Status {
  final int? code;
  final String? message;

  Status({
    this.code,
    this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

// ignore_for_file: unnecessary_null_comparison

// import 'dart:convert';
//
// class UserProfileModel {
//   final int? empId;
//   final int? empOrgId;
//   final String? name1A;
//   final String? name2A;
//   final dynamic name3A;
//   final String? name4A;
//   final String? name1L;
//   final String? name2L;
//   final dynamic name3L;
//   final String? name4L;
//   final int? status;
//   final DateTime? statusDate;
//   final dynamic nationalId;
//   final DateTime? dob;
//   final dynamic placeOfBirth;
//   final dynamic motherName;
//   final String? mobile;
//   final String? personalEmail;
//   final dynamic formalEmail;
//   final dynamic address;
//   final dynamic disability;
//   final dynamic chronicDisease;
//   final dynamic weight;
//   final dynamic height;
//   final String? emergencyContact;
//   final String? emergencyPhone;
//   final int? isStudent;
//   final DateTime? hiringDate;
//   final int? isInProbation;
//   final int? probationMonths;
//   final int? type;
//   final int? vacationStartBalance;
//   final int? basicSalary;
//   final int? isInSocialSecurity;
//   final int? socialSecuritySalary;
//   final DateTime? socialSecurityStartDate;
//   final dynamic socialSecurityId;
//   final int? payMethod;
//   final dynamic bankAccountNumber;
//   final dynamic iban;
//   final String? nationality;
//   final String? maritalStatus;
//   final String? religion;
//   final String? gender;
//   final String? position;
//   final dynamic bank;
//   final List<Experience> experiences;
//   final List<Certificate> certificates;
//   final List<Allowance> allowances;
//   final List<NoPayBenefit> noPayBenefits;
//   final String? profilePicture;
//   final DirectManager? directManager;
//
//   UserProfileModel({
//     this.empId,
//     this.empOrgId,
//     this.name1A,
//     this.name2A,
//     this.name3A,
//     this.name4A,
//     this.name1L,
//     this.name2L,
//     this.name3L,
//     this.name4L,
//     this.status,
//     this.statusDate,
//     this.nationalId,
//     this.dob,
//     this.placeOfBirth,
//     this.motherName,
//     this.mobile,
//     this.personalEmail,
//     this.formalEmail,
//     this.address,
//     this.disability,
//     this.chronicDisease,
//     this.weight,
//     this.height,
//     this.emergencyContact,
//     this.emergencyPhone,
//     this.isStudent,
//     this.hiringDate,
//     this.isInProbation,
//     this.probationMonths,
//     this.type,
//     this.vacationStartBalance,
//     this.basicSalary,
//     this.isInSocialSecurity,
//     this.socialSecuritySalary,
//     this.socialSecurityStartDate,
//     this.socialSecurityId,
//     this.payMethod,
//     this.bankAccountNumber,
//     this.iban,
//     this.nationality,
//     this.maritalStatus,
//     this.religion,
//     this.gender,
//     this.position,
//     this.bank,
//     this.experiences = const [],
//     this.certificates = const [],
//     this.allowances = const [],
//     this.noPayBenefits = const [],
//     this.profilePicture,
//     this.directManager,
//   });
//
//   UserProfileModel copyWith({
//     int? empId,
//     int? empOrgId,
//     String? name1A,
//     String? name2A,
//     dynamic name3A,
//     String? name4A,
//     String? name1L,
//     String? name2L,
//     dynamic name3L,
//     String? name4L,
//     int? status,
//     DateTime? statusDate,
//     dynamic nationalId,
//     DateTime? dob,
//     dynamic placeOfBirth,
//     dynamic motherName,
//     String? mobile,
//     String? personalEmail,
//     dynamic formalEmail,
//     dynamic address,
//     dynamic disability,
//     dynamic chronicDisease,
//     dynamic weight,
//     dynamic height,
//     String? emergencyContact,
//     String? emergencyPhone,
//     int? isStudent,
//     DateTime? hiringDate,
//     int? isInProbation,
//     int? probationMonths,
//     int? type,
//     int? vacationStartBalance,
//     int? basicSalary,
//     int? isInSocialSecurity,
//     int? socialSecuritySalary,
//     DateTime? socialSecurityStartDate,
//     dynamic socialSecurityId,
//     int? payMethod,
//     dynamic bankAccountNumber,
//     dynamic iban,
//     String? nationality,
//     String? maritalStatus,
//     String? religion,
//     String? gender,
//     String? position,
//     dynamic bank,
//     List<Experience>? experiences,
//     List<Certificate>? certificates,
//     List<Allowance>? allowances,
//     List<NoPayBenefit>? noPayBenefits,
//     String? profilePicture,
//     DirectManager? directManager,
//   }) =>
//       UserProfileModel(
//         empId: empId ?? this.empId,
//         empOrgId: empOrgId ?? this.empOrgId,
//         name1A: name1A ?? this.name1A,
//         name2A: name2A ?? this.name2A,
//         name3A: name3A ?? this.name3A,
//         name4A: name4A ?? this.name4A,
//         name1L: name1L ?? this.name1L,
//         name2L: name2L ?? this.name2L,
//         name3L: name3L ?? this.name3L,
//         name4L: name4L ?? this.name4L,
//         status: status ?? this.status,
//         statusDate: statusDate ?? this.statusDate,
//         nationalId: nationalId ?? this.nationalId,
//         dob: dob ?? this.dob,
//         placeOfBirth: placeOfBirth ?? this.placeOfBirth,
//         motherName: motherName ?? this.motherName,
//         mobile: mobile ?? this.mobile,
//         personalEmail: personalEmail ?? this.personalEmail,
//         formalEmail: formalEmail ?? this.formalEmail,
//         address: address ?? this.address,
//         disability: disability ?? this.disability,
//         chronicDisease: chronicDisease ?? this.chronicDisease,
//         weight: weight ?? this.weight,
//         height: height ?? this.height,
//         emergencyContact: emergencyContact ?? this.emergencyContact,
//         emergencyPhone: emergencyPhone ?? this.emergencyPhone,
//         isStudent: isStudent ?? this.isStudent,
//         hiringDate: hiringDate ?? this.hiringDate,
//         isInProbation: isInProbation ?? this.isInProbation,
//         probationMonths: probationMonths ?? this.probationMonths,
//         type: type ?? this.type,
//         vacationStartBalance: vacationStartBalance ?? this.vacationStartBalance,
//         basicSalary: basicSalary ?? this.basicSalary,
//         isInSocialSecurity: isInSocialSecurity ?? this.isInSocialSecurity,
//         socialSecuritySalary: socialSecuritySalary ?? this.socialSecuritySalary,
//         socialSecurityStartDate:
//             socialSecurityStartDate ?? this.socialSecurityStartDate,
//         socialSecurityId: socialSecurityId ?? this.socialSecurityId,
//         payMethod: payMethod ?? this.payMethod,
//         bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
//         iban: iban ?? this.iban,
//         nationality: nationality ?? this.nationality,
//         maritalStatus: maritalStatus ?? this.maritalStatus,
//         religion: religion ?? this.religion,
//         gender: gender ?? this.gender,
//         position: position ?? this.position,
//         bank: bank ?? this.bank,
//         experiences: experiences ?? this.experiences,
//         certificates: certificates ?? this.certificates,
//         allowances: allowances ?? this.allowances,
//         noPayBenefits: noPayBenefits ?? this.noPayBenefits,
//         profilePicture: profilePicture ?? this.profilePicture,
//         directManager: directManager ?? this.directManager,
//       );
//
//   factory UserProfileModel.fromMap(Map<String, dynamic> json) =>
//       UserProfileModel(
//         empId: json["empId"],
//         empOrgId: json["empOrgId"],
//         name1A: json["name1A"],
//         name2A: json["name2A"],
//         name3A: json["name3A"],
//         name4A: json["name4A"],
//         name1L: json["name1L"],
//         name2L: json["name2L"],
//         name3L: json["name3L"],
//         name4L: json["name4L"],
//         status: json["status"],
//         statusDate: json["statusDate"] == null
//             ? null
//             : DateTime.parse(json["statusDate"]),
//         nationalId: json["nationalId"],
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         placeOfBirth: json["placeOfBirth"],
//         motherName: json["motherName"],
//         mobile: json["mobile"],
//         personalEmail: json["personalEmail"],
//         formalEmail: json["formalEmail"],
//         address: json["address"],
//         disability: json["disability"],
//         chronicDisease: json["chronicDisease"],
//         weight: json["weight"],
//         height: json["height"],
//         emergencyContact: json["emergencyContact"],
//         emergencyPhone: json["emergencyPhone"],
//         isStudent: json["isStudent"],
//         hiringDate: json["hiringDate"] == null
//             ? null
//             : DateTime.parse(json["hiringDate"]),
//         isInProbation: json["isInProbation"],
//         probationMonths: json["probationMonths"],
//         type: json["type"],
//         vacationStartBalance: json["vacationStartBalance"],
//         basicSalary: json["basicSalary"],
//         isInSocialSecurity: json["isInSocialSecurity"],
//         socialSecuritySalary: json["socialSecuritySalary"],
//         socialSecurityStartDate: json["socialSecurityStartDate"] == null
//             ? null
//             : DateTime.parse(json["socialSecurityStartDate"]),
//         socialSecurityId: json["socialSecurityId"],
//         payMethod: json["payMethod"],
//         bankAccountNumber: json["bankAccountNumber"],
//         iban: json["iban"],
//         nationality: json["nationality"],
//         maritalStatus: json["maritalStatus"],
//         religion: json["religion"],
//         gender: json["gender"],
//         position: json["position"],
//         bank: json["bank"],
//         experiences: json["experiences"] == null
//             ? []
//             : List<Experience>.from(
//                 json["experiences"]!.map((x) => Experience.fromJson(x))),
//         certificates: json["certificates"] == null
//             ? []
//             : List<Certificate>.from(
//                 json["certificates"]!.map((x) => Certificate.fromJson(x))),
//         allowances: json["allowances"] == null
//             ? []
//             : List<Allowance>.from(
//                 json["allowances"]!.map((x) => Allowance.fromJson(x))),
//         noPayBenefits: json["noPayBenefits"] == null
//             ? []
//             : List<NoPayBenefit>.from(
//                 json["noPayBenefits"]!.map((x) => NoPayBenefit.fromJson(x))),
//         profilePicture: json["profilePicture"],
//         directManager: json["directManager"] == null
//             ? null
//             : DirectManager.fromJson(json["directManager"]),
//       );
//
//   factory UserProfileModel.fromJson(String json) =>
//       UserProfileModel.fromMap(jsonDecode(json));
//
//   Map<String, dynamic> toJson() => {
//         "empId": empId,
//         "empOrgId": empOrgId,
//         "name1A": name1A,
//         "name2A": name2A,
//         "name3A": name3A,
//         "name4A": name4A,
//         "name1L": name1L,
//         "name2L": name2L,
//         "name3L": name3L,
//         "name4L": name4L,
//         "status": status,
//         "statusDate": statusDate?.toIso8601String(),
//         "nationalId": nationalId,
//         "dob": dob?.toIso8601String(),
//         "placeOfBirth": placeOfBirth,
//         "motherName": motherName,
//         "mobile": mobile,
//         "personalEmail": personalEmail,
//         "formalEmail": formalEmail,
//         "address": address,
//         "disability": disability,
//         "chronicDisease": chronicDisease,
//         "weight": weight,
//         "height": height,
//         "emergencyContact": emergencyContact,
//         "emergencyPhone": emergencyPhone,
//         "isStudent": isStudent,
//         "hiringDate": hiringDate?.toIso8601String(),
//         "isInProbation": isInProbation,
//         "probationMonths": probationMonths,
//         "type": type,
//         "vacationStartBalance": vacationStartBalance,
//         "basicSalary": basicSalary,
//         "isInSocialSecurity": isInSocialSecurity,
//         "socialSecuritySalary": socialSecuritySalary,
//         "socialSecurityStartDate": socialSecurityStartDate?.toIso8601String(),
//         "socialSecurityId": socialSecurityId,
//         "payMethod": payMethod,
//         "bankAccountNumber": bankAccountNumber,
//         "iban": iban,
//         "nationality": nationality,
//         "maritalStatus": maritalStatus,
//         "religion": religion,
//         "gender": gender,
//         "position": position,
//         "bank": bank,
//         "experiences": experiences == null
//             ? []
//             : List<Experience>.from(experiences.map((x) => x)),
//         "certificates": certificates == null
//             ? []
//             : List<Certificate>.from(certificates.map((x) => x)),
//         "allowances": allowances == null
//             ? []
//             : List<Allowance>.from(allowances.map((x) => x)),
//         "noPayBenefits": noPayBenefits == null
//             ? []
//             : List<NoPayBenefit>.from(noPayBenefits.map((x) => x.toJson())),
//         "profilePicture": profilePicture,
//         "directManager": directManager?.toJson(),
//       };
// }
//
// class NoPayBenefit {
//   dynamic id;
//   int? amount;
//   String? description;
//   DateTime? fromDate;
//   DateTime? toDate;
//   dynamic employeeId;
//
//   NoPayBenefit({
//     this.id,
//     this.amount,
//     this.description,
//     this.fromDate,
//     this.toDate,
//     this.employeeId,
//   });
//
//   NoPayBenefit copyWith({
//     dynamic id,
//     int? amount,
//     String? description,
//     DateTime? fromDate,
//     DateTime? toDate,
//     dynamic employeeId,
//   }) =>
//       NoPayBenefit(
//         id: id ?? this.id,
//         amount: amount ?? this.amount,
//         description: description ?? this.description,
//         fromDate: fromDate ?? this.fromDate,
//         toDate: toDate ?? this.toDate,
//         employeeId: employeeId ?? this.employeeId,
//       );
//
//   factory NoPayBenefit.fromJson(Map<String, dynamic> json) => NoPayBenefit(
//         id: json["id"],
//         amount: json["amount"],
//         description: json["description"],
//         fromDate:
//             json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
//         toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
//         employeeId: json["employeeId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "amount": amount,
//         "description": description,
//         "fromDate": fromDate?.toIso8601String(),
//         "toDate": toDate?.toIso8601String(),
//         "employeeId": employeeId,
//       };
// }
//
// class Allowance {
//   final dynamic id;
//   final dynamic allowanceId;
//   final int? amount;
//   final dynamic date;
//   final dynamic objectHolderId;
//   final dynamic organizationId;
//   final dynamic remarks;
//   final int? startMonth;
//   final int? startYear;
//   final String? status;
//   final String? allowanceType;
//   final dynamic statusDate;
//   final DateTime? ealDate;
//   final dynamic employeeId;
//
//   Allowance({
//     this.id,
//     this.allowanceId,
//     this.amount,
//     this.date,
//     this.objectHolderId,
//     this.organizationId,
//     this.remarks,
//     this.startMonth,
//     this.startYear,
//     this.status,
//     this.allowanceType,
//     this.statusDate,
//     this.ealDate,
//     this.employeeId,
//   });
//
//   Allowance copyWith({
//     dynamic id,
//     dynamic allowanceId,
//     int? amount,
//     dynamic date,
//     dynamic objectHolderId,
//     dynamic organizationId,
//     dynamic remarks,
//     int? startMonth,
//     int? startYear,
//     String? status,
//     String? allowanceType,
//     dynamic statusDate,
//     DateTime? ealDate,
//     dynamic employeeId,
//   }) =>
//       Allowance(
//         id: id ?? this.id,
//         allowanceId: allowanceId ?? this.allowanceId,
//         amount: amount ?? this.amount,
//         date: date ?? this.date,
//         objectHolderId: objectHolderId ?? this.objectHolderId,
//         organizationId: organizationId ?? this.organizationId,
//         remarks: remarks ?? this.remarks,
//         startMonth: startMonth ?? this.startMonth,
//         startYear: startYear ?? this.startYear,
//         status: status ?? this.status,
//         allowanceType: allowanceType ?? this.allowanceType,
//         statusDate: statusDate ?? this.statusDate,
//         ealDate: ealDate ?? this.ealDate,
//         employeeId: employeeId ?? this.employeeId,
//       );
//
//   factory Allowance.fromJson(Map<String, dynamic> json) => Allowance(
//         id: json["id"],
//         allowanceId: json["allowanceId"],
//         amount: json["amount"],
//         date: json["date"],
//         objectHolderId: json["objectHolderId"],
//         organizationId: json["organizationId"],
//         remarks: json["remarks"],
//         startMonth: json["startMonth"],
//         startYear: json["startYear"],
//         status: json["status"],
//         allowanceType: json["allowanceType"],
//         statusDate: json["statusDate"],
//         ealDate:
//             json["ealDate"] == null ? null : DateTime.parse(json["ealDate"]),
//         employeeId: json["employeeId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "allowanceId": allowanceId,
//         "amount": amount,
//         "date": date,
//         "objectHolderId": objectHolderId,
//         "organizationId": organizationId,
//         "remarks": remarks,
//         "startMonth": startMonth,
//         "startYear": startYear,
//         "status": status,
//         "allowanceType": allowanceType,
//         "statusDate": statusDate,
//         "ealDate":
//             "${ealDate!.year.toString().padLeft(4, '0')}-${ealDate!.month.toString().padLeft(2, '0')}-${ealDate!.day.toString().padLeft(2, '0')}",
//         "employeeId": employeeId,
//       };
// }
//
// class Certificate {
//   final int? id;
//   final String? type;
//   final String? description;
//   final DateTime? fromDate;
//   final DateTime? toDate;
//   final String? grade;
//   final int? employeeId;
//
//   Certificate({
//     this.id,
//     this.type,
//     this.description,
//     this.fromDate,
//     this.toDate,
//     this.grade,
//     this.employeeId,
//   });
//
//   Certificate copyWith({
//     int? id,
//     String? type,
//     String? description,
//     DateTime? fromDate,
//     DateTime? toDate,
//     String? grade,
//     int? employeeId,
//   }) =>
//       Certificate(
//         id: id ?? this.id,
//         type: type ?? this.type,
//         description: description ?? this.description,
//         fromDate: fromDate ?? this.fromDate,
//         toDate: toDate ?? this.toDate,
//         grade: grade ?? this.grade,
//         employeeId: employeeId ?? this.employeeId,
//       );
//
//   factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
//         id: json["id"],
//         type: json["type"],
//         description: json["description"],
//         fromDate:
//             json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
//         toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
//         grade: json["grade"],
//         employeeId: json["employeeId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "type": type,
//         "description": description,
//         "fromDate": fromDate?.toIso8601String(),
//         "toDate": toDate?.toIso8601String(),
//         "grade": grade,
//         "employeeId": employeeId,
//       };
// }
//
// class Experience {
//   final int? id;
//   final dynamic employeeId;
//   final String? companyName;
//   final String? country;
//   final String? city;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String? position;
//   final num? lastSalary;
//   final String? contactPerson;
//   final String? contactPhone;
//   final String? relevance;
//   final String? jobPlace;
//   final String? quitReason;
//   final String? jobDescription;
//   final String? natureOfWork;
//   final String? remarks;
//
//   Experience({
//     this.id,
//     this.employeeId,
//     this.companyName,
//     this.country,
//     this.city,
//     this.startDate,
//     this.endDate,
//     this.position,
//     this.lastSalary,
//     this.contactPerson,
//     this.contactPhone,
//     this.relevance,
//     this.jobPlace,
//     this.quitReason,
//     this.jobDescription,
//     this.natureOfWork,
//     this.remarks,
//   });
//
//   Experience copyWith({
//     int? id,
//     dynamic employeeId,
//     String? companyName,
//     String? country,
//     String? city,
//     DateTime? startDate,
//     DateTime? endDate,
//     String? position,
//     int? lastSalary,
//     String? contactPerson,
//     dynamic contactPhone,
//     dynamic relevance,
//     dynamic jobPlace,
//     dynamic quitReason,
//     dynamic jobDescription,
//     dynamic natureOfWork,
//     dynamic remarks,
//   }) =>
//       Experience(
//         id: id ?? this.id,
//         employeeId: employeeId ?? this.employeeId,
//         companyName: companyName ?? this.companyName,
//         country: country ?? this.country,
//         city: city ?? this.city,
//         startDate: startDate ?? this.startDate,
//         endDate: endDate ?? this.endDate,
//         position: position ?? this.position,
//         lastSalary: lastSalary ?? this.lastSalary,
//         contactPerson: contactPerson ?? this.contactPerson,
//         contactPhone: contactPhone ?? this.contactPhone,
//         relevance: relevance ?? this.relevance,
//         jobPlace: jobPlace ?? this.jobPlace,
//         quitReason: quitReason ?? this.quitReason,
//         jobDescription: jobDescription ?? this.jobDescription,
//         natureOfWork: natureOfWork ?? this.natureOfWork,
//         remarks: remarks ?? this.remarks,
//       );
//
//   factory Experience.fromJson(Map<String, dynamic> json) => Experience(
//         id: json["id"],
//         employeeId: json["employeeId"],
//         companyName: json["companyName"],
//         country: json["country"],
//         city: json["city"],
//         startDate: json["startDate"] == null
//             ? null
//             : DateTime.parse(json["startDate"]),
//         endDate:
//             json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
//         position: json["position"],
//         lastSalary: json["lastSalary"],
//         contactPerson: json["contactPerson"],
//         contactPhone: json["contactPhone"],
//         relevance: json["relevance"],
//         jobPlace: json["jobPlace"],
//         quitReason: json["quitReason"],
//         jobDescription: json["jobDescription"],
//         natureOfWork: json["natureOfWork"],
//         remarks: json["remarks"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "employeeId": employeeId,
//         "companyName": companyName,
//         "country": country,
//         "city": city,
//         "startDate": startDate?.toIso8601String(),
//         "endDate": endDate?.toIso8601String(),
//         "position": position,
//         "lastSalary": lastSalary,
//         "contactPerson": contactPerson,
//         "contactPhone": contactPhone,
//         "relevance": relevance,
//         "jobPlace": jobPlace,
//         "quitReason": quitReason,
//         "jobDescription": jobDescription,
//         "natureOfWork": natureOfWork,
//         "remarks": remarks,
//       };
// }

// class DirectManager {
//   final int? managerId;
//   final String? managerNameAr;
//   final String? managerNameEn;
//
//   DirectManager({
//     this.managerId,
//     this.managerNameAr,
//     this.managerNameEn,
//   });
//
//   DirectManager copyWith({
//     int? managerId,
//     String? managerNameAr,
//     String? managerNameEn,
//   }) =>
//       DirectManager(
//         managerId: managerId ?? this.managerId,
//         managerNameAr: managerNameAr ?? this.managerNameAr,
//         managerNameEn: managerNameEn ?? this.managerNameEn,
//       );
//
//   factory DirectManager.fromJson(Map<String, dynamic> json) => DirectManager(
//         managerId: json["managerId"],
//         managerNameAr: json["managerNameAr"],
//         managerNameEn: json["managerNameEn"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "managerId": managerId,
//         "managerNameAr": managerNameAr,
//         "managerNameEn": managerNameEn,
//       };
// }
