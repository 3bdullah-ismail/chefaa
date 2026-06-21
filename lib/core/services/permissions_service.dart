import 'dart:io';

import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

class PermissionsService {
  static Future<permission_handler.PermissionStatus>
  requestLocationPermission() async {
    final status = await permission_handler.Permission.location.request();
    return status;
  }

  static Future<permission_handler.PermissionStatus>
  requestCameraPermission() async {
    final status = await permission_handler.Permission.camera.request();
    return status;
  }

  static Future<permission_handler.PermissionStatus>
  requestMicrophonePermission() async {
    final status = await permission_handler.Permission.microphone.request();
    return status;
  }

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

  static Future<permission_handler.PermissionStatus>
  requestNotificationPermission() async {
    final status = await permission_handler.Permission.notification.request();
    return status;
  }

  static Future<permission_handler.PermissionStatus>
  requestContactsPermission() async {
    final status = await permission_handler.Permission.contacts.request();
    return status;
  }

  static Future<bool> hasLocationPermission() async {
    final status = await permission_handler.Permission.location.status;
    return status.isGranted;
  }

  static Future<bool> hasCameraPermission() async {
    final status = await permission_handler.Permission.camera.status;
    return status.isGranted;
  }

  static Future<bool> hasNotificationPermission() async {
    final status = await permission_handler.Permission.notification.status;
    return status.isGranted;
  }

  static Future<void> openAppSettings() async {
    await permission_handler.openAppSettings();
  }

  static bool isPermanentlyDenied(permission_handler.PermissionStatus status) {
    return status.isDenied || status.isPermanentlyDenied;
  }

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

  static Future<Map<String, permission_handler.PermissionStatus>>
  requestCriticalPermissions() async {
    final results = <String, permission_handler.PermissionStatus>{};

    results['location'] = await requestLocationPermission();

    results['notifications'] = await requestNotificationPermission();

    results['storage'] = await requestStoragePermission();

    results['camera'] = await requestCameraPermission();

    return results;
  }

  static Future<Map<String, permission_handler.PermissionStatus>>
  requestOptionalPermissions() async {
    final results = <String, permission_handler.PermissionStatus>{};

    results['microphone'] = await requestMicrophonePermission();

    results['contacts'] = await requestContactsPermission();

    return results;
  }

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
