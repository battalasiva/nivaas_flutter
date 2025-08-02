class ErrorHandler {
  static String getErrorMessage(int statusCode, dynamic error) {
    if (error is Exception) {
      try {
        if (statusCode == 400) {
          return 'Bad Request. Please check your input.';
        } else if (statusCode == 401) {
          return 'Unauthorized access! Please log in again.';
        } else if (statusCode == 403) {
          return 'Forbidden! You do not have permission to access this resource.';
        } else if (statusCode == 404) {
          return 'Not Found! The requested resource could not be found.';
        } else if (statusCode == 500) {
          return 'Server error! Please try again later.';
        } else if (statusCode == 502) {
          return 'Bad Gateway! The server is down or being upgraded.';
        } else if (statusCode == 503) {
          return 'Service Unavailable! The server is temporarily unavailable.';
        } else if (statusCode == 408) {
          return 'Request Timeout! The request took too long to process.';
        } else {
          return 'Unexpected error occurred! Please try again.';
        }
      } catch (e) {
        return 'An unexpected error occurred!';
      }
    } else {
      return 'An unknown error occurred!';
    }
  }
}
