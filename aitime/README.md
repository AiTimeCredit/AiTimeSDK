
## Installation ##
To use this library in your android project, just simply add the following dependency into your project `build.gradle` file:
``` gradle
dependencies {
    implementation 'com.aitime.core:credit:1.0.0'
}
```
The latest version is:[![AiTime Version](https://api.bintray.com/packages/zhi1ong/maven/arouter-api/images/download.svg)](https://bintray.com/zhi1ong/maven/arouter-api/_latestVersion)

## Add permissions ##
The AiTime requires that you add the permissions shown below in your `AndroidManifest.xml` file. We support integration from API level 9. Do ensure that the minSdkVersion in the build.gradle of your app is equal to (or greater than) that.
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Allows an application to open network sockets. -->
    <uses-permission android:name="android.permission.INTERNET" />
    <!-- Allows an application to access device's bluetooth. -->
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <!-- Allows an application to access network information. -->
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <!-- Allows an application to access device's location. -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <!-- Allows an application to read the user's contacts data. -->
    <uses-permission android:name="android.permission.READ_CONTACTS" />
    <!-- Allows an application to read the user's SMS messages. -->
    <uses-permission android:name="android.permission.READ_SMS" />
    <!-- Allows an application to read the user's call log. (Optional) -->
    <uses-permission android:name="android.permission.READ_CALL_LOG" />

</manifest>
```

AiTime collects data just for the corresponding permissions taken by the Host Application.
Hence, before invoking AiTime SDK, the Host application is recommended to take necessary permissions from the above list for which data needs to be collected. 
Also, The **android.permission.READ_CALL_LOG** permission is optional, all other permissions are required. To ensure the accuracy of the data, AiTime recommends that the Host application take all necessary permissions.
Request App Permissions could can be seen [here](https://developer.android.com/training/permissions/requesting).

## Usage ##
### 1. Initialization ###
#### 1.1 Add apiKey ####
In `AndroidManifest.xml`, add the following element as a child of the `<application>` element, by inserting it just before the closing `</application>` tag:
```xml
<meta-data
    android:name="com.aitime.com.apiKey"
    android:value="<YOUR_API_KEY>" />
```
In the value attribute, replace **`<YOUR_API_KEY>`** with your apiKey provided by the AiTime Team.

#### 1.2 Print log ####
You can control whether the SDK running debug log is output by calling the following methods. By default, the SDK running debug log is turned off. Requires the user to open it manually.
```java
AiTime.openLog();// Print log
```
If you want to look at the log during the initialization process, be sure to turn on the LOG switch before calling the initialization method.

#### 1.3 Initialize the SDK ####
As early as possible, it is recommended to initialize in the `Application`:
```java
AiTime.init(application);// Initialize SDK
```

If the apiKey is not configured in the `AndroidManifest.xml` file, please use the following method to initialize the SDK:
```java
AiTime.init(application, apiKey);// Initialize SDK
```

If the apiKey has been configured in the Manifest file and the code method can be empty, use the apiKey configured in AndroidManifest.xml, otherwise the apiKey parameter of the code method must be passed in.
The code method of apiKey has higher priority than the AndroidManifest.xml configuration method.

#### 1.4 Set unique identifier ####
After AiTime is initialized, set the userId to help the API process the data:
```java
AiTime.getInstance().setUserId(userId);// Set a unique identifier
```
The userId means a unique identifier of AiTime client, that uniquely identifies User according to client. This is helpful in pulling data from API.

### 2. Collect necessary information ###
Collect some necessary information of user equipment for risk control analysis.

#### 2.1 Collect device information ####
```java
AiTime.getInstance().executeUploadDeviceInfoTask()
```
This task is used to collect some hardware information of the device.

#### 2.2 Collect location information ####
```java
AiTime.getInstance().executeUploadLocationTask();
```
This task is used to collect device's location information.In order to successfully execute this task, the user needs to grant [`android.permission.ACCESS_FINE_LOCATION`](https://developer.android.com/reference/android/Manifest.permission.html#ACCESS_FINE_LOCATION) and [`android.permission.ACCESS_COARSE_LOCATION`](https://developer.android.com/reference/android/Manifest.permission.html#ACCESS_COARSE_LOCATION) permissions.

#### 2.3 Collect apps information ####
```java
AiTime.getInstance().executeUploadAppInfosTask();
```
This task is used to collect a list of applications that have been installed on the device.

#### 2.4 Collect contacts information ####
```java
AiTime.getInstance().executeUploadContactsTask();
```
This task is used to collect contacts information on the device.In order to successfully execute this task, the user needs to grant [`android.permission.READ_CONTACTS`](https://developer.android.com/reference/android/Manifest.permission.html#READ_CONTACTS) permission.

#### 2.5 Collect SMS messages information ####
```java
AiTime.getInstance().executeUploadSmsLogsTask();
```
This task is used to collect SMS messages information on the device.In order to successfully execute this task, the user needs to grant [`android.permission.READ_SMS`](https://developer.android.com/reference/android/Manifest.permission.html#READ_SMS) permission.

#### 2.6 Upload call log information (Optional) ####
```java
AiTime.getInstance().executeUploadCalllogsTask();
```
This task is used to collect call log information on the device.In order to successfully execute this task, the user needs to grant [`android.permission.READ_CALL_LOG`](https://developer.android.com/reference/android/Manifest.permission.html#READ_CALL_LOG) permission.

#### 2.6 Upload risk information ####
```java
AiTime.getInstance().executeUploadRiskInfoTask();
```
This task is used to collect contacts、SMS messages、call log and list of installed applications information on the device. This task can be used instead of the `executeUploadAppInfosTask()`、`executeUploadContactsTask()`、`executeUploadSmsLogsTask()` and `executeUploadCalllogsTask()`.

## ProGuard ##
This library does't use serialization and deserialization, JNI, reflection, so there is no need to add confusing filtering code, and it has been confusing tests pass, if you after the confusion in the use of the project appear problem, please inform us.




