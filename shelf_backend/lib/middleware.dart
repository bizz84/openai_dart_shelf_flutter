import 'package:shelf/shelf.dart';

Middleware rejectBadRequests() {
  return (innerHandler) {
    return (request) {
      if (request.method != 'GET') {
        return Response(405, body: 'Method Not Allowed');
      }
      return innerHandler(request);
    };
  };
}
