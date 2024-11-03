abstract class EndPoints {
  static const login = 'login';
  static const register = 'register';
  static const logout = 'logout';
  static const updateProfileImage = 'profile/image';

  static const createConversation = 'conversation';
  static const getUserConversation = 'user/conversations';
  static const sendMessage = 'message';
  static const getChatMessages = 'conversations';
  static const verifyEmail = 'verify';
  static const updateMessageStatus = 'messages/update-status';
  static const deleteMessage = 'deletemessage';

  static const addStory = 'addstory';
  static const getStories = 'stories';
  static const deleteStory = 'delete';
// static const getChatByIdEndpoint = 'chat_message';
// static const sendMessageEndpoint = 'chat_message';
// static const authEndpoint = 'broadcasting/auth';
}
