import 'package:exammer/constants.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          "no_internet_connection": "Please check your Internet connection",
          "name": "Name",
          "email_address": "Email address",
          "email_phone": "Email/Phone",
          "phone_number": "Phone number",
          "password": "Password",
          "confirm_password": "Confirm password",
          "old_password": "Old password",
          "new_password": "New password",
          "confirm_new_password": "Confirm new password",
          "sign_in": "Sign in",
          "sign_up": "Sign up",
          "terms_and_conditions": "Terms & Conditions",
          "forgot_password": "Forgot password?",
          "done": "Done",
          "skip": "Skip",
          "see_all": "See All",
          "handle_not_found": "Handle not found",
          "invalid_email": "Invalid email address found",
          "invalid_phone": "Invalid phone number found",
          "fill_up_all_fields": "Please fill up all the fields",
          "fill_up_the_field": "Please fill up the field",
          "valid_email_phone_required": "Please enter a valid email/phone",
          "passwords_do_not_match": "Passwords do not match",
          "code_length_required":
              "Verification code should contain $minimumVerificationCodeLength characters",
          "minimum_password_length_required":
              "Password should contain at least $minimumPasswordLength characters",
          "splash_title": "Exammer",
          "registration_title": "Create an account",
          "registration_subtitle":
              "Sign up with your email and password or social media to continue",
          "registration_get_started": "Get started",
          "registration_already_have_account": "Already have an account? ",
          "registration_or_continue_with": "Or Continue with",
          "registration_you_agree_to_our_policy":
              "By signing up, you agree to our ",
          "registration_error": "Failed to register",
          "login_title_part_1": "Welcome, ",
          "login_title_part_2": "Tekkans!",
          "login_subtitle":
              "Sign in with your email and password or social media to continue",
          "login_do_not_have_account": "Don't have an account? ",
          "login_register": "Register",
          "login_you_agree_to_our_policy": "By signing in, you agree to our ",
          "login_error": "Failed to log in",
          "verification_title": "Verification",
          "verification_subtitle":
              "Check your messages. We've sent you the OTP at ",
          "verification_bottom_line_part_1": "Didn't receive SMS? ",
          "verification_bottom_line_part_2": "Resend Code",
          "verification_error": "Failed to verify",
          "survey_top_title": "What do you want to prepare for?",
          "survey_middle_title": "How much time do you have for preparation?",
          "survey_bottom_title": "What are you currently doing?",
          "survey_failed_to_submit": "Failed to submit the preferences",
          "survey_select_all": "Please select all the preferences",
          "survey_select_category": "Please select a training category",
          "survey_select_time": "Please select a suitable time length",
          "survey_select_profession": "Please select your current profession",
          "home_customer_feedback": "Customer Feedback",
          "home_expert_picks": "Expert Picks",
          "home_trending_courses": "Trending Courses",
          "home": "Home",
          "practice": "Practice",
          "competition": "Competition",
          "courses": "Courses",
          "jobs": "Jobs",
        },
      };
}