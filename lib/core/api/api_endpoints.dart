/// API Endpoints Constants
/// Contains all API URL constants used throughout the application
class ApiEndpoints {
  // Base URL - Update this with your actual API base URL
  static const String baseUrl = 'https://loksandesh.jojolapatech.com';

  // API Version
  static const String apiVersion = '/api/v1';

  // Full base URL with version
  static String get baseUrlWithVersion => '$baseUrl$apiVersion';

  // Authentication endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // User endpoints
  static const String userRegister = '/user/register';
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String changePassword = '/user/change-password';

  // SMS endpoints
  static const String sendSms = '/sms/send';
  static const String sendBulkSms = '/sms/bulk-send';
  static const String smsHistory = '/sms/history';
  static const String smsStatus = '/sms/status';

  // Contact endpoints
  static const String contacts = '/contacts';
  static const String uploadContacts = '/contacts/upload';
  static const String syncContacts = '/contacts/sync';

  // Campaign endpoints
  static const String campaigns = '/campaigns';
  static const String createCampaign = '/campaigns';
  static const String campaignStats = '/campaigns/stats';

  // Content endpoints
  static const String content = '/content';
  static const String uploadContent = '/content/upload';

  // Admin endpoints
  static const String adminUsers = '/admin/users';
  static const String adminStats = '/admin/stats';
  static const String adminSettings = '/admin/settings';

  // Helper method to build full URL
  static String buildUrl(String endpoint) {
    return '$baseUrlWithVersion$endpoint';
  }

  // Helper method to build URL without version
  static String buildUrlWithoutVersion(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
