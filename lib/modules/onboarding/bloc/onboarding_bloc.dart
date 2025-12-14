import 'package:bloc/bloc.dart';
import 'package:kids_learning/modules/onboarding/bloc/onboarding_event.dart';
import 'package:kids_learning/modules/onboarding/bloc/onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {});
  }
}
