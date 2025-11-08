import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/core/shared/models/request_status.dart';

// 10ﾠالاجازات

// 40ﾠتغيير الورديات

// 50ﾠطلبات ختم الحضور المفقودة

// 60ﾠالعمل الاضافي

// 70ﾠالمغادرات

// 80ﾠتعويض الاجازات

// 90ﾠالسلف

// 110ﾠالمطالبات المالية

// 120ﾠالعهد

// 130ﾠإرجاع العهد

// 140ﾠالطلبات العامة

// 150ﾠالتقييم

// 160ﾠإجراءات التأديب و العقوبات

// 170ﾠرحلات العمل

// 180ﾠإنهاء التعاقد

enum RequestType {
  vacation,
  leave,
  loan,
  claim,
  letter,
  overtime,
  missingPunchRequest,
  shiftChangeRequest,
  vacationCompensation,
  companyAssets,
  returnCompanyAssets,
  evaluation,
  disciplinaryActions,
  businessTrips,
  contractTermination,
}

extension RequestTypeExtension on RequestType {
  num get id {
    switch (this) {
      case RequestType.vacation:
        return 10;
      case RequestType.shiftChangeRequest:
        return 40;
      case RequestType.missingPunchRequest:
        return 50;
      case RequestType.overtime:
        return 60;
      case RequestType.leave:
        return 70;
      case RequestType.vacationCompensation:
        return 80;
      case RequestType.loan:
        return 90;
      case RequestType.claim:
        return 110;
      case RequestType.companyAssets:
        return 120;
      case RequestType.returnCompanyAssets:
        return 130;
      case RequestType.letter:
        return 140;
      case RequestType.evaluation:
        return 150;
      case RequestType.disciplinaryActions:
        return 160;
      case RequestType.businessTrips:
        return 170;
      case RequestType.contractTermination:
        return 180;
    }
  }

  static RequestType? fromId(num? id) {
    switch (id) {
      case 10:
        return RequestType.vacation;
      case 40:
        return RequestType.shiftChangeRequest;
      case 50:
        return RequestType.missingPunchRequest;
      case 60:
        return RequestType.overtime;
      case 70:
        return RequestType.leave;
      case 80:
        return RequestType.vacationCompensation;
      case 90:
        return RequestType.loan;
      case 110:
        return RequestType.claim;
      case 120:
        return RequestType.companyAssets;
      case 130:
        return RequestType.returnCompanyAssets;
      case 140:
        return RequestType.letter;
      case 150:
        return RequestType.evaluation;
      case 160:
        return RequestType.disciplinaryActions;
      case 170:
        return RequestType.businessTrips;
      case 180:
        return RequestType.contractTermination;

      default:
        return null;
    }
  }
}

class ActionsData {
  List<ActionData>? data;
  SuccessResponse? success;

  ActionsData({
    this.data,
    this.success,
  });

  factory ActionsData.fromMap(Map<String, dynamic> map) {
    return ActionsData(
      data: map['myRequestsResponse'] != null
          ? List<ActionData>.from(
              map['myRequestsResponse'].map((x) => ActionData.fromMap(x)))
          : null,
      success: map['status'] != null ? SuccessResponse.fromMap(map) : null,
    );
  }

  factory ActionsData.fromJson(String json) =>
      ActionsData.fromMap(jsonDecode(json));
}

