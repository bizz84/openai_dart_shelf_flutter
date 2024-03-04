import 'package:shelf/shelf.dart';
import 'package:shelf_backend/env_variables.dart';

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

Middleware checkAuthentication() {
  return (innerHandler) {
    return (request) {
      final bearer = request.headers['authorization'];
      if (bearer == null || !bearer.startsWith('Bearer ')) {
        return Response(401, body: 'Unauthorized');
      }
      final apiKey = bearer.substring(7);
      if (apiKey != clientApiKey) {
        return Response(403, body: 'Forbidden');
      }
      return innerHandler(request);
    };
  };
}
