enum HttpRequestType { get, post, put, delete, patch }

extension RequestTypeExtension on HttpRequestType {
  String get value {
    switch (this) {
      case HttpRequestType.get:
        return 'GET';
      case HttpRequestType.post:
        return 'POST';
      case HttpRequestType.put:
        return 'PUT';
      case HttpRequestType.patch:
        return 'PATCH';
      case HttpRequestType.delete:
        return 'DELETE';
    }
  }
}
