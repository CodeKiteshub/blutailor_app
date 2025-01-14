part of 'body_profile_cubit.dart';

final class BodyProfileState {
final BodyProfileStatus status;
  final BodyProfileEntity? bodyProfile;

  BodyProfileState({required this.status, this.bodyProfile});
}


enum BodyProfileStatus { initial, loading, loaded, error, saved, imgError }