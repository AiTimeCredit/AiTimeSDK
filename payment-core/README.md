# Payment SDK

## Installation ##
To use this library in your android project, just simply add the following dependency into your project `build.gradle` file:
``` gradle
dependencies {
    // payment core
    implementation 'com.aitime.android:payment-core:1.0.2'
    // optional - payment for offline
    implementation 'com.aitime.android:payment-offline:1.0.2'
    // optional - payment for cashfree
    implementation 'com.aitime.android:payment-cashfree:1.0.2'
    // optional - payment for razorpay
    implementation 'com.aitime.android:payment-razorpay:1.0.2'
    // optional - payment for adyen
    implementation 'com.aitime.android:payment-adyen:1.0.2'
    // optional - payment for braintree
    implementation 'com.aitime.android:payment-braintree:1.0.2'
}
```

## Usage ##
### Initialization ###
```java
PaymentFactory.getInstance().register(application);
```

### Add configuration ###
#### Payment for cashfree ####
On the `onActivityResult()` function of the invoking `Activity`  to receive callbacks for the payment result:
```java
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_CANCELED || data == null) {
            // Show a toast with "Payment cancelled" message for the user. 
            return;
        }
        Bundle bundle = data.getExtras() == null ? new Bundle() : data.getExtras();
        if (PayChannel.CASHFREE.equals(payChannel)) {
            if (resultCode != Activity.RESULT_OK) {
                // Show a toast with "Payment cancelled" message for the user. 
                return;
            }
            onPaymentResult(bundle.getString("txStatus"), bundle);
        }
    }
```
In the intent extras you will receive a set of response parameters which is used to determine if the transaction was successful or not. 

#### Payment for braintree ####
On the `onActivityResult()` function of the invoking `Activity`  to receive callbacks for the payment result:
```java
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_CANCELED || data == null) {
            // Show a toast with "Payment cancelled" message for the user. 
            return;
        }
        Bundle bundle = data.getExtras() == null ? new Bundle() : data.getExtras();
        if (PayChannel.BRAINTREE.equals(payChannel)) {
            BraintreeResult result = BraintreeResult.create(data);
            if (result.getException() == null) {
                bundle.putString("deviceData", result.getDeviceData());
                bundle.putString("paymentMethodNonce", result.getNonce());
            } else {
                bundle.putString("message", result.getMessage());
            }
            onPaymentResult(String.valueOf(resultCode), bundle);
        }
    }
```

#### Payment for razorpay ####
Implementation the `com.razorpay.PaymentResultWithDataListener` class in the invoking `Activity`  to receive callbacks for the payment result:
```java
public class RepaymentActivity extends Activity implements PaymentResultWithDataListener {

    @Override
    public void onPaymentSuccess(String message, PaymentData paymentData) {
        // Add your logic here for a successful payment response
        onPaymentResult(1, -1, message, paymentData);
    }

    @Override
    public void onPaymentError(int code, String message, PaymentData paymentData) {
        // Add your logic here for a failed payment response
        onPaymentResult(0, code, message, paymentData);
    }

    private void onPaymentResult(int status, int code, String message, PaymentData paymentData) {
        Bundle bundle = new Bundle();
        bundle.putString("status", String.valueOf(status));
        bundle.putString("code", String.valueOf(code));
        bundle.putString("message", message);
        bundle.putString("orderId", paymentData.getOrderId());
        bundle.putString("paymentId", paymentData.getPaymentId());
        bundle.putString("signature", paymentData.getSignature());
        onPaymentResult(String.valueOf(status), bundle);
    }
    
}
```
`PaymentResultWithDataListener` provides additional payment data, such as `email` and `contact` of the customer, along with the `order_id`, `payment_id`, `signature` and more.

#### Payment for adyen ####
Extend the `com.aitime.android.payment.adyen.SimpleDropInService` class and use the `makePaymentsCallOrFailure()` and `makeDetailsCallOrFailure()` function to pass data between your client app and your server:
```java
Adyen.setDropInServiceClass(Class<? extends SimpleDropInService> dropInServiceClass);
```

#### Payment for offline ####
Implementation the `com.aitime.android.payment.IOfflineDialog` class to specify a custom offline repayment dialog:
```java
Offline.setDialogClass(Class<? extends IOfflineDialog> dialogClass);
```

### Create payment method ###
```java
IPayment payment = PaymentFactory.getInstance().create(Activity activity, String payChannel);
if (payment != null) {
    payment.callback(this);
    payment.preload(getApplication());
}
```
The currently supported payment channels can be viewed in `com.aitime.android.payment.core.PayChannel`.

### Goto payment ###
```java
if (payment != null) {
    payment.payment(PaymentInfo info, Map<String, String> params);
}
```
The `info` contains some payment info, such as `orderId`, `currency`, `payMoney`, `name`, `email`, `contact` and more. The `params` contains some parameters that call up the payment SDK,such as `Cashfree` requires `appId`, `orderId`, `token` and `stage` parameters,`Razorpay` requires `razorpayKey` and `razorId` parameters,`Adyen` requires `environmentName`、`publicKey`、`countryCode`、`merchantAccount`、`paymentMethods` and `shopperLocale` parameters,`Braintree` requires `token` parameters,`Offline` requires `explain` parameters.

### Handle payment result ###
Implementation the `com.aitime.android.payment.core.IPaymentCallback` class in the invoking class to receive callbacks for the payment result:
```java
public class RepaymentClass implements IPaymentCallback {

    @Override
    public void onPaymentResult(@Nullable String status, @NonNull Bundle bundle) {
        // Add your logic here for the payment response
        if (payment == null || !payment.isAvailable(status, bundle)) {
            // For failure payment, you can directly return or continue to submit to server
            return;
        }
        Logger.i(TAG, bundle.toString());
        verifyPaymentResult(bundle);
    }
    
}
```
All payment methods are eventually called back to `onPaymentResult()` function, and the payment results are processed uniformly. The `bundle` contains some payment response to submit to server.

### Release ###
```java
PaymentFactory.getInstance().clear();
```

## ProGuard ##
This library does't use serialization and deserialization, JNI, reflection, so there is no need to add confusing filtering code, and it has been confusing tests pass, if you after the confusion in the use of the project appear problem, please inform us.

