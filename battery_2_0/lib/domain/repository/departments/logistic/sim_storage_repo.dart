

import '../../../models/accesses/accesses.dart';

abstract class SimStorageRepository{

  // меню склада сырья и материалов
  List simStorageMain(Accesses? allAccesses, String depence);

}