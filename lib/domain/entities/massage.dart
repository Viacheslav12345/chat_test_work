class Message {
  int idFrom;
  int idTo;
  String timestamp;
  String content;

  Message({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
  });

  Map<dynamic, dynamic> toJson() {
    return {
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
    };
  }

  factory Message.fromJson(Map<dynamic, dynamic> json) => Message(
        idFrom: json['idFrom'] as int,
        idTo: json['idTo'] as int,
        timestamp: json['timestamp'],
        content: json['content'],
      );
}
