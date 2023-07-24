import '../../Utils/Constants/constants.dart';

abstract class TRAINEEURLS {
  static const String traineeSignup = '${Constants.userBaseUrl}/auth/register';
  static const String submitUserOTP =
      '${Constants.userBaseUrl}/auth/confirmAccount';
  static const String submitForgetPasswordOtp =
      '${Constants.userBaseUrl}/auth/resetPassword/checkCode';
  static const String setNewPassword =
      '${Constants.userBaseUrl}/auth/resetPassword/changePassword';
  static const String resendOTP =
      '${Constants.userBaseUrl}/auth/resendConfirmationCode';
  static const String traineeLogin = '${Constants.userBaseUrl}/auth/login';
  static const String traineeAuthenticationByGoogleAccount =
      '${Constants.userBaseUrl}/auth/social_login';
  static const String traineeLogout = '${Constants.userBaseUrl}/auth/logout';
  static const String forgetPassword =
      '${Constants.userBaseUrl}/auth/resetPassword';
  static const String plans = '${Constants.userBaseUrl}/plans?page=';
  static const String getUserSubscribedPlans =
      '${Constants.userBaseUrl}/userSubscribedPlans';
  static const String getTrendingPlns =
      '${Constants.userBaseUrl}/plans/trending';
  static const String getFeaturedPlans =
      '${Constants.userBaseUrl}/plans/featured';
  static const String getOurPlans = '${Constants.userBaseUrl}/plans/ourPlans';
  static const String getPlanById = '${Constants.userBaseUrl}/plans/';
  static const String getYourTrainer =
      '${Constants.userBaseUrl}/trainers?page=';
  static const String getTrainerById = '${Constants.userBaseUrl}/trainers/';
  static const String subscribeToPlan =
      '${Constants.userBaseUrl}/subscribeToPlan';
  static const String completeDay = '${Constants.userBaseUrl}/completeDay';
  static const String refeshUserToken =
      '${Constants.userBaseUrl}/auth/refreshToken';
  static const String filter = '${Constants.userBaseUrl}/plans';
  static const String subscribePaymentPlan =
      '${Constants.userBaseUrl}/subscriptions';
  static const String confirmSubscription =
      '${Constants.userBaseUrl}/subscriptions/confirm';
  static const String cancelSubscription =
      '${Constants.userBaseUrl}/subscriptions/cancel';

  static const String subscribtionPay =
      '${Constants.userBaseUrl}/subscriptions/pay';
  static const String survey = '${Constants.userBaseUrl}/fitness-survey';
  static const String getUserProfile = '${Constants.userBaseUrl}/profile';
  static const String saveFcm =
      '${Constants.userBaseUrl}/notifications/storeFcmToken';
  static const String getCurrentWorkouts =
      '${Constants.userBaseUrl}/currentWorkout';
  static const String getBookmarkPlan =
      '${Constants.userBaseUrl}/plans/bookmarked';
  static const String getMyPayment = '${Constants.userBaseUrl}/myPayments';
  static const String getMyPaymentPrivateSession = '${Constants
      .userBaseUrl}/myAppointmentWithTrainer';
  static const String allChats = '${Constants.userBaseUrl}/chats';
  static const String allNotifications =
      '${Constants.userBaseUrl}/notifications';
  static const String restAllNotification =
      '${Constants.userBaseUrl}/notifications/resetCount';
  static const String bookedAppointments =
      '${Constants.userBaseUrl}/bookedAppointments';
  static const String getTrainingType = '${Constants.userBaseUrl}/plans/types';

  static String getConversation(String channelId) =>
      '${Constants.userBaseUrl}/chats/$channelId';

  static String getConversationCustomerService() =>
      '${Constants.userBaseUrl}/supportChat';

  static String getTrainerPlans(String id) =>
      '${Constants.userBaseUrl}/trainers/$id/plans';

  static String addToBookmark(String id) =>
      '${Constants.userBaseUrl}/plans/$id/addToBookmarkedPlans';

  static String removeFromBookMarked(String id) =>
      '${Constants.userBaseUrl}/plans/$id/deleteFromBookmarkedPlans';

  static String sendMessage(String channelId) =>
      '${Constants.userBaseUrl}/chats/$channelId/sendMessage';

  static String sendMessageToCustomerService() =>
      '${Constants.userBaseUrl}/supportChat/sendMessage';

  static String getTrainerAvailableTime(String trainerId) =>
      '${Constants.userBaseUrl}/trainers/$trainerId/availableTimes';

  //add Workout after id
  static const String getWorkoutsByPlanId = '${Constants.userBaseUrl}/plans/';

  // add exercises after id
  static const String getExerciesByWorkoutId =
      '${Constants.userBaseUrl}/workouts/';
  static const String getTraineeProgress =
      '${Constants.userBaseUrl}/myProgress';
}

abstract class TRAINERURLS {
  static const String getExerciesByWorkoutId =
      '${Constants.trainerBaseUrl}/workouts/';
  static const String getWorkoutsByPlanId =
      '${Constants.trainerBaseUrl}/plans/';
  static const String restAllNotification =
      '${Constants.trainerBaseUrl}/notifications/resetCount';
  static const String trainerSignup =
      '${Constants.trainerBaseUrl}/auth/register';
  static const String submitOTP =
      '${Constants.trainerBaseUrl}/auth/confirmAccount';
  static const String trainerLogin = '${Constants.trainerBaseUrl}/auth/login';
  static const String refreshTrainerToken =
      '${Constants.trainerBaseUrl}/auth/refreshToken';
  static const String logout = '${Constants.trainerBaseUrl}/auth/logout';
  static const String trainerPorile = '${Constants.trainerBaseUrl}/profile';
  static const String trainerAvailableTime =
      '${Constants.trainerBaseUrl}/availableTimes';
  static const String getTrendingPlns =
      '${Constants.trainerBaseUrl}/plans/trending';
  static const String getOurPlans =
      '${Constants.trainerBaseUrl}/plans/ourPlans';

  static String getConversation(String channelId) =>
      '${Constants.trainerBaseUrl}/chats/$channelId';

  static String sendMessageToCustomerService() =>
      '${Constants.trainerBaseUrl}/supportChat/sendMessage';

  static String sendMessage(String channelId) =>
      '${Constants.trainerBaseUrl}/chats/$channelId/sendMessage';

  static const String allChatsTrainer = '${Constants.trainerBaseUrl}/chats';

  static const String getPlanById = '${Constants.trainerBaseUrl}/plans/';

  static const String allNotifications =
      '${Constants.trainerBaseUrl}/notifications';

  static const String getMyPlans =
      '${Constants.trainerBaseUrl}/plans/myPlans?training_level[0]=Beginner';
  static const String getYourTrainer = '${Constants.trainerBaseUrl}/trainers';
  static const String getTrainerPrivateSession =
      '${Constants.trainerBaseUrl}/wallet';
  static const String plans = '${Constants.trainerBaseUrl}/plans/ourPlans';

  static const String trainerPlans =
      '${Constants.trainerBaseUrl}/plans/myPlans';
}
