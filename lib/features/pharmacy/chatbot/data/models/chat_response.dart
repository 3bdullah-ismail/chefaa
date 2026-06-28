class ChatResponse {
  final bool? success;
  final ChatAnswerData? data;

  ChatResponse({this.success, this.data});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? ChatAnswerData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class ChatAnswerData {
  final String? question;
  final String? answer;

  ChatAnswerData({this.question, this.answer});

  factory ChatAnswerData.fromJson(Map<String, dynamic> json) {
    return ChatAnswerData(
      question: json['question'] as String?,
      answer: json['answer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (question != null) 'question': question,
      if (answer != null) 'answer': answer,
    };
  }
}
