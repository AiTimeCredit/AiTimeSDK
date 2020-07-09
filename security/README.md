## Installation ##
To use this library in your android project, just simply add the following dependency into your project `build.gradle` file:
```gradle
dependencies {
    implementation 'com.aitime.android:security:1.0.2'
}
```

## Usage ##
### Encrypt ###
```java
Security.encrypt(content)
```

### Dencrypt ###
```java
Security.dencrypt(content)
```

### MD5 ###
```java
MD5.md5(data)

MD5.md5Hex(data)
```

### AES ###
```java
AES.encrypt(secretKey, vector, content)

AES.decrypt(secretKey, vector, content)
```

### Base64 ###
```java
Base64.encrypt(input, flags)

Base64.decode(input, flags)
```

## ProGuard ##
This library does't use serialization and deserialization, JNI, reflection, so there is no need to add confusing filtering code, and it has been confusing tests pass, if you after the confusion in the use of the project appear problem, please inform us.

