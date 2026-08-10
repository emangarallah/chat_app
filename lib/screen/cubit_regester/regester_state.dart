import 'package:meta/meta.dart';

@immutable
sealed class RegesterState{
  const RegesterState();
}


final class RegesterInitial extends RegesterState {
  const RegesterInitial();
}

final class RegesterStateLoading  extends RegesterState {
  const  RegesterStateLoading();
}

final class RegesterSuccess extends RegesterState {
  final String email;
  const  RegesterSuccess({required this.email});
}

final class RegesterFailure extends RegesterState{
  final String errorMessage;
  const RegesterFailure({required this.errorMessage});
}