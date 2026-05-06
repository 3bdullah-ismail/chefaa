abstract class ProfileLocalDataSource {
  Future<String> getUserName();

  Future<String> getUserEmail();

  Future<String> getUserPhoneNumber();

  Future<String> getUserAddress();
}
