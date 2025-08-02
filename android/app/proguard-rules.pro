# Razorpay Keep Rules
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Keep callback interfaces
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# (Optional) In case you use WebView with Razorpay
-keepclassmembers class com.razorpay.Checkout {
   public *;
}