/// Vacation:10 , Leave:70, Letter:140, Claim:110,
class ActionData {
  //! Common
  final String? requestTable;
  final String? employeeNameAr;
  final String? employeeNameEn;
  final String? employeePic;
  final String? requestDesc;
  final num? employeeId;
  final num? orgId;
  final String? employeeTitle;
  final String? employeeTitleA;
  final String? employeeTitleE;
  final String? organizationName;
  final String? approver;
  final String? approverNameEn;
  final String? approverNameAr;
  final DateTime? creationDate;
  final List<AttachmentList>? attachmentList;
  final List<HistoryDTOs>? historyDTOs;
  final num? requestedByEmployeeId;
  final String? requestedByEmployeeName;
  final String? status;
  final RequestStatus? statusCode;
  final DateTime? statusDate;
  final String? statusRemarks;
  final num? flowId;
  final RequestType? requestType;
  final num? requestId;
  //! Leave
  final num? shortLeaveId;
  final String? shortLeaveType;
  final DateTime? leaveDate;
  final DateTime? fromTime;
  final DateTime? toTime;
  final String? requestRemarks;
  //! Vacation
  final num? vacationId;
  final String? vacationTypeName;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? time;
  final String? reason;
  //! Claim
  final num? id; // Claim, overtime
  final String? claimType;
  final DateTime? date; // Claim, overtime
  final num? amount; // Claim, overtime
  //! Letter
  final String? letterType;
  final DateTime? letterDate;
  final String? details;
  //! Loan
  final num? transactionId;
  final String? loanType;
  final DateTime? loanDate;
  final num? numberOfInstallments;
  //! Overtime
  final String? type;
  final num? hours;
  //! Disciplinary Actions
  num? dpaOrgId;
  num? dpaId;
  DateTime? dpaDate;
  num? dpaEmpId;
  String? empNameA;
  String? empNameL;
  num? empId;
  DateTime? dpaViolationDate;
  num? dpaVapId;
  String? vapNameA;
  String? vapNameL;
  num? vapSNo;
  num? vapId;
  String? dpaDetailsA;
  String? dpaDetailsL;
  num? dpaSuggRepetitionNo;
  num? dpaDecidedRepetitionNo;
  num? dpaSuggPnlId;
  num? pnlNo;
  String? pnlTextA;
  String? pnlTextL;
  num? pnlId;
  num? dpaDecidedPnlId;
  num? pnlNo1;
  String? pnlTextA1;
  String? pnlTextL1;
  num? pnlId1;
  num? dpaDaysToDeduct;
  num? dpaDedMonth;
  num? dpaDedYear;
  num? dpaStatus;
  DateTime? dpaStatusDate;
  num? dpaIsEmpDecided;
  num? dpaEmpDecisionType;
  num? dpaCreatedByUsrId;
  //---------------------
  final String? reqActionType; // Evaluate employee: employee : 2, manager: 3
  final String? isWorkflowCompleted;
  final String? decisionType;
  final String? duration;
  final int? punchType;
  // Acknowledgement
  final String? ntfSubjectL;
  final String? ntfSubjectA;
  final String? ntfMsgA;
  final String? ntfMsgL;
  final bool isAck;

  // Evaluate employee: employee : 2, manager: 3
  final num? evaluationId;
  final num? starRating;
  final num? scorePercentage;
  final String? grade;
  final DateTime? evaluationStartDate;
  final DateTime? evaluationEndDate;
  final String? remarks;
  final List<EvaluationCriteriaAction>? criteria;
  final bool isManager; // 3: Employee, 2: Manager
  final DateTime? terminationDate;

  // Cancel request
  final bool canCancelRequest;
  final num? cancelId;

  /// Business Trip
  final String? isWithdraw;
  final dynamic wftId;

  final String? tripType;
  final String? fromPlace;
  final String? toPlace;
  final DateTime? actualFromDate;
  final DateTime? actualToDate;
  final dynamic actualDuration;
  final String? via;
  final bool? requestAdvance;
  final int? perDiemsAmount;
  final int? accommodationAmount;
  final int? transportationAmount;
  final dynamic totalAmount;

  // Termination
  final DateTime? requestedLastWorkingDate;
  final DateTime? lastWorkingDateHr;
  final DateTime? hiringDate;
  final String? contractType;
  final String? endOfServiceReason;
  final dynamic hrDecisionDetails;
  final dynamic hrCancellationDetails;
  final int? years;
  final int? days;
  final int? months;

  bool get showActions =>
      reqActionType == "2" && decisionType == "0" ? true : false;

