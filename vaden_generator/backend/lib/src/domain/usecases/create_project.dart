import 'dart:io';

import 'package:backend/src/domain/dtos/project_link_dto.dart';
import 'package:backend/src/domain/entities/project.dart';
import 'package:backend/src/domain/services/generate_service.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Component()
class CreateProject {
  final GenerateService _generateService;

  CreateProject(this._generateService);

  AsyncResult<ProjectLinkDTO> call(Project project) async {
    final temp = Directory('uploads${Platform.pathSeparator}temp');
    return _generateService //
        .createTempProject(project, temp)
        .flatMap(_generateService.addDependencies)
        .flatMap(_generateService.createZipLink);
  }
}
