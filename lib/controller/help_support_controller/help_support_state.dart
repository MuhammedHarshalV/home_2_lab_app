import 'package:icon_infoware/models/help_support_response/help_support_response_model.dart';

class HelpSupportState {
  final HelpAndSupport? helpAndSupport;
  final HelpAndSupport? termsAndConditions;
  final HelpAndSupport? privacyPolicy;
  final bool? isLoading;

  const HelpSupportState({
    this.helpAndSupport,
    this.termsAndConditions,
    this.privacyPolicy,
    this.isLoading = false,
  });

  HelpSupportState copyWith({
    HelpAndSupport? helpAndSupport,
    HelpAndSupport? termsAndConditions,
    HelpAndSupport? privacyPolicy,
    bool? isLoading,
  }) {
    return HelpSupportState(
      isLoading: isLoading ?? this.isLoading,
      helpAndSupport: helpAndSupport ?? this.helpAndSupport,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }
}
