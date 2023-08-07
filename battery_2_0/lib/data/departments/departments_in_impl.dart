import 'package:battery_2_0/domain/models/accesses/accesses.dart';
import 'package:battery_2_0/domain/repository/departments/departments_in_repo.dart';

import '../../domain/repository/departments/accesses_names.dart';

class DepartmentsInImpl extends DepartmentsInRepository{
  
  
  @override
  int inQuantity(Accesses? allAccesses, String depence) {
    List chapters = [];

    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == depence ? chapters.add(dp) : null;
    }

    return chapters.length;
  }
  
  @override
  List departmentsAccesses(Accesses? allAccesses, String depence) {
    List accesses = [];
    int index = 0;

    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == depence && dp['chapter'] == simStorage ? {
        dp['route'] = '/logistic/sim', dp['index'] = index, index = index + 1, accesses.add(dp)
      } : null;
      dp['depence'] == depence && dp['chapter'] == gpStorage ? {
        dp['route'] = '/logistic/gp', dp['index'] = index, index = index + 1, accesses.add(dp)
      } : null;

    }

    return accesses;
  }
  
}