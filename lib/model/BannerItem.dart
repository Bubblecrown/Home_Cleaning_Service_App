// import 'package:meta/meta.dart';

// @immutable
// class Banner {
//   final String image;

//   Banner(this.task, {this.complete = false, String note = '', String id})
//       : this.note = note ?? '',
//         this.id = id;

//   Banner copyWith({bool complete, String id, String note, String task}) {
//     return Banner(
//       task ?? this.task,
//       complete: complete ?? this.complete,
//       id: id ?? this.id,
//       note: note ?? this.note,
//     );
//   }

//   @override
//   int get hashCode =>
//       complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Banner &&
//           runtimeType == other.runtimeType &&
//           complete == other.complete &&
//           task == other.task &&
//           note == other.note &&
//           id == other.id;

//   @override
//   String toString() {
//     return 'Banner { complete: $complete, task: $task, note: $note, id: $id }';
//   }

//   TodoEntity toEntity() {
//     return TodoEntity(task, id, note, complete);
//   }

//   static Todo fromEntity(TodoEntity entity) {
//     return Todo(
//       entity.task,
//       complete: entity.complete ?? false,
//       note: entity.note,
//       id: entity.id,
//     );
//   }
// }