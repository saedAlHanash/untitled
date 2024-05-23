import '../../Utils/Constants/constants.dart';

abstract class TRAINEEURLS {
  static const traineeSignup = '${Constants.userBaseUrl}/auth/register';
  static const submitUserOTP = '${Constants.userBaseUrl}/auth/confirmAccount';
  static const submitForgetPasswordOtp =
      '${Constants.userBaseUrl}/auth/resetPassword/checkCode';
  static const setNewPassword =
      '${Constants.userBaseUrl}/auth/resetPassword/changePassword';
  static const resendOTP =
      '${Constants.userBaseUrl}/auth/resendConfirmationCode';
  static const traineeLogin = '${Constants.userBaseUrl}/auth/login';
  static const traineeAuthenticationByGoogleAccount =
      '${Constants.userBaseUrl}/auth/social_login';
  static const traineeLogout = '${Constants.userBaseUrl}/auth/logout';
  static const forgetPassword = '${Constants.userBaseUrl}/auth/resetPassword';
  static const plans = '${Constants.userBaseUrl}/plans?page=';
  static const getUserSubscribedPlans =
      '${Constants.userBaseUrl}/userSubscribedPlans';
  static const getTrendingPlns = '${Constants.userBaseUrl}/plans/trending';
  static const getFeaturedPlans = '${Constants.userBaseUrl}/plans/featured';
  static const getOurPlans = '${Constants.userBaseUrl}/plans/ourPlans';
  static const getPlanById = '${Constants.userBaseUrl}/plans/';
  static const getYourTrainer = '${Constants.userBaseUrl}/trainers?page=';
  static const getTrainerById = '${Constants.userBaseUrl}/trainers/';
  static const subscribeToPlan = '${Constants.userBaseUrl}/subscribeToPlan';
  static const completeDay = '${Constants.userBaseUrl}/completeDay';

  static const filter = '${Constants.userBaseUrl}/plans';
  static const subscribePaymentPlan = '${Constants.userBaseUrl}/subscriptions';
  static const confirmSubscription =
      '${Constants.userBaseUrl}/subscriptions/confirm';
  static const cancelSubscription =
      '${Constants.userBaseUrl}/subscriptions/cancel';

  static const subscribtionPay = '${Constants.userBaseUrl}/subscriptions/pay';
  static const survey = '${Constants.userBaseUrl}/fitness-survey';
  static const getUserProfile = '${Constants.userBaseUrl}/profile';
  static const saveFcm = '${Constants.userBaseUrl}/notifications/storeFcmToken';
  static const getCurrentWorkouts = '${Constants.userBaseUrl}/currentWorkout';
  static const getBookmarkPlan = '${Constants.userBaseUrl}/plans/bookmarked';
  static const getMyPayment = '${Constants.userBaseUrl}/myPayments';
  static const getMyPaymentPrivateSession =
      '${Constants.userBaseUrl}/myAppointmentWithTrainer';
  static const allChats = '${Constants.userBaseUrl}/chats';
  static const allNotifications = '${Constants.userBaseUrl}/notifications';
  static const restAllNotification =
      '${Constants.userBaseUrl}/notifications/resetCount';
  static const bookedAppointments =
      '${Constants.userBaseUrl}/bookedAppointments';
  static const getTrainingType = '${Constants.userBaseUrl}/plans/types';

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
  static const getWorkoutsByPlanId = '${Constants.userBaseUrl}/plans/';

  // add exercises after id
  static const getExerciesByWorkoutId = '${Constants.userBaseUrl}/workouts/';
  static const getTraineeProgress = '${Constants.userBaseUrl}/myProgress';
}

abstract class TRAINERURLS {
  static const getExerciesByWorkoutId = '${Constants.trainerBaseUrl}/workouts/';
  static const getWorkoutsByPlanId = '${Constants.trainerBaseUrl}/plans/';
  static const restAllNotification =
      '${Constants.trainerBaseUrl}/notifications/resetCount';
  static const trainerSignup = '${Constants.trainerBaseUrl}/auth/register';
  static const submitOTP = '${Constants.trainerBaseUrl}/auth/confirmAccount';
  static const trainerLogin = '${Constants.trainerBaseUrl}/auth/login';
  static const logout = '${Constants.trainerBaseUrl}/auth/logout';
  static const trainerPorile = '${Constants.trainerBaseUrl}/profile';
  static const trainerAvailableTime =
      '${Constants.trainerBaseUrl}/availableTimes';
  static const getTrendingPlns = '${Constants.trainerBaseUrl}/plans/trending';
  static const getOurPlans = '${Constants.trainerBaseUrl}/plans/ourPlans';

  static String getConversation(String channelId) =>
      '${Constants.trainerBaseUrl}/chats/$channelId';

  static String sendMessageToCustomerService() =>
      '${Constants.trainerBaseUrl}/supportChat/sendMessage';

  static String sendMessage(String channelId) =>
      '${Constants.trainerBaseUrl}/chats/$channelId/sendMessage';

  static const allChatsTrainer = '${Constants.trainerBaseUrl}/chats';

  static const getPlanById = '${Constants.trainerBaseUrl}/plans/';

  static const allNotifications = '${Constants.trainerBaseUrl}/notifications';

  static const getMyPlans =
      '${Constants.trainerBaseUrl}/plans/myPlans?training_level[0]=Beginner';
  static const getYourTrainer = '${Constants.trainerBaseUrl}/trainers';
  static const getTrainerPrivateSession = '${Constants.trainerBaseUrl}/wallet';
  static const plans = '${Constants.trainerBaseUrl}/plans/ourPlans';

  static const trainerPlans = '${Constants.trainerBaseUrl}/plans/myPlans';
}
