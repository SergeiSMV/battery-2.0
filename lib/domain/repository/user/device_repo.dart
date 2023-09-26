

abstract class DeviceRepositry {
  
  Future<String> getCurrentDeviceId();

  String getSavedDeviceId();

  Future<void> saveCurrentDeviceId();

  void clearCurrentDeviceId();
  
}