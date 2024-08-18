
class FirebaseChatCoreConfig {
  const FirebaseChatCoreConfig(
    this.firebaseAppName,
    this.roomsCollectionName,
    this.usersCollectionName,
  );

  /// Property to set custom firebase app name.
  final String? firebaseAppName;

  /// Property to set rooms collection name.
  final String roomsCollectionName;

  /// Property to set users collection name.
  final String usersCollectionName;
}
