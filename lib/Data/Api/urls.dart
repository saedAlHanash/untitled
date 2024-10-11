import '../../Utils/dependency_injection.dart';

abstract class TRAINEEURLS {

  static String setNewPassword =
      '$userBaseUrl/auth/resetPassword/changePassword';
  static String resendOTP = '$userBaseUrl/auth/resendConfirmationCode';
  static String traineeLogin = '$userBaseUrl/auth/login';
  static String traineeAuthenticationByGoogleAccount =
      '$userBaseUrl/auth/social_login';
  static String traineeLogout = '$userBaseUrl/auth/logout';
  static String forgetPassword = '$userBaseUrl/auth/resetPassword';
  static String plans = '$userBaseUrl/plans?page=';
  static String getUserSubscribedPlans = '$userBaseUrl/userSubscribedPlans';
  static String getTrendingPlns = '$userBaseUrl/plans/trending';
  static String getFeaturedPlans = '$userBaseUrl/plans/featured';
  static String getOurPlans = '$userBaseUrl/plans/ourPlans';
  static String getPlanById = '$userBaseUrl/plans/';
  static String getYourTrainer = '$userBaseUrl/trainers';
  static String getTrainerById = '$userBaseUrl/trainers/';
  static String completeDay = '$userBaseUrl/completeDay';

  static String filter = '$userBaseUrl/plans';
  static String subscribePaymentPlan = '$userBaseUrl/subscriptions';
  static String confirmSubscription = '$userBaseUrl/subscriptions/confirm';
  static String cancelSubscription = '$userBaseUrl/subscriptions/cancel';

  static String subscribtionPay = '$userBaseUrl/subscriptions/pay';
  static String survey = '$userBaseUrl/fitness-survey';
  static String getUserProfile = '$userBaseUrl/profile';
  static String saveFcm = '$userBaseUrl/notifications/storeFcmToken';
  static String getCurrentWorkouts = '$userBaseUrl/currentWorkout';
  static String getBookmarkPlan = '$userBaseUrl/plans/bookmarked';
  static String getMyPayment = '$userBaseUrl/myPayments';
  static String getMyPaymentPrivateSession =
      '$userBaseUrl/myAppointmentWithTrainer';
  static String allChats = '$userBaseUrl/chats';
  static String allNotifications = '$userBaseUrl/notifications';
  static String restAllNotification = '$userBaseUrl/notifications/resetCount';
  static String bookedAppointments = '$userBaseUrl/bookedAppointments';
  static String getTrainingType = '$userBaseUrl/plans/types';

  static String getConversation(String channelId) =>
      '$userBaseUrl/chats/$channelId';

  static String getConversationCustomerService() => '$userBaseUrl/supportChat';

  static String getTrainerPlans(String id) => '$userBaseUrl/trainers/$id/plans';

  static String addToBookmark(String id) =>
      '$userBaseUrl/plans/$id/addToBookmarkedPlans';

  static String removeFromBookMarked(String id) =>
      '$userBaseUrl/plans/$id/deleteFromBookmarkedPlans';

  static String sendMessage(String channelId) =>
      '$userBaseUrl/chats/$channelId/sendMessage';

  static String sendMessageToCustomerService() =>
      '$userBaseUrl/supportChat/sendMessage';

  static String getTrainerAvailableTime(String trainerId) =>
      '$userBaseUrl/trainers/$trainerId/availableTimes';

  //add Workout after id
  static String getWorkoutsByPlanId = '$userBaseUrl/plans/';

  // add exercises after id
  static String getExerciesByWorkoutId = '$userBaseUrl/workouts/';
  static String getTraineeProgress = '$userBaseUrl/myProgress';
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
  static String getTrendingPlns = '$trainerBaseUrl/plans/trending';


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
