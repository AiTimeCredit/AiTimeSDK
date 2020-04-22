-flattenpackagehierarchy com.aitime.android.payment
-keepnames class * implements com.aitime.android.payment.core.IPayment

-keep class com.adyen.checkout.base.model.** {*;}
-keep class com.adyen.threeds2.** {*;}
-keepclassmembers public class * implements com.adyen.checkout.base.PaymentComponent {
    public <init>(...);
}