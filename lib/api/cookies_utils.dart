class CookiesUtils {
  static String formatWanAndroidCookies(String cookies) {
    try {
      var cookieArray = cookies.trim().split("\n");
      var formattedCookies = cookieArray.map((line) {
        var parts = line.split("\t");
        return "${parts[5]}=${parts[6]}";
      }).join("; ");
      return formattedCookies;
    } catch (e) {
      return "";
    }
  }
}
