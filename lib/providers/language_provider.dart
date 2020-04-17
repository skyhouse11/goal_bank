import 'package:flutter/material.dart';
import 'package:goal_bank/data/language.dart';
import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/enums/direction_type.dart';
import 'package:goal_bank/models/dto/language_dto.dart';
import 'package:goal_bank/providers/shared_preference_provider.dart';

class LanguageProvider with ChangeNotifier {
  String mainPageTitle;
  String mainPageCreateFirst;
  String mainPageExperience;
  String mainPageSortOrderBy;
  String mainPageNameSort;
  String mainPageSumSort;
  String mainPageCreateDateSort;
  String mainPageFinishDateSort;
  String mainPageFinished;

  String carouselSkipName;
  String carouselFirst;
  String carouselSecond;
  String carouselThird;

  String createGoalPageTitle;
  String createGoalPageNameTitle;
  String createGoalPageNameHint;
  String createGoalPageImageTitle;
  String createGoalPageAmountTitle;
  String createGoalPageAmountHint;
  String createGoalPageCurrentSumTitle;
  String createGoalPageCurrentSumHint;
  String createGoalPageCurrentDateTitle;
  String createGoalPageCurrentDateHint;
  String createGoalPageButton;

  String settingsPageTitle;
  String settingsPageLanguageTitle;
  String settingsPageCurrencyInput;
  String settingsPageThemeTitle;
  String settingsPageDarkTheme;
  String settingsPageLightTheme;

  String aboutPageTitle;
  String aboutPageWriteUs;
  String aboutPageNameTitle;
  String aboutPageEmailTitle;
  String aboutPageMessageTitle;
  String aboutPageNameHint;
  String aboutPageEmailHint;
  String aboutPageMessageHint;
  String aboutPageButton;
  String aboutPageAboutText;

  String deletePopupContent;
  String deletePopupCancel;
  String deletePopupRemove;

  String addPopupContent;
  String addPopupCancel;
  String addPopupAdd;
  String addPopupCurrentSum;
  String addPopupSumLeft;

  String emailSentPopupTitle;
  String emailSentPopupContent;

  String congratulationsPopupTitle;
  String congratulationsPopupContent;

  String errorNameTooShort;
  String errorNameIsEmpty;
  String errorEmailNotValid;
  String errorEmailIsEmpty;
  String errorMessageTooShort;
  String errorMessageIsEmpty;
  String errorGoalNameIsEmpty;
  String errorGoalImageIsEmpty;
  String errorGoalSumIsEmpty;
  String errorGoalCurrentSumIsEmpty;
  String errorGoalDateIsEmpty;
  String errorCurrentSumBiggerThanGoal;

  String usd;
  String eu;
  String hrn;

  String bottomBarHome;
  String bottomBarSettings;
  String bottomBarAboutUs;

  SharedPreferencesProvider sharedPreferencesProvider;
  Language selectedLanguage;
  DirectionType direction = DirectionType.LTR;

  Locale locale;

  List<Language> languageList = languageMapList.map((item) =>  Language.fromJson(item)).toList();
  init(SharedPreferencesProvider shared) async {
    sharedPreferencesProvider = shared;

    selectedLanguage = Language.fromJson(englishLanguage);
    locale = selectedLanguage.locale;

    changeLanguage(selectedLanguage);

    if(!await sharedPreferencesProvider.getLanguageFromPrefs())
      return;

    changeLanguage(sharedPreferencesProvider.currentLang);
  }

  setNewLanguage(Language language) {

    sharedPreferencesProvider.setSelectedLanguage(language);

    changeLanguage(language);

  }

  void changeLanguage(Language languageData) {
    bool hasChanges = _doChangeLanguage(languageData);

    selectedLanguage = languageData;

    DirectionType _direction = direction;
    direction = DirectionType.LTR;
    locale = languageData.locale;
    if(languageData.direction == 'rtl') {
      direction = DirectionType.RTL;
    }
    hasChanges = _direction == direction ? false : true;

    notifyListeners();
  }