  ActionData({
    this.requestTable,
    this.employeeNameAr,
    this.employeeNameEn,
    this.employeePic,
    this.requestDesc,
    this.employeeId,
    this.orgId,
    this.employeeTitle,
    this.employeeTitleA,
    this.employeeTitleE,
    this.organizationName,
    this.approver,
    this.approverNameAr,
    this.approverNameEn,
    this.creationDate,
    this.attachmentList,
    this.shortLeaveId,
    this.shortLeaveType,
    this.leaveDate,
    this.fromTime,
    this.toTime,
    this.time,
    this.requestRemarks,
    this.historyDTOs,
    this.requestedByEmployeeId,
    this.requestedByEmployeeName,
    this.status,
    this.statusCode,
    this.statusDate,
    this.statusRemarks,
    this.flowId,
    this.requestType,
    this.requestId,
    this.vacationId,
    this.vacationTypeName,
    this.fromDate,
    this.toDate,
    this.reason,
    this.id,
    this.claimType,
    this.details,
    this.transactionId,
    this.loanType,
    this.loanDate,
    this.numberOfInstallments,
    this.type,
    this.hours,
    this.date,
    this.amount,
    this.letterType,
    this.letterDate,
    this.isWorkflowCompleted,
    this.decisionType,
    this.reqActionType,
    this.duration,
    this.punchType,
    this.dpaOrgId,
    this.dpaId,
    this.dpaDate,
    this.dpaEmpId,
    this.empNameA,
    this.empNameL,
    this.empId,
    this.dpaViolationDate,
    this.dpaVapId,
    this.vapNameA,
    this.vapNameL,
    this.vapSNo,
    this.vapId,
    this.dpaDetailsA,
    this.dpaDetailsL,
    this.dpaSuggRepetitionNo,
    this.dpaDecidedRepetitionNo,
    this.dpaSuggPnlId,
    this.pnlNo,
    this.pnlTextA,
    this.pnlTextL,
    this.pnlId,
    this.dpaDecidedPnlId,
    this.pnlNo1,
    this.pnlTextA1,
    this.pnlTextL1,
    this.pnlId1,
    this.dpaDaysToDeduct,
    this.dpaDedMonth,
    this.dpaDedYear,
    this.dpaStatus,
    this.dpaStatusDate,
    this.dpaIsEmpDecided,
    this.dpaEmpDecisionType,
    this.dpaCreatedByUsrId,
    //--------------
    this.ntfSubjectL,
    this.ntfSubjectA,
    this.ntfMsgA,
    this.ntfMsgL,
    this.isAck = false,
    // Evaluate employee
    this.evaluationId,
    this.starRating,
    this.scorePercentage,
    this.grade,
    this.evaluationStartDate,
    this.evaluationEndDate,
    this.remarks,
    this.criteria,
    this.isManager = false,
    this.terminationDate,
    // Cancel Request
    this.canCancelRequest = false,
    this.cancelId,
    // Business Trip
    this.isWithdraw,
    this.wftId,
    this.tripType,
    this.fromPlace,
    this.toPlace,
    this.actualFromDate,
    this.actualToDate,
    this.actualDuration,
    this.via,
    this.requestAdvance,
    this.perDiemsAmount,
    this.accommodationAmount,
    this.transportationAmount,
    this.totalAmount,
    // Termination
    this.requestedLastWorkingDate,
    this.lastWorkingDateHr,
    this.hiringDate,
    this.contractType,
    this.endOfServiceReason,
    this.hrDecisionDetails,
    this.hrCancellationDetails,
    this.years,
    this.days,
    this.months,
  });

