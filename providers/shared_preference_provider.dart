import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:goal_bank/data/language.dart';
import 'package:goal_bank/enums/sort_enum.dart';
import 'package:goal_bank/enums/status_enum.dart';

import 'package:goal_bank/models/app_class.dart';
import 'package:goal_bank/models/dto/currency_dto.dart';
import 'package:goal_bank/models/dto/language_dto.dart';
import 'package:goal_bank/models/goal_class.dart';

import 'package:goal_bank/service/admob.dart';

import 'package:goal_bank/main_wrapper.dart';

class SharedPreferencesProvider extends ChangeNotifier{
  SharedPreferences _prefs;
  Language currentLang;
  Currency currentCurrency;
  int totalSum = 0;

  List<Currency> currencyList = [
    Currency.fromJson(dollar),
    Currency.fromJson(euro),
    Currency.fromJson(hryvnia),
  ];

  List<Goal> goalsList = [];
  List<Goal> defaultList = [];

  AppClass get appClass => GetIt.instance<AppClass>();

  Future fetch() async {
    _prefs = await SharedPreferences.getInstance().then((_) async {
      await getSelectedLanguage();
      await getGoalList();
      await getCurrency();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoaded.value = true;
      });

      updatePrefs();

      return;
    });
  }

  void setSelectedLanguage(Language language) async {
    currentLang = language;
    await _prefs.setString('selectedLanguage', language.toJsonString());
  }

  void setCurrency(Currency currency) async {
    currentCurrency = currency;

    await _prefs.setString('selectedCurrency', currency.toJsonString());
  }

  Future<bool> getSelectedLanguage() async {
    String _currentLang = _prefs.getString('selectedLanguage');

    if (_currentLang == null) {
      await _prefs.setString('selectedLanguage', json.encode(englishLanguage));
      return false;
    }

    if (_currentLang != null) {
      currentLang = Language.fromJsonString(_currentLang);

      appClass.currentLanguage = currentLang;
    }

    return true;
  }

  Future getCurrency() async {
    String _currentCurrency = _prefs.getString('selectedCurrency');

    if (_currentCurrency == null) {
      await _prefs.setString('selectedCurrency', Currency.fromJson(dollar).toJsonString());
      currentCurrency = Currency.fromJson(dollar);
      appClass.currentCurrency = Currency.fromJson(dollar);
      return false;
    }

    if (_currentCurrency != null) {
      currentCurrency = Currency.fromJsonString(_currentCurrency);
      appClass.currentCurrency = currentCurrency;
    }

    return true;
  }

  Future<bool> getLanguageFromPrefs() async {

    await fetchPrefs();
    bool _response = await getSelectedLanguage();
    return _response;
  }


  void addNewGoal(Goal goal) async {
    String _goalsString = _prefs.getString('goalsList');
    int _createdGoals = _prefs.getInt('createdGoals');

    if(_goalsString == null) {
      List _temp = [goal.toMap()];
      await _prefs.setString('goalsList', json.encode(_temp));
    }

    if (_createdGoals == null || _createdGoals == 0) {
      _createdGoals = 1;
      await _prefs.setInt('createdGoals', _createdGoals);
    } else {
      _createdGoals = _createdGoals + 1;
      await _prefs.setInt('createdGoals', _createdGoals);
    }

    Goal externalGoal = defaultList.firstWhere((innerGoal) => innerGoal.id == goal.id, orElse: () => null);

    if (externalGoal == null) {
      defaultList.add(goal);
      goalsList.add(goal);
    }

    totalSum += goal.currentSum;

    setGoalList(goalsList);

    updatePrefs();

    if (_createdGoals % 3 == 0) {
      await GetIt.instance<AdMobService>().createInterstitialAd();
    }
  }

  void updateGoal(String id,int sum) {
    int index = goalsList.indexWhere((item) => item.id == id);

    goalsList[index].currentSum += sum;
    totalSum += sum;

    if(goalsList[index].currentSum >= goalsList[index].neededSum){
      goalsList[index].status = GoalStatus.FINISHED;
    }

    setGoalList(goalsList);

    updatePrefs();
  }

  void deleteFromList(String id) {
    goalsList.removeWhere((item) => item.id == id);
    defaultList.removeWhere((item) => item.id == id);
    setGoalList(goalsList);

    totalSum = 0;

    defaultList.forEach((item) {
      totalSum += item.currentSum;
    });

    updatePrefs();
  }

  void setGoalList(List<Goal> _goalsList) async {
    List _toPref = [];

    _goalsList.forEach((item) {
      _toPref.add(item.toMap());
    });

    await _prefs.setString('goalsList', json.encode(_toPref));
  }

  Future<void> getGoalList() async {
    String _goalsListString = _prefs.getString('goalsList');

    if(_goalsListString == null)
      return false;

    List _temp = json.decode(_goalsListString);

    for (Map item in _temp) {
      defaultList.add(Goal.fromJson(item));
    }

    for (Goal item in defaultList) {
      totalSum += item.currentSum;
    }

    await _prefs.setInt('createdGoals', defaultList.length);

    sortList(SortStatus.OFF);
  }

  void _sortByNameIncreasing() {
    if (goalsList != null) goalsList.sort((a, b) =>
        a.name.compareTo(b.name));
  }

  void _sortByNameDecreasing() {
    if (goalsList != null) goalsList.sort((a, b) =>
        b.name.compareTo(a.name));
  }

  void _sortBySumIncreasing() {
    if (goalsList != null) goalsList.sort((a, b) =>
        a.currentSum.compareTo(b.currentSum));
  }

  void _sortBySumDecreasing() {
    if (goalsList != null) goalsList.sort((a, b) =>
        b.currentSum.compareTo(a.currentSum));
  }

  void _sortByCreateDateIncreasing() {
    if (goalsList != null) goalsList.sort((a, b) =>
        a.createDate.compareTo(b.createDate));
  }

  void _sortByCreateDateDecreasing() {
    if (goalsList != null) goalsList.sort((a, b) =>
        b.createDate.compareTo(a.createDate));
  }

  void _sortByFinishDateIncreasing() {
    if (goalsList != null) goalsList.sort((a, b) =>
        a.endDate.compareTo(b.endDate));
  }

  void _sortByFinishDateDecreasing() {
    if (goalsList != null) goalsList.sort((a, b) =>
        b.endDate.compareTo(a.endDate));
  }

  void _sortShowFinished() {
    goalsList.clear();
    for (Goal goal in defaultList) {
      if (goal.status == GoalStatus.FINISHED) {
        goalsList.add(goal);
      }
    }
  }

  void sortList(SortStatus status) {
    switch (status) {
      case SortStatus.OFF:
        goalsList.clear();

        defaultList.forEach((goal) {
          if (goal.status == GoalStatus.ACTIVE) {
            goalsList.add(goal);
          }
        });
        break;
      case SortStatus.NAME_INCREASING:
        _sortByNameIncreasing();
        break;
      case SortStatus.NAME_DECREASING:
        _sortByNameDecreasing();
        break;
      case SortStatus.SUM_INCREASING:
        _sortBySumIncreasing();
        break;
      case SortStatus.SUM_DECREASING:
        _sortBySumDecreasing();
        break;
      case SortStatus.CREATE_DATE_INCREASING:
        _sortByCreateDateIncreasing();
        break;
      case SortStatus.CREATE_DATE_DECREASING:
        _sortByCreateDateDecreasing();
        break;
      case SortStatus.FINISH_DATE_INCREASING:
        _sortByFinishDateIncreasing();
        break;
      case SortStatus.FINISH_DATE_DECREASING:
        _sortByFinishDateDecreasing();
        break;
      case SortStatus.SHOW_FINISHED:
        _sortShowFinished();
        break;
    }
  }

  void updatePrefs() {
    notifyListeners();
  }

  Future clearPreferences() async {
    await _prefs.clear();
  }

  Future fetchPrefs() async{
    _prefs ??= await SharedPreferences.getInstance();
  }
}