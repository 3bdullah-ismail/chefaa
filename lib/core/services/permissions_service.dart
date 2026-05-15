import 'dart:io';

import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

class PermissionsService {
  /// Request Location Permission (Fine & Coarse)
  static Future<permission_handler.PermissionStatus>
  requestLocationPermission() async {
    final status = await permission_handler.Permission.location.request();
    return status;
  }

  /// Request Camera Permission
  static Future<permission_handler.PermissionStatus>
  requestCameraPermission() async {
    final status = await permission_handler.Permission.camera.request();
    return status;
  }

  /// Request Microphone Permission
  static Future<permission_handler.PermissionStatus>
  requestMicrophonePermission() async {
    final status = await permission_handler.Permission.microphone.request();
    return status;
  }

  /// Request Storage/Photo Library Permission
  static Future<permission_handler.PermissionStatus>
  requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await permission_handler.Permission.storage.request();
      return status;
    } else if (Platform.isIOS) {
      final status = await permission_handler.Permission.photos.request();
      return status;
    }
    return permission_handler.PermissionStatus.denied;
  }

  /// Request Notification Permission
  static Future<permission_handler.PermissionStatus>
  requestNotificationPermission() async {
    final status = await permission_handler.Permission.notification.request();
    return status;
  }

  /// Request Contacts Permission
  static Future<permission_handler.PermissionStatus>
  requestContactsPermission() async {
    final status = await permission_handler.Permission.contacts.request();
    return status;
  }

  /// Get Location Permission Status
  static Future<bool> hasLocationPermission() async {
    final status = await permission_handler.Permission.location.status;
    return status.isGranted;
  }

  /// Get Camera Permission Status
  static Future<bool> hasCameraPermission() async {
    final status = await permission_handler.Permission.camera.status;
    return status.isGranted;
  }

  /// Get Notification Permission Status
  static Future<bool> hasNotificationPermission() async {
    final status = await permission_handler.Permission.notification.status;
    return status.isGranted;
  }

  /// Open App Settings if permission denied
  static Future<void> openAppSettings() async {
    await permission_handler.openAppSettings();
  }

  /// Check if permission is permanently denied
  static bool isPermanentlyDenied(permission_handler.PermissionStatus status) {
    return status.isDenied || status.isPermanentlyDenied;
  }

  /// Beautify Permission Status for UI Display
  static String getPermissionStatusMessage(
    permission_handler.PermissionStatus status,
  ) {
    return switch (status) {
      permission_handler.PermissionStatus.granted => 'Permission Granted ✓',
      permission_handler.PermissionStatus.denied => 'Permission Denied',
      permission_handler.PermissionStatus.permanentlyDenied =>
        'Permission Permanently Denied - Please enable in settings',
      permission_handler.PermissionStatus.restricted =>
        'Permission Restricted by system',
      permission_handler.PermissionStatus.limited => 'Permission Limited',
      permission_handler.PermissionStatus.provisional =>
        'Permission Provisional',
    };
  }

  /// Request all critical permissions at app startup
  static Future<Map<String, permission_handler.PermissionStatus>>
  requestCriticalPermissions() async {
    final results = <String, permission_handler.PermissionStatus>{};

    // Location (Critical for clinic search)
    results['location'] = await requestLocationPermission();

    // Notifications (Critical for appointment reminders)
    results['notifications'] = await requestNotificationPermission();

    // Storage (for medical documents)
    results['storage'] = await requestStoragePermission();

    // Camera (for patient records)
    results['camera'] = await requestCameraPermission();

    return results;
  }

  /// Request optional permissions later
  static Future<Map<String, permission_handler.PermissionStatus>>
  requestOptionalPermissions() async {
    final results = <String, permission_handler.PermissionStatus>{};

    // Microphone (for video calls)
    results['microphone'] = await requestMicrophonePermission();

    // Contacts (for emergency sharing)
    results['contacts'] = await requestContactsPermission();

    return results;
  }

  /// Summary of all permissions status
  static Future<Map<String, permission_handler.PermissionStatus>>
  getAllPermissionsStatus() async {
    return {
      'location': await permission_handler.Permission.location.status,
      'camera': await permission_handler.Permission.camera.status,
      'microphone': await permission_handler.Permission.microphone.status,
      'storage': Platform.isAndroid
          ? await permission_handler.Permission.storage.status
          : await permission_handler.Permission.photos.status,
      'notification': await permission_handler.Permission.notification.status,
      'contacts': await permission_handler.Permission.contacts.status,
    };
  }

  /// Check if all critical permissions granted
  static Future<bool> areCriticalPermissionsGranted() async {
    final location = await permission_handler.Permission.location.status;
    final notification =
        await permission_handler.Permission.notification.status;
    final storage = Platform.isAndroid
        ? await permission_handler.Permission.storage.status
        : await permission_handler.Permission.photos.status;

    return location.isGranted && notification.isGranted && storage.isGranted;
  }
}
