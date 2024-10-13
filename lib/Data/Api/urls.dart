import '../../Utils/dependency_injection.dart';

abstract class TRAINEEURLS {

  static String plans = '$userBaseUrl/plans?page=';

  static String getTrainerById = '$userBaseUrl/trainers/';
  static String completeDay = '$userBaseUrl/completeDay';
  static String filter = '$userBaseUrl/plans';
  static String subscribePaymentPlan = '$userBaseUrl/subscriptions';
  static String cancelSubscription = '$userBaseUrl/subscriptions/cancel';
  static String subscribtionPay = '$userBaseUrl/subscriptions/pay';
  static String getTrainerPlans(String id) => '$userBaseUrl/trainers/$id/plans';

}

abstract class TRAINERURLS {
  static String getExerciesByWorkoutId = '$trainerBaseUrl/workouts/';
  static String getWorkoutsByPlanId = '$trainerBaseUrl/plans/';
  static String restAllNotification =
      '$trainerBaseUrl/notifications/resetCount';
  static String trainerSignup = '$trainerBaseUrl/auth/register';
  static String submitOTP = '$trainerBaseUrl/auth/confirmAccount';
  static String trainerLogin = '$trainerBaseUrl/auth/login';
  static String logout = '$trainerBaseUrl/auth/logout';
  static String trainerPorile = '$trainerBaseUrl/profile';
  static String trainerAvailableTime = '$trainerBaseUrl/availableTimes';



  static String getConversation(String channelId) =>
      '$trainerBaseUrl/chats/$channelId';

  static String sendMessageToCustomerService() =>
      '$trainerBaseUrl/supportChat/sendMessage';

  static String sendMessage(String channelId) =>
      '$trainerBaseUrl/chats/$channelId/sendMessage';

  static String allChatsTrainer = '$trainerBaseUrl/chats';

  static String getPlanById = '$trainerBaseUrl/plans/';

  static String allNotifications = '$trainerBaseUrl/notifications';

  static String getMyPlans =
      '$trainerBaseUrl/plans/myPlans?training_level[0]=Beginner';
  static String getYourTrainer = '$trainerBaseUrl/trainers';
  static String getTrainerPrivateSession = '$trainerBaseUrl/payments_cubit';
  static String plans = '$trainerBaseUrl/plans/ourPlans';

  static String trainerPlans = '$trainerBaseUrl/plans/myPlans';
}
