-flattenpackagehierarchy com.aitime.android.payment
-keepnames class * implements com.aitime.android.payment.core.IPayment

-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

-keepattributes JavascriptInterface
-keepattributes *Annotation*

-dontwarn com.razorpay.**
-keep class com.razorpay.** {*;}

-optimizations !method/inlining/*

-keepclasseswithmembers class * {
    public void onPayment*(...);
}