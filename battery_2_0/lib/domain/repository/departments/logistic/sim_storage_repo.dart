

import 'package:flutter/material.dart';

import '../../../models/accesses/accesses.dart';

abstract class SimStorageRepository{

  List simStorageMain(Accesses? allAccesses, String depence);

  void filterItems(BuildContext context, List items, String filter);

  List editDataItems(List startItems);

  Future<String> sendQrCodes(List items);

  Map sameItems(List items, String fullName);

  Future selectedItem(String itemId);

}