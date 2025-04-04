class QueryModel {
  String? ticketId;
  String? userId;
  String? query;
  DateTime? dateTime;

  QueryModel({
    this.ticketId,
    this.userId,
    this.query,
    this.dateTime,
  });

  factory QueryModel.fromJson(Map<String, dynamic> map) {
    return QueryModel(
      ticketId: map['ticketId'],
      userId: map['userId'],
      query: map['query'],
      dateTime: map['dateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'userId': userId,
      'query': query,
      'dateTime': dateTime,
    };
  }
}
