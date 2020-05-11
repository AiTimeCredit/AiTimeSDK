## 依赖 ##
要在您的 Android 项目中使用此 SDK，只需将以下依赖项添加到项目的 `build.gradle` 文件中：
``` gradle
dependencies {
    implementation 'com.aitime.android:deviceid:1.0.0'
}
```

## 权限 ##
SDK 最低支持 API 级别 9 的集成，请确保您的应用程序 `build.gradle` 中的 `minSdkVersion` 等于（或大于）该值，另外还需要您在 `AndroidManifest.xml` 文件中添加以下权限：
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Allows an application to access device's external storage. -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

</manifest>
```

SDK 仅在宿主应用程序获得相应权限后读写设备的唯一标识符。因此，在使用 SDK 之前，建议宿主应用程序先获取上面列表中需要使用的必要权限。
请求应用程序权限可以参考 [here](https://developer.android.com/training/permissions/requesting).

## 使用 ##
如果您需要使用设备的唯一标识符，只需在使用它的地方添加以下代码即可：
```java
String uniqueIdentifier = DeviceIdentifier.getUniqueIdentifier(context);
```

## 混淆 ##
该 SDK 不使用序列化和反序列化、JNI、反射，因此不需要添加混淆配置，如果您在使用过程中遇到问题，请和我们联系。
