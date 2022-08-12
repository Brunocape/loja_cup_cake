import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserModel  {
   FirebaseAuth firebaseAuth = FirebaseAuth.instance;

   var currentUser = FirebaseAuth.instance.currentUser;
  
   Map<String, dynamic> userData = Map();
  
   bool isLoading = false;


   Future<void> Iniciar() async{
     currentUser = FirebaseAuth.instance.currentUser;
     if(currentUser != null){
      var user = await FirebaseFirestore.instance.collection("users").doc(currentUser?.uid.toString()).get();
             userData["name"] = user.get("name");
             userData["email"] = user.get("email");

     }
   }

   Future<String> signUp({required Map<String, dynamic> userData, required String pass}) async {

     try {
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: userData["email"],
           password: pass
       );
       currentUser = FirebaseAuth.instance.currentUser;
       await _saveUserData(userData);
       isLoading = false;
        return "Usuario criado com sucesso!";
     } on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         return "The password provided is too weak.";
       } else if (e.code == 'email-already-in-use') {
         return 'The account already exists for that email.';
       }
       return "Falha ao criar usuario";
     } catch (e) {
       isLoading = false;
       return e.toString();
     }

  
   }
  
   Future<String> signIn({required String email, required String pass}) async {

     isLoading = true;
     try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: email,
           password: pass
       );

       currentUser = FirebaseAuth.instance.currentUser;

       var user = await FirebaseFirestore.instance.collection("users").doc(currentUser?.uid.toString()).get();
       userData["name"] = user.get("name");
       userData["email"] = user.get("email");

       isLoading = false;
       return "Logado com sucesso!";
     } on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
         return "Email não encontrado";
       } else if (e.code == 'wrong-password') {
         return "Senha invalida";
       }
       return "Falha ao logar";
     } catch (e) {
       isLoading = false;
       return e.toString();
     }

   }
  
   void signOut() async {
     isLoading = true;
     try {
       await FirebaseAuth.instance.signOut();
       currentUser = FirebaseAuth.instance.currentUser;
       userData = Map();
       isLoading = false;
     } on FirebaseAuthException catch (e) {
       isLoading = false;
     }
   }


  
   void recoverPass(String email){
     firebaseAuth.sendPasswordResetEmail(email: email);
   }
  
   bool isLoggedIn(){
     return currentUser != null;
   }
  
   Future<Null> _saveUserData(Map<String, dynamic> userData) async {
     this.userData = userData;
     await FirebaseFirestore.instance.collection("users").doc(currentUser?.uid ).set(userData);
   }

}