class ChatScreenStates {}

class ChatScreenInitialState extends ChatScreenStates {}

class ChatScreenLoadingState extends ChatScreenStates {}

class ChatScreenSuccessState extends ChatScreenStates {}

class ChatScreenErrorState extends ChatScreenStates {
  String error;

  ChatScreenErrorState(this.error);
}
