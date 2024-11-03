class LoginScreenStates {}

class LoginScreenInitialState extends LoginScreenStates {}

class LoginScreenLoadingState extends LoginScreenStates {}

class LoginScreenSuccessState extends LoginScreenStates {}

class LoginScreenErrorState extends LoginScreenStates {
  String error;

  LoginScreenErrorState(this.error);
}
