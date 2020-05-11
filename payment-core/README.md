# Payment SDK

## Installation ##
To use this library in your android project, just simply add the following dependency into your project `build.gradle` file:
``` gradle
dependencies {
    implementation 'com.aitime.android:payment-core:1.0.2'
}
```

## Usage ##
### Initialization ###
```java
PaymentFactory.getInstance().register(application);
```

### Create payment method ###
```java
IPayment payment = PaymentFactory.getInstance().create(activity, payChannel);
if (payment != null) {
    payment.callback(this);
    payment.preload(getApplication());
}
```

### Goto payment ###
```java
if (payment != null) {
    payment.payment(info, params);
}
```

### Release ###
```java
PaymentFactory.getInstance().clear();
```

## ProGuard ##
This library does't use serialization and deserialization, JNI, reflection, so there is no need to add confusing filtering code, and it has been confusing tests pass, if you after the confusion in the use of the project appear problem, please inform us.



