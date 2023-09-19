import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class LoginProvider extends ChangeNotifier {
  String? nameA;
  String? nameE;
  String? userName;
  String? password;
  String? tel;
  String? email;
  String? mangerNameA;
  String? mangerNameE;
  String? depnameA;
  String? depnameE;
  String? userId;
  String? openticketP;
  String? assignticketP;
  String? adddailyworkP;
  String? showAllDaily;
  String? showAllTicket;
  bool? AllowN;





  getAllowN() {
    return AllowN;
  }

  setAllowN(bool AllowN) {
    this.AllowN = AllowN;
    notifyListeners();
  }


  getshowAllDaily() {
    return showAllDaily;
  }

  setshowAllDaily(String showAllDaily) {
    this.showAllDaily = showAllDaily;
    notifyListeners();
  }

  getshowAllTicket() {
    return showAllTicket;
  }

  setshowAllTicket(String showAllTicket) {
    this.showAllTicket = showAllTicket;
    notifyListeners();
  }


  getadddailyworkP() {
    return adddailyworkP;
  }

  setadddailyworkP(String adddailyworkP) {
    this.adddailyworkP = adddailyworkP;
    notifyListeners();
  }

  getassignticketP() {
    return assignticketP;
  }

  setassignticketP(String assignticketP) {
    this.assignticketP = assignticketP;
    notifyListeners();
  }

  getopenticketP() {
    return openticketP;
  }

  setopenticketP(String openticketP) {
    this.openticketP = openticketP;
    notifyListeners();
  }

  getuserId() {
    return userId;
  }

  setuserId(String userId) {
    this.userId = userId;
    notifyListeners();
  }



  getdepnameE() {
    return depnameE;
  }

  setdepnameE(String depnameE) {
    this.depnameE = depnameE;
    notifyListeners();
  }


  getdepnameA() {
    return depnameA;
  }

  setdepnameA(String depnameA) {
    this.depnameA = depnameA;
    notifyListeners();
  }


  getmangerNameE() {
    return mangerNameE;
  }

  setmangerNameE(String mangerNameE) {
    this.mangerNameE = mangerNameE;
    notifyListeners();
  }


  getmangerNameA() {
    return mangerNameA;
  }

  setmangerNameA(String mangerNameA) {
    this.email = mangerNameA;
    notifyListeners();
  }


  getemail() {
    return email;
  }

  setemail(String email) {
    this.email = email;
    notifyListeners();
  }

  gettel() {
    return tel;
  }

  settel(String tel) {
    this.tel = tel;
    notifyListeners();
  }


  getuserName() {
    return userName;
  }

  setuserName(String userName) {
    this.userName = userName;
    notifyListeners();
  }



  getpassword() {
    return password;
  }

  setpassword(String password) {
    this.password = password;
    notifyListeners();
  }



  getnameA() {
    return nameA;
  }

  setnameA(String nameA) {
    this.nameA = nameA;
    notifyListeners();
  }



  getnameE() {
    return nameE;
  }

  setnameE(String nameE) {
    this.nameE = nameE;
    notifyListeners();
  }


}