  void setCurrentLanguageName(Language languageDto) {
    Map<String, dynamic> languageData = languageDto.content;

    String val = _getValue(languageData, 'title');
  }

  bool _doChangeLanguage(Language languageDto) {
    setCurrentLanguageName(languageDto);
    return (
        setMainPageLanguage(languageDto)      |
        setCarouselLanguage(languageDto)      |
        setCreateGoalPage(languageDto)        |
        setSettingsPage(languageDto)          |
        setAboutPage(languageDto)             |
        setPopupsLanguage(languageDto)        |
        setErrorsLanguage(languageDto)        |
        setCurrencyString(languageDto)        |
        setBottomBarString(languageDto)
    );
  }

  bool setMainPageLanguage(Language languageDto) {
    Map<String, dynamic> languageData = languageDto.content;
    bool hasChanges = false;

    String val = _getValue(languageData, 'main_page.page_title');
    if(val != null && val != mainPageTitle) {
      mainPageTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.create_first');
    if(val != null && val != mainPageCreateFirst) {
      mainPageCreateFirst = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.expires');
    if(val != null && val != mainPageExperience) {
      mainPageExperience = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.sort_widget.order_by');
    if(val != null && val != mainPageSortOrderBy) {
      mainPageSortOrderBy = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.sort_widget.name_sort');
    if(val != null && val != mainPageNameSort) {
      mainPageNameSort = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.sort_widget.sum_sort');
    if(val != null && val != mainPageSumSort) {
      mainPageSumSort = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.sort_widget.create_date');
    if(val != null && val != mainPageCreateDateSort) {
      mainPageCreateDateSort = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.sort_widget.finish_date');
    if(val != null && val != mainPageFinishDateSort) {
      mainPageFinishDateSort = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.sort_widget.finished_goals');
    if(val != null && val != mainPageFinished) {
      mainPageFinished = val;
      hasChanges = true;
    }
    return hasChanges;
  }

  bool setCarouselLanguage(Language languageDto) {
    Map<String, dynamic> languageData = languageDto.content;
    bool hasChanges = false;

    String val = _getValue(languageData, 'main_page.carousel.skip_block');
    if(val != null && val != carouselSkipName) {
      carouselSkipName = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.carousel.first_page');
    if(val != null && val != carouselFirst) {
      carouselFirst = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.carousel.second_page');
    if(val != null && val != carouselSecond) {
      carouselSecond = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'main_page.carousel.third_page');
    if(val != null && val != carouselThird) {
      carouselThird = val;
      hasChanges = true;
    }

    return hasChanges;
  }

  bool setCreateGoalPage(Language languageDto) {
    Map<String, dynamic> languageData = languageDto.content;
    bool hasChanges = false;

    String val = _getValue(languageData, 'create_goal_page.page_title');
    if(val != null && val != createGoalPageTitle) {
      createGoalPageTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'create_goal_page.name_title');
    if(val != null && val != createGoalPageNameTitle) {
      createGoalPageNameTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'create_goal_page.name_hint');
    if(val != null && val != createGoalPageNameHint) {
      createGoalPageNameHint = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'create_goal_page.goal_image');
    if(val != null && val != createGoalPageImageTitle) {
      createGoalPageImageTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'create_goal_page.goal_amount');
    if(val != null && val != createGoalPageAmountTitle) {
      createGoalPageAmountTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'create_goal_page.goal_hint');
    if(val != null && val != createGoalPageAmountHint) {
      createGoalPageAmountHint = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'create_goal_page.current_sum');
    if(val != null && val != createGoalPageCurrentSumTitle) {
      createGoalPageCurrentSumTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'create_goal_page.current_sum_hint');
    if(val != null && val != createGoalPageCurrentSumHint) {
      createGoalPageCurrentSumHint = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'create_goal_page.current_date');
    if(val != null && val != createGoalPageCurrentDateTitle) {
      createGoalPageCurrentDateTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'create_goal_page.current_date_hint');
    if(val != null && val != createGoalPageCurrentDateHint) {
      createGoalPageCurrentDateHint = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'create_goal_page.button_text');
    if(val != null && val != createGoalPageButton) {
      createGoalPageButton = val;
      hasChanges = true;
    }
    return hasChanges;
  }

  bool setSettingsPage(Language languageDto) {
    Map<String, dynamic> languageData = languageDto.content;
    bool hasChanges = false;

    String val = _getValue(languageData, 'settings_page.page_title');
    if(val != null && val != settingsPageTitle) {
      settingsPageTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'settings_page.language_input');
    if(val != null && val != settingsPageLanguageTitle) {
      settingsPageLanguageTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'settings_page.currency_input');
    if(val != null && val != settingsPageCurrencyInput) {
      settingsPageCurrencyInput = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'settings_page.theme_input');
    if(val != null && val != settingsPageThemeTitle) {
      settingsPageThemeTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'settings_page.dark_theme');
    if(val != null && val != settingsPageDarkTheme) {
      settingsPageDarkTheme = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'settings_page.light_theme');
    if(val != null && val != settingsPageLightTheme) {
      settingsPageLightTheme = val;
      hasChanges = true;
    }
    return hasChanges;
  }

  bool setAboutPage(Language languageDto) {
    Map<String, dynamic> languageData = languageDto.content;
    bool hasChanges = false;

    String val = _getValue(languageData, 'about_page.page_title');
    if(val != null && val != aboutPageTitle) {
      aboutPageTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'about_page.write_us');
    if(val != null && val != aboutPageWriteUs) {
      aboutPageWriteUs = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'about_page.name_title');
    if(val != null && val != aboutPageNameTitle) {
      aboutPageNameTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'about_page.email_title');
    if(val != null && val != aboutPageEmailTitle) {
      aboutPageEmailTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'about_page.message_title');
    if(val != null && val != aboutPageMessageTitle) {
      aboutPageMessageTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'about_page.name_hint');
    if(val != null && val != aboutPageNameHint) {
      aboutPageNameHint = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'about_page.email_hint');
    if(val != null && val != aboutPageEmailHint) {
      aboutPageEmailHint = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'about_page.message_hint');
    if(val != null && val != aboutPageMessageHint) {
      aboutPageMessageHint = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'about_page.button_text');
    if(val != null && val != aboutPageButton) {
      aboutPageButton = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'about_page.about_text');
    if(val != null && val != aboutPageAboutText) {
      aboutPageAboutText = val;
      hasChanges = true;
    }
    return hasChanges;
  }


  bool setPopupsLanguage(Language languageDto) {
    Map<String, dynamic> languageData = languageDto.content;
    bool hasChanges = false;

    String val = _getValue(languageData, 'pop-ups.delete_pop-up.content');
    if(val != null && val != deletePopupContent) {
      deletePopupContent = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.delete_pop-up.cancel_button');
    if(val != null && val != deletePopupCancel) {
      deletePopupCancel = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.delete_pop-up.remove_button');
    if(val != null && val != deletePopupRemove) {
      deletePopupRemove = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.add_cash_pop-up.content');
    if(val != null && val != addPopupContent) {
      addPopupContent = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.add_cash_pop-up.cancel_button');
    if(val != null && val != addPopupCancel) {
      addPopupCancel = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.add_cash_pop-up.add_button');
    if(val != null && val != addPopupAdd) {
      addPopupAdd = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.add_cash_pop-up.current_sum');
    if(val != null && val != addPopupCurrentSum) {
      addPopupCurrentSum = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.add_cash_pop-up.sum_left');
    if(val != null && val != addPopupSumLeft) {
      addPopupSumLeft = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.email_sent.title');
    if(val != null && val != emailSentPopupTitle) {
      emailSentPopupTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.email_sent.content');
    if(val != null && val != emailSentPopupContent) {
      emailSentPopupContent = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.congratulations.title');
    if(val != null && val != congratulationsPopupTitle) {
      congratulationsPopupTitle = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'pop-ups.congratulations.content');
    if(val != null && val != congratulationsPopupContent) {
      congratulationsPopupContent = val;
      hasChanges = true;
    }

    return hasChanges;
  }

  bool setErrorsLanguage(Language languageDto) {
    Map<String, dynamic> languageData = languageDto.content;
    bool hasChanges = false;

    String val = _getValue(languageData, 'errors.name_too_short');
    if (val != null && val != errorNameTooShort) {
      errorNameTooShort = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.name_is_empty');
    if (val != null && val != errorNameIsEmpty) {
      errorNameIsEmpty = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.email_not_valid');
    if (val != null && val != errorEmailNotValid) {
      errorEmailNotValid = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.email_is_empty');
    if (val != null && val != errorEmailIsEmpty) {
      errorEmailIsEmpty = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.message_too_short');
    if (val != null && val != errorMessageTooShort) {
      errorMessageTooShort = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.message_is_empty');
    if (val != null && val != errorMessageIsEmpty) {
      errorMessageIsEmpty = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.goal_name_is_empty');
    if (val != null && val != errorGoalNameIsEmpty) {
      errorGoalNameIsEmpty = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.goal_image_is_empty');
    if (val != null && val != errorGoalImageIsEmpty) {
      errorGoalImageIsEmpty = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.goal_amount_is_empty');
    if (val != null && val != errorGoalSumIsEmpty) {
      errorGoalSumIsEmpty = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.goal_current_sum_is_empty');
    if (val != null && val != errorGoalCurrentSumIsEmpty) {
      errorGoalCurrentSumIsEmpty = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.goal_current_sum_bigger');
    if (val != null && val != errorCurrentSumBiggerThanGoal) {
      errorCurrentSumBiggerThanGoal = val;
      hasChanges = true;
    }
    val = _getValue(languageData, 'errors.goal_date_is_empty');
    if (val != null && val != errorGoalDateIsEmpty) {
      errorGoalDateIsEmpty = val;
      hasChanges = true;
    }

    return hasChanges;
  }

  bool setCurrencyString(Language languageDto) {
    Map<String, dynamic> languageData = languageDto.content;
    bool hasChanges = false;

    String val = _getValue(languageData, 'currency_list.usd');
    if (val != null && val != usd) {
      usd = val;
    }
    val = _getValue(languageData, 'currency_list.eu');
    if (val != null && val != eu) {
      eu = val;
    }
    val = _getValue(languageData, 'currency_list.hrn');
    if (val != null && val != hrn) {
      hrn = val;
    }

    return hasChanges;
  }

  bool setBottomBarString(Language languageDto) {
    Map<String, dynamic> languageData = languageDto.content;
    bool hasChanges = false;

    String val = _getValue(languageData, 'bottom_bar.home');
    if (val != null && val != bottomBarHome) {
      bottomBarHome = val;
    }
    val = _getValue(languageData, 'bottom_bar.settings');
    if (val != null && val != bottomBarSettings) {
      bottomBarSettings = val;
    }
    val = _getValue(languageData, 'bottom_bar.about_us');
    if (val != null && val != bottomBarAboutUs) {
      bottomBarAboutUs = val;
    }

    return hasChanges;
  }

  String _getValue(Map<String, dynamic> languageData, String value) {
    if (value == null || languageData == null) return null;

    dynamic _return = languageData;

    value.split('.').forEach((String key) {
      if (!(_return is List)) {
        if (_return == null || _return[key] == null) {
          _return = null;
        } else {
          _return = _return[key];
        }
      }
    });

    return _return;
  }

  Map<String,dynamic> _getMap(Map<String, dynamic> languageData, String value) {
    if (value == null || languageData == null) return null;

    dynamic _return = languageData;

    value.split('.').forEach((String key) {
      if (_return == null || _return[key] == null) {
        _return = null;
      } else {
        _return = _return[key];
      }
    });

    if (_return == null) return {};

    return (_return is Map) ? _return : {};
  }

  String getCurrentStringValue(AppString string) {
    switch(string) {
      case AppString.MAIN_PAGE_TITLE:
        return mainPageTitle;
      case AppString.MAIN_PAGE_CREATE_FIRST:
        return mainPageCreateFirst;
      case AppString.MAIN_PAGE_EXPERIENCE:
        return mainPageExperience;
      case AppString.MAIN_PAGE_SORT_BY:
        return mainPageSortOrderBy;
      case AppString.MAIN_PAGE_NAME_SORT:
        return mainPageNameSort;
      case AppString.MAIN_PAGE_SUM_SORT:
        return mainPageSumSort;
      case AppString.MAIN_PAGE_CREATE_DATE_SORT:
        return mainPageCreateDateSort;
      case AppString.MAIN_PAGE_FINISH_DATE_SORT:
        return mainPageFinishDateSort;
      case AppString.MAIN_PAGE_FINISHED:
        return mainPageFinished;

      case AppString.CAROUSEL_SKIP_NAME:
        return carouselSkipName;
      case AppString.CAROUSEL_FIRST:
        return carouselFirst;
      case AppString.CAROUSEL_SECOND:
        return carouselSecond;
      case AppString.CAROUSEL_THIRD:
        return carouselThird;

      case AppString.CREATE_GOAL_PAGE_TITLE:
        return createGoalPageTitle;
      case AppString.CREATE_GOAL_PAGE_NAME_TITLE:
        return createGoalPageNameTitle;
      case AppString.CREATE_GOAL_PAGE_NAME_HINT:
        return createGoalPageNameHint;
      case AppString.CREATE_GOAL_PAGE_IMAGE_TITLE:
        return createGoalPageImageTitle;
      case AppString.CREATE_GOAL_PAGE_AMOUNT_TITLE:
        return createGoalPageAmountTitle;
      case AppString.CREATE_GOAL_PAGE_CURRENT_SUM_TITLE:
        return createGoalPageCurrentSumTitle;
      case AppString.CREATE_GOAL_PAGE_CURRENT_DATE:
        return createGoalPageCurrentDateTitle;
      case AppString.CREATE_GOAL_PAGE_CURRENT_DATE_HINT:
        return createGoalPageCurrentDateHint;
      case AppString.CREATE_GOAL_PAGE_BUTTON:
        return createGoalPageButton;
      case AppString.CREATE_GOAL_PAGE_CURRENT_SUM_HINT:
        return createGoalPageCurrentSumHint;
      case AppString.CREATE_GOAL_PAGE_AMOUNT_HINT:
        return createGoalPageAmountHint;

      case AppString.SETTINGS_PAGE_TITLE:
        return settingsPageTitle;
      case AppString.SETTINGS_PAGE_LANGUAGE_TITLE:
        return settingsPageLanguageTitle;
      case AppString.SETTINGS_PAGE_CURRENCY:
        return settingsPageCurrencyInput;
      case AppString.SETTINGS_PAGE_THEME_TITLE:
        return settingsPageThemeTitle;
      case AppString.SETTINGS_PAGE_THEME_DARK:
        return settingsPageDarkTheme;
      case AppString.SETTINGS_PAGE_THEME_LIGHT:
        return settingsPageLightTheme;

      case AppString.ABOUT_PAGE_TITLE:
        return aboutPageTitle;
      case AppString.ABOUT_PAGE_WRITE_US:
        return aboutPageWriteUs;
      case AppString.ABOUT_PAGE_NAME_TITLE:
        return aboutPageNameTitle;
      case AppString.ABOUT_PAGE_EMAIL_TITLE:
        return aboutPageEmailTitle;
      case AppString.ABOUT_PAGE_MESSAGE_TITLE:
        return aboutPageMessageTitle;
      case AppString.ABOUT_PAGE_NAME_HINT:
        return aboutPageNameHint;
      case AppString.ABOUT_PAGE_EMAIL_HINT:
        return aboutPageEmailHint;
      case AppString.ABOUT_PAGE_MESSAGE_HINT:
        return aboutPageMessageHint;
      case AppString.ABOUT_PAGE_BUTTON_HINT:
        return aboutPageButton;
      case AppString.ABOUT_PAGE_ABOUT_TEXT:
        return aboutPageAboutText;

      case AppString.DELETE_POP_UP_CONTENT:
        return deletePopupContent;
      case AppString.DELETE_POP_UP_CANCEL_BUTTON:
        return deletePopupCancel;
      case AppString.DELETE_POP_UP_REMOVE_BUTTON:
        return deletePopupRemove;
      case AppString.ADD_POP_UP_CONTENT:
        return addPopupContent;
      case AppString.ADD_POP_UP_CANCEL_BUTTON:
        return addPopupCancel;
      case AppString.ADD_POP_UP_ADD_BUTTON:
        return addPopupAdd;
      case AppString.ADD_POP_UP_CURRENT_SUM:
        return addPopupCurrentSum;
      case AppString.ADD_POP_UP_SUM_LEFT:
        return addPopupSumLeft;
      case AppString.EMAIL_SENT_POP_UP_TITLE:
        return emailSentPopupTitle;
      case AppString.EMAIL_SENT_POP_UP_CONTENT:
        return emailSentPopupContent;
      case AppString.CONGRATULATIONS_POP_UP_TITLE:
        return congratulationsPopupTitle;
      case AppString.CONGRATULATIONS_POP_UP_CONTENT:
        return congratulationsPopupContent;

      case AppString.ERROR_NAME_TOO_SHORT:
        return errorNameTooShort;
      case AppString.ERROR_NAME_IS_EMPTY:
        return errorNameIsEmpty;
      case AppString.ERROR_EMAIL_NOT_VALID:
        return errorEmailNotValid;
      case AppString.ERROR_EMAIL_IS_EMPTY:
        return errorEmailIsEmpty;
      case AppString.ERROR_MESSAGE_TOO_SHORT:
        return errorMessageTooShort;
      case AppString.ERROR_MESSAGE_IS_EMPTY:
        return errorMessageIsEmpty;
      case AppString.ERROR_GOAL_NAME_IS_EMPTY:
        return errorGoalNameIsEmpty;
      case AppString.ERROR_GOAL_IMAGE_IS_EMPTY:
        return errorGoalImageIsEmpty;
      case AppString.ERROR_GOAL_SUM_IS_EMPTY:
        return errorGoalSumIsEmpty;
      case AppString.ERROR_GOAL_CURRENT_SUM_IS_EMPTY:
        return errorGoalCurrentSumIsEmpty;
      case AppString.ERROR_GOAL_CURRENT_SUM_BIGGER_THAN_GOAL:
        return errorCurrentSumBiggerThanGoal;
      case AppString.ERROR_GOAL_DATE_IS_EMPTY:
        return errorGoalDateIsEmpty;

      case AppString.CURRENCY_EU:
        return eu;
      case AppString.CURRENCY_USD:
        return usd;
      case AppString.CURRENCY_HRN:
        return hrn;

      case AppString.BOTTOM_BAR_HOME:
        return bottomBarHome;
      case AppString.BOTTOM_BAR_SETTINGS:
        return bottomBarSettings;
      case AppString.BOTTOM_BAR_ABOUT_US:
        return bottomBarAboutUs;
    }

    return '';
  }

}