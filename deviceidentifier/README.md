## Installation ##
To use this library in your android project, just simply add the following dependency into your project `build.gradle` file:
``` gradle
dependencies {
    implementation 'com.aitime.android:deviceid:1.0.1'
}
```

## Add permissions ##
The DeviceIdentifier requires that you add the permissions shown below in your `AndroidManifest.xml` file. We support integration from API level 9. Do ensure that the minSdkVersion in the build.gradle of your app is equal to (or greater than) that.
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Allows an application to access device's external storage. -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

</manifest>
```

DeviceIdentifier read and write the unique identifier of the device just for the corresponding permissions taken by the Host Application.
Hence, before invoking AiTime SDK, the Host application is recommended to take necessary permissions from the above list for which needs to use. 
Request App Permissions could can be seen [here](https://developer.android.com/training/permissions/requesting).

## Usage ##
If you need to use the unique identifier of the device,  just simply add the following code where it is used:
```java
String uniqueIdentifier = DeviceIdentifier.getUniqueIdentifier(context);
```

## ProGuard ##
This library does't use serialization and deserialization, JNI, reflection, so there is no need to add confusing filtering code, and it has been confusing tests pass, if you after the confusion in the use of the project appear problem, please inform us.

