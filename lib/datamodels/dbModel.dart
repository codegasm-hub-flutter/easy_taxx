class DbModel {
  final int id;
  final String question;
  final String answer;
  final String status;

  DbModel({this.id, this.question, this.answer, this.status});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'question': question,
      'answer': answer,
      'status': status,
    };
  }
}
