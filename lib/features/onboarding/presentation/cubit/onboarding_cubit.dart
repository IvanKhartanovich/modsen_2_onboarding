import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.dart';
part 'onboarding_cubit.freezed.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState.scrollable());

  void setScrollableState() => emit(const OnboardingState.scrollable());

  void setLastState() => emit(const OnboardingState.last());
}
