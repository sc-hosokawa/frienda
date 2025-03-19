# FRIENDSHIP. DAO Mobile Client

## Versioning
- staging testflight: x.yy.zz
ステージング環境のアプリリリースはzzをインクリメントする

- production: x.yy.zz
Production環境のアプリリリースはyyをインクリメントする

## Build and Run

### iOS App (Staging)

- Configure Bundle Identifer to `com.frienda.client.staging`

- Run command and Override firebase_options.dart. Select only android and ios on terminal.

```
flutterfire configure --project frienda-auth-test1
```

- Run an app on the Simulator

```
flutter run --dart-define-from-file=dart_defines/staging.json
```

- Build iOS App
```
flutter build ipa --dart-define-from-file=dart_defines/staging.json
```

- Edit ExportOptions.plist

- Upload to App Store Connect
```
flutter build ipa --dart-define-from-file=dart_defines/staging.json --export-options-plist="build/ios/ipa/ExportOptions.plist"
```


### iOS App (Production)

- Configure Bundle Identifer to `com.frienda.client`

- Run command and Override firebase_options.dart. Select only android and ios on terminal.
```
flutterfire configure --project friendship-dao
```

- Run an app on the Simulator
```
flutter run --dart-define-from-file=dart_defines/prod.json
```

- Check Versioning
increase miner version!

- Build iOS App and upload to App Store Connect
```
flutter build ipa --dart-define-from-file=dart_defines/prod.json
```
```
flutter build ipa --dart-define-from-file=dart_defines/prod.json --export-options-plist="build/ios/ipa/ExportOptions.plist"
```

## Android App (Staging)

- Configure package name to `com.frienda.staging`

- Run command and Override firebase_options.dart. Select only android and ios on terminal.

```
flutterfire configure --project frienda-auth-test1
```

- Run an app on the Emulator

```
flutter run --dart-define-from-file=dart_defines/staging.json
```

- Build Android App and upload to Google Play Console
```
flutter build appbundle --dart-define-from-file=dart_defines/staging.json
```

- Upload via Google Play Console

## Android App (Production)

- Configure Bundle Identifer to `com.frienda.friendshipdao`

- Check versioning.

- Run an app on the Simulator
```
flutter run --dart-define-from-file=dart_defines/prod.json
```

- Build Android App and upload to Google Play Console

```
flutter build appbundle --release --dart-define-from-file=dart_defines/prod.json
```
