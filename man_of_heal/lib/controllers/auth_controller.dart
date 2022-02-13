import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:man_of_heal/ui/admin/admin_home.dart';
import 'package:man_of_heal/ui/auth/welcome_back_ui.dart';
import 'package:man_of_heal/ui/student/std_home.dart';
import 'package:man_of_heal/utils/firebase.dart';

class AuthController extends GetxController {
  static const String USERS = "users";
  static const String ADMIN = "admins";

  //this will get the initialized obj of AuthController and will shared app wise.
  static AuthController instance = Get.find();

  //this is edittext controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController degreeProgramController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Rx<User> firebaseUser = Rx<User>(firebaseAuth.currentUser);
  // Rx<UserModel> userModel = UserModel().obs;
  // final RxBool admin = false.obs;
  // final RxBool isLoggedIn = false.obs;

  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> userModel = Rxn<UserModel>();
  final RxBool admin = false.obs;

  // Firebase user one-time fetch
  // Future<User> get getUser async => firebaseAuth.currentUser!;

  // Firebase user a realtime stream
  //Stream<User?> get user => _fireAuth.authStateChanges();
  //Stream<User?> get user => _fireAuth.userChanges();

  // Firebase user one-time fetch
  Future<User> get getUser async => firebaseAuth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => firebaseAuth.authStateChanges();

  @override
  void onReady() async {
    //run every time auth state changes
    firebaseUser.bindStream(firebaseAuth.userChanges());
    // userById.bindStream(getUserById());
    ever(firebaseUser, handleAuthChanged);

    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      userModel.bindStream(streamFirestoreUser());
      await isAdmin();
    }

    if (_firebaseUser == null) {
      print('Send to sign in');
      Get.offAll(WelcomeBackUI());
    } else {
      if (admin.value)
        Get.offAll(AdminHome());
      else
        Get.offAll(StudentHome());
    }
  }

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return firebaseFirestore
        .collection(USERS)
        .doc(firebaseUser.value?.uid)
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  Future<UserModel> getUserById(String id) {
    print('getByUserID()');

    return firebaseFirestore
        .collection(USERS)
        .doc(id)
        .get()
        .then((DocumentSnapshot snap) => UserModel.fromDoc(snap.data()));
  }

  //Method to handle user sign in using email and password
  signIn() async {
    //showLoadingIndicator();
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        _clearControllers();
      });

      //hideLoadingIndicator();
    } catch (error) {
      // hideLoadingIndicator();

      Get.snackbar(
          'Sign In Error', 'Login failed: email or password incorrect.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  _clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    degreeProgramController.clear();
    addressController.clear();
  }

  // User registration using email and password
  signUp() async {
    //showLoadingIndicator();
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) async {
        print('uID: ' + result.user!.uid.toString());
        print('email: ' + result.user!.email.toString());

        //create the new user object
        UserModel _newUser = UserModel(
            uid: result.user!.uid,
            email: result.user!.email!,
            name: nameController.text,
            createdDate: Timestamp.now(),
            degreeProgram: degreeProgramController.text,
            address: addressController.text,
            isAdmin: false);
        //create the user in firestore
        _createUserFirestore(_newUser, result.user!);

        //hideLoadingIndicator();
      });
    } on FirebaseAuthException catch (error) {
      //hideLoadingIndicator();
      Get.snackbar('Sign Up Failed.', error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  //create the firestore user in users collection
  void _createUserFirestore(UserModel user, User _firebaseUser) {
    print("user entered=" + _firebaseUser.uid);
    firebaseFirestore
        .collection(USERS)
        .doc(_firebaseUser.uid)
        .set(user.toJson())
        .then((value) =>
            {_clearControllers(), print("User was registered successfully!")});
  }

  //check if user is an admin user
  isAdmin() async {
    await getUser.then((user) async {
      await firebaseFirestore
          .collection(USERS)
          .doc(user.uid)
          .get()
          .then((value) {
        //Map<String, dynamic> data = docSnap.data();
        //var data = docSnap.data;
        print('Snaps Data Users ${value["isAdmin"]}');
        if (value.exists && value["isAdmin"]) {
          admin.value = true;
        } else {
          admin.value = false;
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

      Get.snackbar('Password Reset Email Sent',
          'Check your email and follow the instructions to reset your password.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } on FirebaseAuthException catch (error) {
      //hideLoadingIndicator();

      Get.snackbar('Password Reset Email Failed', error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  // Sign out
  Future<void> signOut() {
    _clearControllers();
    return firebaseAuth.signOut();
  }
}
