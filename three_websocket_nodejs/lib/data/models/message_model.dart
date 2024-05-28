class Message {
  final String name;
  final String message;
  final String article;

  Message({
    required this.name,
    required this.message,
    required this.article,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      name: json['name'] ?? 'Unknown', // Default value if null
      message: json['message'] ?? 'No message', // Default value if null
      article: json['article'] ?? 'No article', // Default value if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'message': message,
      'article': article,
    };
  }
}
