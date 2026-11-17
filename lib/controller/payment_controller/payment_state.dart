import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

class PaymentState {
  final List<PatientHiveModel> patientList;
  final List<bool> isCompleteList;
  final num totalamount;
  final String upiReferenceId;
  final bool isPaymentCompletion;

  // Payment types
  final String primaryPaymentType;
  final String secondaryPaymentType;
  final num primaryAmount;
  final num secondaryAmount;

  final num grossAmount;
  final num discountAmount;
  final num serviceAmount;
  final num netAmount;
  final num paidAmount;
  final num balanceAmount;

  const PaymentState({
    this.isPaymentCompletion = false,
    this.patientList = const [],
    this.isCompleteList = const [],
    this.totalamount = 0,
    this.upiReferenceId = '',
    this.primaryPaymentType = 'Cash',
    this.secondaryPaymentType = 'UPI',
    this.primaryAmount = 0,
    this.secondaryAmount = 0,
    this.grossAmount = 0,
    this.discountAmount = 0,
    this.serviceAmount = 0,
    this.netAmount = 0,
    this.paidAmount = 0,
    this.balanceAmount = 0,
  });

  PaymentState copyWith({
    bool? isPaymentCompletion,
    String? upiReferenceId,
    List<PatientHiveModel>? patientList,
    List<bool>? isCompleteList,
    num? totalAmount,
    String? primaryPaymentType,
    String? secondaryPaymentType,
    num? primaryAmount,
    num? secondaryAmount,
    num? grossAmount,
    num? discountAmount,
    num? serviceAmount,
    num? netAmount,
    num? paidAmount,
    num? balanceAmount,
  }) {
    return PaymentState(
      isPaymentCompletion: isPaymentCompletion ?? this.isPaymentCompletion,
      upiReferenceId: upiReferenceId ?? this.upiReferenceId,
      patientList: patientList ?? this.patientList,
      isCompleteList: isCompleteList ?? this.isCompleteList,
      totalamount: totalAmount ?? totalamount,
      primaryPaymentType: primaryPaymentType ?? this.primaryPaymentType,
      secondaryPaymentType: secondaryPaymentType ?? this.secondaryPaymentType,
      primaryAmount: primaryAmount ?? this.primaryAmount,
      secondaryAmount: secondaryAmount ?? this.secondaryAmount,
      grossAmount: grossAmount ?? this.grossAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      serviceAmount: serviceAmount ?? this.serviceAmount,
      netAmount: netAmount ?? this.netAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
    );
  }
}