  factory ActionData.fromMap(Map<String, dynamic> map) {
    return ActionData(
      requestTable: map['requestTable'],
      employeeNameAr: map['employeeNameAr'],
      employeeNameEn: map['employeeNameEn'],
      employeePic: map['employeePic'],
      requestDesc: map['requestDesc'],
      employeeId: map['employeeId'],
      orgId: map['orgId'],
      employeeTitle: map['employeeTitle'],
      employeeTitleA: map["employeeTitleA"],
      employeeTitleE: map["employeeTitleE"],
      organizationName: map['organizationName'],
      approver: map['approver'],
      approverNameEn: map["approverNameEn"],
      approverNameAr: map["approverNameAr"],
      creationDate: map['creationDate'] != null
          ? DateTime.parse(map['creationDate'])
          : null,
      attachmentList: map['attachmentList'] != null
          ? List<AttachmentList>.from(
              map['attachmentList'].map((x) => AttachmentList.fromMap(x)))
          : null,
      historyDTOs: map['historyDTOs'] != null
          ? List<HistoryDTOs>.from(
              map['historyDTOs'].map((x) => HistoryDTOs.fromMap(x)))
          : null,
      shortLeaveId: map['shortLeaveId'],
      shortLeaveType: map['shortLeaveType'],
      leaveDate:
          map['leaveDate'] != null ? DateTime.parse(map['leaveDate']) : null,
      fromTime:
          map['fromTime'] != null ? DateTime.parse(map['fromTime']) : null,
      toTime: map['toTime'] != null ? DateTime.parse(map['toTime']) : null,
      // time: map['time'] != null ? DateTime.parse(map['time']) : null,
      time: map['time'],
      requestRemarks: map['requestRemarks'],
      requestedByEmployeeId: map['requestedByEmployeeId'],
      requestedByEmployeeName: map['requestedByEmployeeName'],
      status: map['status'] is String ? map['status'] : null,
      statusCode: map['statusCode'] != null && map['statusCode'] is String
          ? RequestStatusExtension.fromName(map['statusCode'])
          : null,
      statusDate:
          map['statusDate'] != null ? DateTime.parse(map['statusDate']) : null,
      statusRemarks: map['statusRemarks'],
      flowId: map['flowId'],
      requestType: map['requestType'] != null
          ? RequestTypeExtension.fromId(map['requestType'])
          : null,
      requestId: map['requestId'],
      vacationId: map['vacationId'],
      vacationTypeName: map['vacationTypeName'],
      fromDate: map['requestedFromDate'] != null
          ? DateTime.parse(map['requestedFromDate'])
          : null,
      toDate: map['requestedToDate'] != null
          ? DateTime.parse(map['requestedToDate'])
          : null,
      reason: map['reason'],
      id: map['id'],
      claimType: map['claimType'],
      details: map['details'],
      transactionId: map['transactionId'],
      loanType: map['loanType'],
      loanDate: map['transactionDate'] != null
          ? DateTime.parse(map['transactionDate'])
          : null,
      numberOfInstallments: map['numberOfInstallments'],
      type: map['type'],
      hours: map['hours'],
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      amount: map['amount'],
      letterType: map['letterType'],
      letterDate:
          map['letterDate'] != null ? DateTime.parse(map['letterDate']) : null,
      isWorkflowCompleted: map['isWorkflowCompleted']?.toString(),
      decisionType: map['decisionType']?.toString(),
      reqActionType: map['reqActionType']?.toString(),
      duration: map['duration']?.toString(),
      punchType: map['punchType'],
      // Disciplinary Actions --------------------------------------------------
      dpaOrgId: map['dpaOrgId'],
      dpaId: map['dpaId'],
      dpaDate: map['dpaDate'] != null ? DateTime.parse(map['dpaDate']) : null,
      dpaEmpId: map['dpaEmpId'],
      empNameA: map['empNameA'],
      empNameL: map['empNameL'],
      empId: map['empId'],
      dpaViolationDate: map['dpaViolationDate'] != null
          ? DateTime.parse(map['dpaViolationDate'])
          : null,
      dpaVapId: map['dpaVapId'],
      vapNameA: map['vapNameA'],
      vapNameL: map['vapNameL'],
      vapSNo: map['vapSNo'],
      vapId: map['vapId'],
      dpaDetailsA: map['dpaDetailsA'],
      dpaDetailsL: map['dpaDetailsL'],
      dpaSuggRepetitionNo: map['dpaSuggRepetitionNo'],
      dpaDecidedRepetitionNo: map['dpaDecidedRepetitionNo'],
      dpaSuggPnlId: map['dpaSuggPnlId'],
      pnlNo: map['pnlNo'],
      pnlTextA: map['pnlTextA'],
      pnlTextL: map['pnlTextL'],
      pnlId: map['pnlId'],
      dpaDecidedPnlId: map['dpaDecidedPnlId'],
      pnlNo1: map['pnlNo1'],
      pnlTextA1: map['pnlTextA1'],
      pnlTextL1: map['pnlTextL1'],
      pnlId1: map['pnlId1'],
      dpaDaysToDeduct: map['dpaDaysToDeduct'],
      dpaDedMonth: map['dpaDedMonth'],
      dpaDedYear: map['dpaDedYear'],
      dpaStatus: map['dpaStatus'],
      dpaStatusDate: map['dpaStatusDate'] != null
          ? DateTime.parse(map['dpaStatusDate'])
          : null,
      dpaIsEmpDecided: map['dpaIsEmpDecided'],
      dpaEmpDecisionType: map['dpaEmpDecisionType'],
      dpaCreatedByUsrId: map['dpaCreatedByUsrId'],
      // Ack---------------------
      ntfSubjectL: map['ntfSubjectL'],
      ntfSubjectA: map['ntfSubjectA'],
      ntfMsgA: map['ntfMsgA'],
      ntfMsgL: map['ntfMsgL'],
      isAck: (map['isAck'] == 1 || map['isAck'] == '1') ? true : false,
      // Evaluate Employee ---------------------
      evaluationId: map['evaluationId'],
      starRating: map['starRating'],
      scorePercentage: map['scorePercentage'],
      grade: map['grade'],
      evaluationStartDate: map['evaluationStartDate'] != null
          ? DateTime.parse(map['evaluationStartDate'])
          : null,
      evaluationEndDate: map['evaluationEndDate'] != null
          ? DateTime.parse(map['evaluationEndDate'])
          : null,
      remarks: map['remarks'],
      criteria: map['criteria'] != null
          ? List<EvaluationCriteriaAction>.from(
              map['criteria'].map((x) => EvaluationCriteriaAction.fromMap(x)))
          : null,
      isManager: map['isManager'] == '2' ? true : false,
      terminationDate:
          map['dpaDate'] != null ? DateTime.parse(map['dpaDate']) : null,
      // Business Trip
      isWithdraw: map["isWithdraw"],
      wftId: map["wftId"],
      tripType: map["tripType"],
      fromPlace: map["fromPlace"],
      toPlace: map["toPlace"],
      actualFromDate: map["actualFromDate"] == null
          ? null
          : DateTime.parse(map["actualFromDate"]),
      actualToDate: map["actualToDate"] == null
          ? null
          : DateTime.parse(map["actualToDate"]),
      actualDuration: map["actualDuration"],
      via: map["via"],
      requestAdvance: map["requestAdvance"],
      perDiemsAmount: map["perDiemsAmount"],
      accommodationAmount: map["accommodationAmount"],
      transportationAmount: map["transportationAmount"],
      totalAmount: map["totalAmount"],

      // Cancellation
      canCancelRequest: (map["isWithdraw"] ?? "").trim() == "Y" ? true : false,
      cancelId: map["wftId"],
      // Termination
      requestedLastWorkingDate: map["requestedLastWorkingDate"] == null
          ? null
          : DateTime.parse(map["requestedLastWorkingDate"]),
      lastWorkingDateHr: map["lastWorkingDateHR"] != null
          ? DateTime.parse(map["lastWorkingDateHR"])
          : null,
      hiringDate:
          map["hiringDate"] != null ? DateTime.parse(map["hiringDate"]) : null,
      contractType: map["contractType"],
      endOfServiceReason: map["endOfServiceReason"],
      hrDecisionDetails: map["hrDecisionDetails"],
      hrCancellationDetails: map["hrCancellationDetails"],
      years: map["years"],
      days: map["days"],
      months: map["months"],
    );
  }

