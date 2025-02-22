class ChatModel {
  bool type;
  String message;
  final bool isLoading;
  ChatModel({
    required this.message,
    required this.type,
    this.isLoading = false,
  });
}
