class APIResponsePaging<T> {
  APIResponsePaging({
    T? data,
    String? message,
    num? statusCode,
    num? count,
    dynamic currentPage,
    dynamic nextPage,
    dynamic prevPage,
    dynamic lastPage,
  }) {
    _data = data;
    _message = message;
    _statusCode = statusCode;
    _count = count;
    _currentPage = _parseNumeric(currentPage);
    _nextPage = _parseNumeric(nextPage);
    _prevPage = _parseNumeric(prevPage);
    _lastPage = _parseNumeric(lastPage);
  }

  APIResponsePaging.fromJson(dynamic json, T Function(dynamic json) fromJsonT) {
    if (json['data'] != null) {
      _data = fromJsonT(json['data']);
    }
    _message = json['message'];
    _statusCode = json['statusCode'];
    _count = json['count'];
    _currentPage = _parseNumeric(json['currentPage']);
    _nextPage = _parseNumeric(json['nextPage']);
    _prevPage = _parseNumeric(json['prevPage']);
    _lastPage = _parseNumeric(json['lastPage']);
  }

  APIResponsePaging.fromList(
      dynamic json, T Function(List<dynamic>? json) fromJsonT) {
    if (json['data'] != null) {
      _data = fromJsonT(json['data']);
    }
    _message = json['message'];
    _statusCode = json['statusCode'];
    _count = json['count'];
    _currentPage = _parseNumeric(json['currentPage']);
    _nextPage = _parseNumeric(json['nextPage']);
    _prevPage = _parseNumeric(json['prevPage']);
    _lastPage = _parseNumeric(json['lastPage']);
  }

  // Helper method to parse numeric values
  num? _parseNumeric(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) {
      try {
        return num.tryParse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  T? _data;
  String? _message;
  num? _statusCode;
  num? _count;
  num? _currentPage;
  num? _nextPage;
  dynamic _prevPage;
  dynamic _lastPage;

  T? get data => _data;
  String? get message => _message;
  num? get statusCode => _statusCode;
  num? get count => _count;
  num? get currentPage => _currentPage;
  num? get nextPage => _nextPage;
  dynamic get prevPage => _prevPage;
  dynamic get lastPage => _lastPage;

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = toJsonT(_data!);
    }
    map['message'] = _message;
    map['statusCode'] = _statusCode;
    map['count'] = _count;
    map['currentPage'] = _currentPage;
    map['nextPage'] = _nextPage;
    map['prevPage'] = _prevPage;
    map['lastPage'] = _lastPage;
    return map;
  }

  static List<T> fromLJsonListT<T>(json, T Function(Object? json) fromJsonT) {
    return (json as List<dynamic>).map<T>((i) => fromJsonT(i)).toList();
  }
}