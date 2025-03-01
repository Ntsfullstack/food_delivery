/// data : [{"id":0,"post_id":0,"user_id":0,"parent_id":"string","content":"string","created_at":"string"}]
/// error_code : 0
/// message : "string"
/// meta : {"has_next_page":true,"total":0}

class APIResponseHome<T> {
  APIResponseHome({
    T? result,
    String? message,
    String? errorCode,
    String? requestId,
    String? responseTime,
  }) {
    _result = result;
    _message = message;
    _errorCode = errorCode;
    _requestId = requestId;
    _responseTime = responseTime;
  }

  APIResponseHome.fromJson(dynamic json, T Function(dynamic json) fromJsonT) {
    if (json['result'] != null) {
      _result = fromJsonT(json['result']);
    }
    _message = json['message'];
    _requestId = json['requestId'];
    _errorCode = json['errorCode'];
    _responseTime = json['responseTime'];
  }

  APIResponseHome.fromList(
      dynamic json, T Function(List<dynamic>? json) fromJsonT) {
    if (json['result'] != null) {
      _result = fromJsonT(json['result']);
    }
    _message = json['message'];
    _errorCode = json['errorCode'];
    _requestId = json['requestId'];
    _responseTime = json['responseTime'];
  }

  T? _result;
  String? _message;
  String? _errorCode;
  String? _requestId;
  String? _responseTime;

  T? get result => _result;

  String? get message => _message;

  String? get errorCode => _errorCode;

  String? get requestId => _requestId;

  String? get responseTime => _responseTime;

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    final map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = toJsonT(_result as T);
    }
    map['message'] = _message;

    map['errorCode'] = _errorCode;

    map['requestId'] = _requestId;

    map['responseTime'] = _responseTime;
    return map;
  }

  static List<T> fromLJsonListT<T>(json, T Function(Object? json) fromJsonT) {
    return (json as List<dynamic>).map<T>((i) => fromJsonT(i)).toList();
  }
}
