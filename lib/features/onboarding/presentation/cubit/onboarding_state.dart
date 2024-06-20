part of 'onboarding_cubit.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.scrollable() = _Scrollable;
  const factory OnboardingState.last() = _Last;
}
