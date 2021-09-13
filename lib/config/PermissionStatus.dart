enum PermissionStatus {
  /// The user denied access to the requested feature.
  denied, //权限被拒绝

  /// The user granted access to the requested feature.
  granted, //通过

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  /// *Only supported on iOS.*
  restricted, //IOS

  ///User has authorized this application for limited access.
  /// *Only supported on iOS (iOS14+).*
  limited, //IOS

  /// The user denied access to the requested feature and selected to never
  /// again show a request for this permission. The user may still change the
  /// permission status in the settings.
  /// *Only supported on Android.*
  permanentlyDenied, //拒绝，且不在提示
}
