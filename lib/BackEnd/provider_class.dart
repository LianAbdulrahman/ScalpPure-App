import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scalp_pure/BackEnd/class_models.dart';
import 'package:scalp_pure/BackEnd/post_api.dart';
import 'package:scalp_pure/Screens/Auth/sign_up.dart';
import 'package:scalp_pure/Widget/AppDialog.dart';
import 'package:scalp_pure/Widget/AppSnackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/Home/product_details.dart';
import '../components/AppMessage.dart';
import '../components/AppRoutes.dart';

///=================================================================
class ProviderClass extends ChangeNotifier {
  DataHandle<List<Product>> products = DataHandle(result: AppMessage.initial);

  final auth = FirebaseAuth.instance;
  String? token;
  String? userId;

  List<String> kBuildUpChemicalsList = [
    "sodium lauryl sulfate",
    "sodium laureth sulfate",
    "cocamidopropyl betaine",
    "dimethylaminopropylamine",
    "lauramidopropyl dimethylamine",
    "dimethicone",
    "cyclomethicone",
    "dMDM hydantoin",
    "methylisothiazolinone",
    "p-phenylenediamine",
    "toluene-2,5-Diamine",
    "triethanolamine",
    "carbomer",
    "melaleuca alternifolia leaf oil",
    "p-aminophenol",
    "m-aminophenol",
    "benzophenone-3",
    "behenoxy Dimethicone",
    "bis-Phenylpropyl Dimethicone",
    "cetyl Dimethicone",
    "cetearyl Methicone",
    "dimethiconol Hydroxystearate",
    "polysilicone-18 Cetyl Phosphate",
    "propyl Dimethicone",
    "stearoxy Dimethicone",
    "stearyl dimethicone",
    "stearyl methicone",
    "trimethylsiylamodimethicone",
    "butylparaben",
    "propylparaben",
    "ethylparaben",
    "methylparaben",
    "silicone",
    "parabens",
    "petrolatum",
    "alcohol",
    "polyquaternium",
    "fragrance",
  ];

  Future checkToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    userId = pref.getString('userId');
    return token;
  }

  Future saveToken({required String? token, required String? userId}) async {
    print('token token $token');
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (token != null) {
      await pref.setString('token', token!);
    }
    if (userId != null) {
      await pref.setString('userId', userId!);
    }
  }

  Future deleteToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    await pref.remove('userId');
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();

      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      UserCredential userCred = await auth.signInWithCredential(cred);

      saveToken(token: cred?.accessToken, userId: auth.currentUser?.uid);

      return userCred;
    } catch (e) {
      print('========================== $e');
    }

    return null;
  }

  Future signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((cred) {
        saveToken(
            token: cred.credential?.accessToken, userId: auth.currentUser?.uid);
      });
      return true;
    } catch (e) {
      print('========================== $e');
      return false;
    }
  }

  Future logInWithEmail(
      {required String email, required String password}) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((cred) async {
        String? token = await cred.user?.getIdToken();

        saveToken(token: token, userId: auth.currentUser?.uid);
      });
      return true;
    } catch (e) {
      print('========================== $e');
      return false;
    }
  }

  Future logOut({required context}) async {
    await auth.signOut();
    await deleteToken();
    AppRoutes.pushAndRemoveAllPageTo(context, const SignUp());
  }

  Future testProduct({required context, required File image}) async {
    AppDialog.showLoading(context: context);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(InputImage.fromFile(image)!);
    List<String> buildingUpChemicals = [];

    List<String> ingredients = [];

    for (TextBlock block in recognizedText.blocks) {
      ingredients = block.text.split(',');

      for (String ingredient in ingredients) {
        print('ingredient ${ingredient.toLowerCase().trim()}');

        kBuildUpChemicalsList.forEach((element) {
          if (ingredient.toLowerCase().trim().contains(element) &&
              !buildingUpChemicals.contains(ingredient)) {
            buildingUpChemicals.add(ingredient);
          }
        });
      }
    }

    Product product =
        Product(image: image, buildingUpChemicals: buildingUpChemicals);

    PostApi.addProduct(context: context, product: product).then((result) {
      Navigator.pop(con!);
      result
          ? {
              AppRoutes.pushTo(
                  context, ProductDetail(isFile: true, product: product))
            }
          : {
              AppSnackBar.showInSnackBar(
                  context: context,
                  message: AppMessage.somethingWrong,
                  isSuccessful: false)
            };
    });
  }
}
