// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_new_code_bloc.dart';

class AddNewCodeState extends Equatable {
  final String name;
  final XFile? fileImage;

  const AddNewCodeState({
    this.name = "",
    this.fileImage,
  });
  @override
  List<Object?> get props => [
        name,
        fileImage,
      ];

  AddNewCodeState copyWith({
    String? name,
    XFile? fileImage,
  }) {
    return AddNewCodeState(
      name: name ?? this.name,
      fileImage: fileImage ?? this.fileImage,
    );
  }
}
