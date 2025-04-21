import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scalp_pure/BackEnd/class_models.dart';
import '../Screens/Home/product_details.dart';
import '../components/AppMessage.dart';
import '../components/AppRoutes.dart';

///=================================================================
class ProviderClass extends ChangeNotifier {
  DataHandle<List<Product>> products = DataHandle(result: AppMessage.initial);

  final auth = FirebaseAuth.instance;

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

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();

      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      return await auth.signInWithCredential(cred);
    } catch (e) {
      print('========================== $e');
    }

    return null;
  }

  Future signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      print('========================== $e');
      return false;
    }
  }

  Future logInWithEmail(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print('========================== $e');
      return false;
    }
  }

  Future testProduct({required context, required File image}) async {
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

    AppRoutes.pushTo(context, ProductDetail(isFile: true, product: product));
  }
}
