
import '../../Utils/dependency_injection.dart';

abstract class TRAINEEURLS {
  static const traineeSignup = '$userBaseUrl/auth/register';
  static const submitUserOTP = '$userBaseUrl/auth/confirmAccount';
  static const submitForgetPasswordOtp =
      '$userBaseUrl/auth/resetPassword/checkCode';
  static const setNewPassword =
      '$userBaseUrl/auth/resetPassword/changePassword';
  static const resendOTP = '$userBaseUrl/auth/resendConfirmationCode';
  static const traineeLogin = '$userBaseUrl/auth/login';
  static const traineeAuthenticationByGoogleAccount =
      '$userBaseUrl/auth/social_login';
  static const traineeLogout = '$userBaseUrl/auth/logout';
  static const forgetPassword = '$userBaseUrl/auth/resetPassword';
  static const plans = '$userBaseUrl/plans?page=';
  static const getUserSubscribedPlans = '$userBaseUrl/userSubscribedPlans';
  static const getTrendingPlns = '$userBaseUrl/plans/trending';
  static const getFeaturedPlans = '$userBaseUrl/plans/featured';
  static const getOurPlans = '$userBaseUrl/plans/ourPlans';
  static const getPlanById = '$userBaseUrl/plans/';
  static const getYourTrainer = '$userBaseUrl/trainers?page=';
  static const getTrainerById = '$userBaseUrl/trainers/';
  static const subscribeToPlan = '$userBaseUrl/subscribeToPlan';
  static const completeDay = '$userBaseUrl/completeDay';

  static const filter = '$userBaseUrl/plans';
  static const subscribePaymentPlan = '$userBaseUrl/subscriptions';
  static const confirmSubscription = '$userBaseUrl/subscriptions/confirm';
  static const cancelSubscription = '$userBaseUrl/subscriptions/cancel';

  static const subscribtionPay = '$userBaseUrl/subscriptions/pay';
  static const survey = '$userBaseUrl/fitness-survey';
  static const getUserProfile = '$userBaseUrl/profile';
  static const saveFcm = '$userBaseUrl/notifications/storeFcmToken';
  static const getCurrentWorkouts = '$userBaseUrl/currentWorkout';
  static const getBookmarkPlan = '$userBaseUrl/plans/bookmarked';
  static const getMyPayment = '$userBaseUrl/myPayments';
  static const getMyPaymentPrivateSession =
      '$userBaseUrl/myAppointmentWithTrainer';
  static const allChats = '$userBaseUrl/chats';
  static const allNotifications = '$userBaseUrl/notifications';
  static const restAllNotification = '$userBaseUrl/notifications/resetCount';
  static const bookedAppointments = '$userBaseUrl/bookedAppointments';
  static const getTrainingType = '$userBaseUrl/plans/types';

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
  static const getWorkoutsByPlanId = '$userBaseUrl/plans/';

  // add exercises after id
  static const getExerciesByWorkoutId = '$userBaseUrl/workouts/';
  static const getTraineeProgress = '$userBaseUrl/myProgress';
}

abstract class TRAINERURLS {
  static const getExerciesByWorkoutId = '$trainerBaseUrl/workouts/';
  static const getWorkoutsByPlanId = '$trainerBaseUrl/plans/';
  static const restAllNotification = '$trainerBaseUrl/notifications/resetCount';
  static const trainerSignup = '$trainerBaseUrl/auth/register';
  static const submitOTP = '$trainerBaseUrl/auth/confirmAccount';
  static const trainerLogin = '$trainerBaseUrl/auth/login';
  static const logout = '$trainerBaseUrl/auth/logout';
  static const trainerPorile = '$trainerBaseUrl/profile';
  static const trainerAvailableTime = '$trainerBaseUrl/availableTimes';
  static const getTrendingPlns = '$trainerBaseUrl/plans/trending';
  static const getOurPlans = '$trainerBaseUrl/plans/ourPlans';

  static String getConversation(String channelId) =>
      '$trainerBaseUrl/chats/$channelId';

  static String sendMessageToCustomerService() =>
      '$trainerBaseUrl/supportChat/sendMessage';

  static String sendMessage(String channelId) =>
      '$trainerBaseUrl/chats/$channelId/sendMessage';

  static const allChatsTrainer = '$trainerBaseUrl/chats';

  static const getPlanById = '$trainerBaseUrl/plans/';

  static const allNotifications = '$trainerBaseUrl/notifications';

  static const getMyPlans =
      '$trainerBaseUrl/plans/myPlans?training_level[0]=Beginner';
  static const getYourTrainer = '$trainerBaseUrl/trainers';
  static const getTrainerPrivateSession = '$trainerBaseUrl/wallet';
  static const plans = '$trainerBaseUrl/plans/ourPlans';

  static const trainerPlans = '$trainerBaseUrl/plans/myPlans';
}
