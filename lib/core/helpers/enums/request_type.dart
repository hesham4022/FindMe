enum HttpRequestType { get, post, put, delete }

extension RequestTypeExtension on HttpRequestType {
  String get value {
    switch (this) {
      case HttpRequestType.get:
        return 'GET';
      case HttpRequestType.post:
        return 'POST';
      case HttpRequestType.put:
        return 'PUT';
      case HttpRequestType.delete:
        return 'DELETE';
    }
  }
}
