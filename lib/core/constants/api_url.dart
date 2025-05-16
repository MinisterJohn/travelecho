class ApiUrl {
  static const baseURL = "https://travel-echo-backend.onrender.com/api/v1";

  // Authentication
  static const signupURL = "/auth/register";
  static const signinURL = "/auth/login";
  static const sendOtpURL = "/auth/verification/send-otp";
  static const verifyOtpURL = "/auth/verification/verify";
  static const resetPasswordURL = "/auth/recovery/reset-password";
  static const recoveryResendOtpURL = "/auth/recovery/send-otp";
  static const recoveryVerifyOtpURL = "/auth/recovery/verify-otp";

  // Profile
  static const userProfileURL = "/users/me/profile";
  static const userProfileImageURL = "/users/me/profile/image";

  // Memories
  static const memoriesURL = "/users/me/memories";
  static String dynamicMemoryURL(String memoryId) =>
      "/users/me/memories/$memoryId";
  static String memoryImageURL(String memoryId) =>
      "/users/me/memories/$memoryId/images";
  static String dynamicMemoryImageURL(String memoryId, String imageId) =>
      "/users/me/memories/$memoryId/images/$imageId";

  // Optional helper
  static String fullUrl(String path) {
    if (path.startsWith('/')) {
      return "$baseURL$path";
    }
    return "$baseURL/$path";
  }
}