  factory ActionData.fromJson(String map) =>
      ActionData.fromMap(jsonDecode(map));
  @override
  String toString() {
    return 'ActionData(requestTable: $requestTable, employeeNameAr: $employeeNameAr, employeeNameEn: $employeeNameEn, employeePic: $employeePic, requestDesc: $requestDesc, employeeId: $employeeId, orgId: $orgId, employeeTitle: $employeeTitle, employeeTitleA: $employeeTitleA, employeeTitleE: $employeeTitleE, organizationName: $organizationName, approver: $approver, approverNameEn: $approverNameEn, approverNameAr: $approverNameAr, creationDate: $creationDate, attachmentList: $attachmentList, historyDTOs: $historyDTOs, requestedByEmployeeId: $requestedByEmployeeId, requestedByEmployeeName: $requestedByEmployeeName, status: $status, statusCode: $statusCode, statusDate: $statusDate, statusRemarks: $statusRemarks, flowId: $flowId, requestType: $requestType, requestId: $requestId, shortLeaveId: $shortLeaveId, shortLeaveType: $shortLeaveType, leaveDate: $leaveDate, fromTime: $fromTime, toTime: $toTime, requestRemarks: $requestRemarks, vacationId: $vacationId, vacationTypeName: $vacationTypeName, fromDate: $fromDate, toDate: $toDate, reason: $reason, id: $id, claimType: $claimType, date: $date, amount: $amount, letterType: $letterType, letterDate: $letterDate, details: $details, transactionId: $transactionId, loanType: $loanType, loanDate: $loanDate, numberOfInstallments: $numberOfInstallments, type: $type, hours: $hours, reqActionType: $reqActionType, isWorkflowCompleted: $isWorkflowCompleted, decisionType: $decisionType, duration: $duration, time: $time, isManager: $isManager)';
  }
}

