
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import '../../domain/repository/user/device_repo.dart';

class DeviceImpl extends DeviceRepositry{

  final deviceID = GetStorage();

  @override
  Future<String> getCurrentDeviceId() async {
    String? deviceId;
    var deviceInfo = DeviceInfoPlugin();
      try {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        deviceId = androidDeviceInfo.id.toString();
        return deviceId;
      } on PlatformException {
        deviceId = 'Failed to get deviceId';
        return deviceId;
      }
  }

  @override
  String getSavedDeviceId() {
    return deviceID.read('deviceId') ?? 'Empty';
  }

  @override
  Future<void> saveCurrentDeviceId() async {
    String currentDeviceId = await getCurrentDeviceId();
    deviceID.write('deviceId', currentDeviceId);
  }

  @override
  void clearCurrentDeviceId() async {
    deviceID.remove('deviceId');
  }

}