import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:permission_handler/permission_handler.dart';

enum PermissionTypeEnum {
  photo,
  camera,
  location;

  String get nameOf {
    switch (this) {
      case PermissionTypeEnum.photo:
        return 'photo';
      case PermissionTypeEnum.camera:
        return 'camera';
      case PermissionTypeEnum.location:
        return 'location';
      default:
        return "";
    }
  }

  Permission get permission {
    switch (this) {
      case PermissionTypeEnum.photo:
        return Permission.photos;
      case PermissionTypeEnum.camera:
        return Permission.camera;
      case PermissionTypeEnum.location:
        return Permission.location;
      default:
        return Permission.unknown;
    }
  }
}

class PermissionService {
  Future<bool> requestPermission(PermissionTypeEnum type) async {
    if (kIsWeb) {
      return true;
    } else if (Platform.isIOS) {
      return await _permissionWithIOS(type);
    } else {
      return await _permissionWithAndroid(type);
    }
  }

  Future<bool> _permissionWithIOS(PermissionTypeEnum type) async {
    final PermissionStatus status = await type.permission.status;

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();

      return false;
    } else if (status.isLimited) {
      return true;
    } else {
      final PermissionStatus status = await type.permission.request();

      return status.isGranted;
    }
  }

  Future<bool> requestCameraPermission() async {
    if (kIsWeb) return true;

    final PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();

      return false;
    } else {
      final PermissionStatus status = await Permission.camera.request();

      return status.isGranted;
    }
  }

  Future<bool> _permissionWithAndroid(PermissionTypeEnum type) async {
    final PermissionStatus status = await type.permission.status;

    if (status.isGranted) return true;

    var shouldShowRequestRationale =
        await type.permission.shouldShowRequestRationale;

    if (!shouldShowRequestRationale) {
      final PermissionStatus status = await type.permission.request();

      if (status.isPermanentlyDenied) {
        openAppSettings();
      }

      return status.isGranted;
    } else {
      final PermissionStatus status = await type.permission.request();

      return status.isGranted;
    }
  }
}