class AttachmentList {
  final String? url;
  final String? name;

  AttachmentList({this.url, this.name});

  factory AttachmentList.fromMap(Map<String, dynamic> map) {
    return AttachmentList(
      url: map['url'],
      name: map['name'],
    );
  }
}

class HistoryDTOs {
  final num? ntfId;
  final num? ntfTrxId;
  final num? ntfWprId;
  final String? approver;
  final String? approverPos;
  final RequestStatus? status;
  final String? badgeColor;
  final String? image;

  HistoryDTOs({
    this.ntfId,
    this.ntfTrxId,
    this.ntfWprId,
    this.approver,
    this.approverPos,
    this.status,
    this.badgeColor,
    this.image,
  });

  factory HistoryDTOs.fromMap(Map<String, dynamic> map) {
    return HistoryDTOs(
      ntfId: map['ntfId'],
      ntfTrxId: map['ntfTrxId'],
      ntfWprId: map['ntfWprId'],
      approver: map['approver'],
      approverPos: map['approverPos'],
      status: map['status'] != null
          ? RequestStatusExtension.fromName(map['status'])
          : null,
      badgeColor: map['badgeColor'],
    );
  }
}

class EvaluationCriteriaAction extends Equatable {
  final num? id;
  final String? name;
  final num? maxScore;
  final num? empScore;
  final num? empStarsRate;
  final String? executedBy;
  final String? remarks;

  /// Used for action from the front-end
  final num? submittedScore;

  const EvaluationCriteriaAction({
    this.id,
    this.name,
    this.maxScore,
    this.empScore,
    this.empStarsRate,
    this.executedBy,
    this.remarks,
    this.submittedScore,
  });

  factory EvaluationCriteriaAction.fromMap(Map<String, dynamic> map) {
    return EvaluationCriteriaAction(
      id: map['id'],
      name: map['name'],
      maxScore: map['maxScore'],
      empScore: map['empScore'],
      empStarsRate: map['empStarsRate'],
      executedBy: map['executedBy'],
      remarks: map['remarks'],
    );
  }

  EvaluationCriteriaAction copyWith({
    num? id,
    String? name,
    num? maxScore,
    num? empScore,
    num? empStarsRate,
    String? executedBy,
    String? remarks,
    num? submittedScore,
  }) {
    return EvaluationCriteriaAction(
      id: id ?? this.id,
      name: name ?? this.name,
      maxScore: maxScore ?? this.maxScore,
      empScore: empScore ?? this.empScore,
      empStarsRate: empStarsRate ?? this.empStarsRate,
      executedBy: executedBy ?? this.executedBy,
      remarks: remarks ?? this.remarks,
      submittedScore: submittedScore ?? this.submittedScore,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        maxScore,
        empScore,
        empStarsRate,
        executedBy,
        remarks,
        submittedScore,
      ];
}
