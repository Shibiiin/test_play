import 'package:untitled/entities/task_modal.dart';

class AssignedModal extends TaskModal {
  final String subContent;

  AssignedModal({
    required int iD,
    required int status,
    required String content,
    required this.subContent,
  }) : super(iD: iD, status: status, content: content);
}
