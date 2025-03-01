
import 'dart:convert';

class Result<T> {
  Result({
    this.status,
    this.rc,
    this.text,
    this.messages,
    this.isError = false,
  });

  bool? status;
  bool isError;
  var rc;
  String? text;
  String? messages;

  /// TO PARSE INTO MODEL USE .fromMap()
  late T body;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        status: json["status"],
        rc: json["rc"],
        text: json["text"],
        messages: json["messages"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "rc": rc,
        "text": text,
        "messages": messages,
      };
}
