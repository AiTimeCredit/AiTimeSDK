# Payment SDK

## Installation ##
To use this library in your android project, just simply add the following dependency into your project `build.gradle` file:
```gradle
dependencies {
    implementation 'com.aitime.android:ocr-camera:1.0.5'
}
```

## Usage ##
### Start activity ###
```java
Intent intent = CameraActivity.getIntent(Context context, int ocrType);
startActivityForResult(intent, REQUEST_OCR_CAMERA);
// or
Intent intent = CameraActivity.getIntent(Context context, int ocrType, String filePath);
startActivityForResult(intent, REQUEST_OCR_CAMERA);
```

### Handle result ###
On the `onActivityResult()` function of the invoking `Activity`  to receive callbacks for the camera result:
```java
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode != Activity.RESULT_OK) {
            return;
        }
        if (requestCode == REQUEST_OCR_CAMERA) {
            if (data == null) {
                return;
            }
            String filePath = data.getStringExtra(CameraConfig.FILE_PATH);
            // Add your logic here for the camera result
        }
    }
```

## ProGuard ##
This library does't use serialization and deserialization, JNI, reflection, so there is no need to add confusing filtering code, and it has been confusing tests pass, if you after the confusion in the use of the project appear problem, please inform us.

