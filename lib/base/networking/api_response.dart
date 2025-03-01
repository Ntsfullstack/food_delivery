
/// data : [{"id":0,"post_id":0,"user_id":0,"parent_id":"string","content":"string","created_at":"string"}]
/// error_code : 0
/// message : "string"
/// meta : {"has_next_page":true,"total":0}

class APIResponse<T> {
  APIResponse({
    T? data,
    String? message,
    num? statusCode,
  }) {
    _data = data;
    _message = message;
    _statusCode = statusCode;
  }

  APIResponse.fromJson(dynamic json, T Function(dynamic json) fromJsonT) {
    if (json['data'] != null) {
      _data = fromJsonT(json['data']);
    }
    _message = json['message'];
    _statusCode = json['statusCode'];
  }

  APIResponse.fromList(
      dynamic json, T Function(List<dynamic>? json) fromJsonT) {
    if (json['data'] != null) {
      _data = fromJsonT(json['data']);
    }
    _message = json['message'];
    _statusCode = json['statusCode'];
  }

  T? _data;
  String? _message;
  num? _statusCode;

  T? get data => _data;


  String? get message => _message;

  num? get success => _statusCode;

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = toJsonT(_data as T);
    }
    map['message'] = _message;
    map['success'] = _statusCode;
    return map;
  }

  static List<T> fromLJsonListT<T>(json, T Function(Object? json) fromJsonT) {
    return (json as List<dynamic>).map<T>((i) => fromJsonT(i)).toList();
  }
}
