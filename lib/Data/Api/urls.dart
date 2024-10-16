import '../../Utils/dependency_injection.dart';

abstract class TRAINEEURLS {
  static String completeDay = '$userBaseUrl/completeDay';

}

abstract class TRAINERURLS {

  static String trainerPorile = '$trainerBaseUrl/profile';


  static String getYourTrainer = '$trainerBaseUrl/trainers';
  static String getTrainerPrivateSession = '$trainerBaseUrl/wallet';
  static String plans = '$trainerBaseUrl/plans/ourPlans';

  static String trainerPlans = '$trainerBaseUrl/plans/myPlans';
}
