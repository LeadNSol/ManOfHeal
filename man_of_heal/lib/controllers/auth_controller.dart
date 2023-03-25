import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';
import 'package:man_of_heal/ui/export_ui.dart';
import 'package:man_of_heal/utils/export_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {

  var editTextFieldController = TextEditingController();

  //this is edittext controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController degreeProgramController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  //Rx<User?> firebaseUser = Rx<User?>(firebaseAuth.currentUser);

  // Rx<UserModel> userModel = UserModel().obs;
  // final RxBool admin = false.obs;
  // final RxBool isLoggedIn = false.obs;

  Rxn<User?> firebaseUser = Rxn<User?>();

  var _userModel = UserModel().obs;

  UserModel? get userModel => _userModel.value;

  final RxBool admin = false.obs;
  var isSignedInWithGoogle = false.obs;

  /// checking if google signed in user is registered with DB
  var isUserSignedUp = false.obs;

  /// btn state for progressive bar indicator
  ///  0 for default
  ///  1 for progressing
  ///  2. for done state.
  var _btnState = 0.obs;

  int? get btnState => _btnState.value;

  setBtnState(int value) {
    _btnState.value = value;
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => firebaseAuth.currentUser!;

  // Firebase user a realtime stream
  //Stream<User?> get user => firebaseAuth.authStateChanges();

  final GoogleSignIn? _googleSignIn = GoogleSignIn();

  ///Profile Avatars.
  var profileAvatarsList = <ProfileAvatars>[].obs;
  var usersList = <UserModel>[].obs;

  late AnimationController animationController;

  @override
  void onInit() {
    // TOO: implement onInit
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      //duration: Duration(seconds: 2),
    ); //..forward();
    /*animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        Get.offNamed('/welcome');
      }
    });*/
  }

  late SharedPreferences? sharedPref;

  @override
  void onReady() async {
    sharedPref = await SharedPreferences.getInstance();
    //run every time auth state changes
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, handleAuthChanged);



    profileAvatarsList.bindStream(getProfileAvatars());
    usersList.bindStream(getAllUsers());

    ever(usersList, pickAdmins);

    //handleAuthChanged();
    super.onReady();
  }

  setIsTrialDialogFirstTimeOpen(bool? value) {
    sharedPref!.setBool(TRIAL_DIALOG, value!);
  }

  isTrailDialogFirstTimeOpen() => sharedPref!.getBool(TRIAL_DIALOG);

  @override
  void onClose() {
    _clearControllers();
    _disposeControllers();

    super.onClose();
  }

  setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String userId = firebaseAuth.currentUser!.uid;

    await FirebaseFirestore.instance.collection(USERS).doc(userId).set({
      UserModel.USER_TOKEN: token
    }, SetOptions(merge: true)).whenComplete(
        () => print("Notifications: token created! $token"));
  }

  var adminUsersList = [].obs;

  void pickAdmins(List<UserModel>? usersList) {
    adminUsersList.clear();
    if (usersList!.isNotEmpty) {
      usersList.forEach((element) {
        if (element.isAdmin!) {
          adminUsersList.add(element);
        }
      });
    }
    adminUsersList.refresh();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      /// Notification token setup
      setupToken();
      _userModel.bindStream(streamFirestoreUser());
      await isAdmin();
    }

    if (_firebaseUser == null) {
      print('Send to sign in');
      //Get.offAll(() => WelcomeBackUI());
      Get.offNamed(AppRoutes.welcomeRoute);
    } else {
      if (admin.value) {
        if (!kIsWeb) {
          FirebaseMessaging.instance
              .subscribeToTopic(NotificationEnum.qa_admin.name);
        }
        Get.offNamed(AppRoutes.adminDashboard);
      } else {
        if (!kIsWeb) {
          FirebaseMessaging.instance
              .subscribeToTopic(NotificationEnum.labs.name);
          FirebaseMessaging.instance
              .subscribeToTopic(NotificationEnum.quiz.name);
          FirebaseMessaging.instance
              .subscribeToTopic(NotificationEnum.daily_activity.name);
        }
        //Get.offAll(() => StudentHome());
        Get.offNamed(AppRoutes.stdDashboard);
      }
    }
  }
  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    var uid = firebaseUser.value != null ? firebaseUser.value?.uid : null;
    print('streamFirestoreUser() UID: $uid');

    return firebaseFirestore
        .collection(USERS)
        .doc(uid)
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  Stream<List<UserModel>> getAllUsers() {
    return firebaseFirestore
        .collection(USERS)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              if (e.exists) {
                if (!e.data().containsKey(UserModel.USER_TOKEN)) {
                  return UserModel.fromMap(e.data());
                }
              }
              return UserModel.fromMap(e.data());
            }).toList());
  }

  UserModel? getAdminFromListById(String id) {
    return adminUsersList.isNotEmpty
        ? adminUsersList.firstWhere((element) => element.uid == id)
        : UserModel();
  }

  UserModel? getUserFromListById(String id) {
    return usersList.isNotEmpty
        ? usersList.firstWhere((element) => element.uid == id,
            orElse: () => UserModel())
        : UserModel();
  }

  Future<UserModel> getUserById(String id) async {
    return await firebaseFirestore
        .collection(USERS)
        .doc(id)
        .get()
        .then((DocumentSnapshot snap) => UserModel.fromDoc(snap.data()));
  }

  //Method to handle user sign in using email and password
  signIn() async {
    //showLoadingIndicator(isModal: true);
    setBtnState(1);
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        //retrying to reload all controllers
        //Get.reload(force: true);

        setBtnState(2);
        _clearControllers();

        //hideLoadingIndicator();
        AppConstant.displaySuccessSnackBar(
            "Sign In Alert!", "Logged in Successfully!");
        //setBtnState(0);
        //_initControllers();
      }); /*.catchError((e){
        signUpInstructor();
      });*/
    } catch (error) {
      setBtnState(0);
      //hideLoadingIndicator();
      AppConstant.displaySnackBar(
          'Sign In Error', 'Login failed: email or password incorrect.');
    }
  }

  singInWithGoogle() async {
    isSignedInWithGoogle.value = true;

    final GoogleSignInAccount? googleUser = await _googleSignIn!.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((UserCredential user) async {
      print("Gmail CAlled");
      //_initControllers();
      //retrying to reload all controllers
      if (user.additionalUserInfo!.isNewUser) {
        Timestamp trailExpiry =
            Timestamp.fromDate(DateTime.now().add(new Duration(days: 7)));
        UserModel newGoogleUser = UserModel(
          uid: user.user!.uid,
          name: user.user!.displayName,
          phone: user.user!.phoneNumber ?? "not not found!",
          address: "No Address found!",
          email: user.user!.email,
          userType: UserGroup.student.name,
          photoUrl: user.user!.photoURL ?? DEFAULT_IMAGE_URL,
          isAdmin: false,
          isTrailFinished: false,
          trialExpiryDate: trailExpiry,
          createdDate: Timestamp.now(),
          degreeProgram: null,
        );
        _createUserFirestore(newGoogleUser, user.user!);
      }
    });
  }

  // User registration using email and password
  signUp() async {
    // showLoadingIndicator();
    setBtnState(1);
    try {
      Timestamp trailExpiry =
          Timestamp.fromDate(DateTime.now().add(new Duration(days: 7)));
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) async {
        //firebaseAuth.currentUser!.unlink(result.user!.uid);

        //create the new user object
        UserModel _newUser = UserModel(
            uid: result.user!.uid,
            email: result.user!.email!,
            name: nameController.text,
            createdDate: Timestamp.now(),
            phone: phoneController.text,
            userType: UserGroup.student.name,
            photoUrl: DEFAULT_IMAGE_URL,
            degreeProgram: degreeProgramController.text,
            address: addressController.text,
            isTrailFinished: false,
            trialExpiryDate: trailExpiry,
            isAdmin: false);
        //create the user in firestore
        _createUserFirestore(_newUser, result.user!);

        //hideLoadingIndicator();
      });
    } on FirebaseAuthException catch (error) {
      //hideLoadingIndicator();
      setBtnState(0);
      Get.snackbar(
        'Sign Up Failed.',
        error.message!,
        duration: Duration(seconds: 10),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppThemes.DEEP_ORANGE,
        colorText: AppThemes.white,
      );
    }
  }

  //create the firestore user in users collection
  Future<void> _createUserFirestore(UserModel user, User _firebaseUser) async {
    print("user entered=" + _firebaseUser.uid);
    await firebaseFirestore
        .collection(USERS)
        .doc(_firebaseUser.uid)
        .set(user.toJson())
        .whenComplete(
      () {
        setBtnState(2);
        _clearControllers();
        AppConstant.displaySuccessSnackBar(
            "Success", "User was registered successfully!");
      },
    ).onError((error, stackTrace) => {setBtnState(0)});
  }

  //check if user is an admin user
  isAdmin() async {
    await getUser.then((user) async {
      await firebaseFirestore
          .collection(USERS)
          .doc(user.uid)
          .get()
          .then((value) {
        if (value.exists && value['isAdmin']) {
          admin.value = true;
        } else {
          admin.value = false;
        }
      });

      //update();
    });
  }

  findUserInDB() async {
    debugPrint("findUserInDB()");
    await getUser.then((user) async {
      await firebaseFirestore
          .collection(USERS)
          .doc(user.uid)
          .get()
          .then((value) {
        if (value.exists) {
          isUserSignedUp.value = true;
        } else {
          isUserSignedUp.value = false;
        }
      });

      //update();
    });
  }

  //password reset email
  Future<void> sendPasswordResetEmail(BuildContext context) async {
    //showLoadingIndicator();
    try {
      await firebaseAuth.sendPasswordResetEmail(email: emailController.text);
      //hideLoadingIndicator();

      Get.snackbar(
        'Password Reset Email Sent',
        'Check your email and follow the instructions to reset your password.',
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppThemes.DEEP_ORANGE,
        colorText: AppThemes.white,
      );
    } on FirebaseAuthException catch (error) {
      //hideLoadingIndicator();\
      Get.snackbar(
        'Password Reset Email Failed',
        error.message!,
        duration: Duration(seconds: 10),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppThemes.DEEP_ORANGE,
        colorText: AppThemes.white,
      );
    }
  }

  Future<void> deleteUserById(UserModel userModel) async {
    await firebaseFirestore.collection(USERS).doc(userModel.uid!).set(
        {UserModel.IS_DELETED: true}, SetOptions(merge: true)).whenComplete(() {
      editTextFieldController.clear();
    });
  }

  Future<void> updateCurrentUser(String title) async {
    String value = editTextFieldController.text.trim();
    await firebaseFirestore.collection(USERS).doc(userModel!.uid!).set(
        {title.toLowerCase(): value}, SetOptions(merge: true)).whenComplete(() {
      editTextFieldController.clear();
    });
  }

  Future<void> updateUser(UserModel userModel) async {
    await firebaseFirestore
        .collection(USERS)
        .doc(userModel.uid!)
        .set(userModel.toJson(), SetOptions(merge: true))
        .whenComplete(() {
      print("User updated");
    });
  }

  List getProfileData() {
    var profileData = [
      {
        "title": "Phone",
        "subtitle":
            userModel!.phone != null ? userModel!.phone : 'no phone number',
        "icon": "assets/icons/phone_icon.svg"
      },
      {
        "title": "Email",
        "subtitle":
            userModel!.email != null ? userModel!.email : "example@gmail.com",
        "icon": "assets/icons/email_icon.svg"
      },
      {
        "title": "Address",
        "subtitle": userModel!.address != null
            ? userModel!.address
            : 'e.g. street, e.g. city, e.g. Country',
        "icon": "assets/icons/address_icon.svg"
      },
    ];
    return profileData;
  }

  Stream<List<ProfileAvatars>> getProfileAvatars() {
    return firebaseFirestore.collection(PROFILE_AVATARS).snapshots().map(
        (event) =>
            event.docs.map((e) => ProfileAvatars.fromMap(e.data())).toList());
  }

  updateProfileAvatar(ProfileAvatars profileAvatar) async {
    await firebaseFirestore.collection(USERS).doc(userModel!.uid!).set(
        {UserModel.PHOTO_URL: profileAvatar.url!},
        SetOptions(merge: true)).whenComplete(() {
      Get.back();
      AppConstant.displaySuccessSnackBar(
          "Success!", "Profile Avatar Successfully Updated!");
    });
  }

  _clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    degreeProgramController.clear();
    addressController.clear();

    firebaseUser.value = null;
  }

  _disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    animationController.dispose();
    degreeProgramController.dispose();
    addressController.dispose();
  }

  void deleteGetXControllers() {
    Get.delete<SubscriptionController>();
    Get.delete<QAController>();
  }

  // Sign out
  Future<void> signOut() async {
    _clearControllers();
    sharedPref!.remove(TRIAL_DIALOG);
    _googleSignIn?.signOut();
    return await firebaseAuth.signOut();
  }
}
