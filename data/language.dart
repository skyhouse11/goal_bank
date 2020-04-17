
const Map<String,dynamic> englishLanguage = {
  'name'      : 'English',
  'direction' : 'ltr',
  'locale'    : 'en',
  'content'   : {
    "main_page": {
      'page_title': 'Goals',
      'create_first': 'Create your first goal!',
      'expires': 'Before',
      'sort_widget': {
        'order_by': 'Order by',
        'name_sort': 'Name',
        'sum_sort': 'Sum sort',
        'create_date': 'Create date',
        'finish_date': 'Finish date',
        'finished_goals': 'Finished goals'
      },
      'carousel': {
        'skip_block': 'Miss',
        'first_page': 'Tap for button to create a goal',
        'second_page': 'Write the name of the target, upload a photo, write down the price',
        'third_page': 'When you click on a goal, you can view all the information and add the amount to it',
      }
    },

    'create_goal_page': {
      'page_title': 'Create goal',
      'name_title': 'Goal name',
      'name_hint': 'Your goal',
      'goal_image': 'Goal image',
      'goal_amount': 'Goal amount:',
      "goal_hint": "Your sum",
      'current_sum': 'Current sum: ',
      'current_sum_hint': 'Your current sum',
      'current_date': 'Date to:',
      'current_date_hint': 'Your goal date',
      'button_text': 'Create',
    },

    'settings_page': {
      'page_title': 'Settings',
      'language_input': 'Language:',
      'currency_input': 'Сurrency:',
      'theme_input': 'Theme:',
      'dark_theme': 'Dark',
      'light_theme': 'Light',
    },

    'about_page': {
      'page_title': 'About us',
      'write_us': 'Write us',
      'name_title': 'Name',
      'email_title': 'Email',
      'message_title': 'Message',
      'name_hint': 'Enter your name',
      'email_hint': 'Enter your email',
      'message_hint': 'Enter your message',
      'button_text': 'Send',

      'about_text': 'AppVesto is an American company founded by Israeli entrepreneurs.\n\nOn the first day, we engraved on our flag the right and obligation to give every private customer or company a quality response, a first-class service and a comprehensive and in-depth development process that brings his idea to reality in the right, most efficient and quick way.\n\nEvery day we are led by a wide network of satisfied customers from various industries, who continue to work together with us on the future of theirs and their clients technological development.',
    },

    'pop-ups': {
      'delete_pop-up': {
        'content': 'Are you sure you want to \n *remove your goal?*',
        'cancel_button': 'Cancel',
        'remove_button': 'Remove'
      },
      'add_cash_pop-up': {
        'content': 'Write the *amount* you want add to ',
        'cancel_button': 'Cancel',
        'add_button': 'Add',
        "current_sum": "Current sum",
        "sum_left": "Sum left",
      },
      'email_sent': {
        'title': 'Your email has been sent!',
        'content': 'We will respond as soon as possible!',
      },
      'congratulations': {
        'title': 'Congratulations!',
        'content': 'You finished your goal, great job!',
      },
    },

    'currency_list': {
      usd: 'Dollars',
      eu: 'Euros',
      hrn: 'Hryvna`s',
    },

    "bottom_bar": {
      "home": "Home",
      "settings": "Settings",
      "about_us": "About Us",
    },

    'errors': {
      'name_too_short'           : 'Your name is too short, please, enter correct name!',
      'name_is_empty'            : 'Name field is empty, please, enter correct name!',
      'email_not_valid'          : 'Your email is not valid, please, enter valid email!',
      'email_is_empty'           : 'Email field is empty, please, enter correct email!',
      'message_too_short'        : 'Your message is too short, please, enter correct message!',
      'message_is_empty'         : 'Message field is empty, please, enter correct message!',
      "goal_name_is_empty"       : "Goal name field is empty, please, enter correct name!",
      "goal_image_is_empty"      : "You did not choose the image, please, choose one!",
      "goal_amount_is_empty"     : 'Goal amount field is empty, please, enter correct amount!',
      "goal_current_sum_is_empty": 'Current sum amount field is empty, please, enter correct amount!',
      "goal_current_sum_bigger"  : "Current sum is bigger than goal amount, please, enter correct amounts!",
      "goal_date_is_empty"       : "Date name field is empty, please, enter correct date!",
    }
  }
};

const Map<String,dynamic> hebrewLanguage = {
  "name": "עברית",
  "direction": "rtl",
  "locale": "he",
  "content": {
    "main_page": {
      "page_title": "בנק מטרות",
      "create_first": "צור את המטרה הראשונה שלך!",
      "expires": "לפני",
      "sort_widget": {
        "order_by": "מיון לפי",
        "name_sort": "שם",
        "sum_sort": "סכום",
        "create_date": "תאריך יצירה",
        "finish_date": "תאריך סיום",
        "finished_goals": "מטרות שהסתיימו"
      },
      "carousel": {
        "skip_block": "דילוג",
        "first_page": "יש ללחוץ על הכפתור ליצירה מטרה",
        "second_page": "יש להזין את שם המטרה, תאריך, לבחור תמונה ולהזין את הסכום הרצוי",
        "third_page": "בלחיצה על מטרה היא תתרחב, יהיה ניתן לצפות בפרטים ולהוסיף סכום"
      }
    },
    "create_goal_page": {
      "page_title": "יצירת מטרה",
      "name_title": "שם",
      "name_hint": "שם",
      "goal_image": "תמונה",
      "goal_amount": "סכום:",
      "goal_hint": "הסכום שלך",
      "current_sum": "סכום קיים:",
      "current_sum_hint": "הסכום הנוכחי שלך",
      "current_date": "תאריך יעד:",
      'current_date_hint': 'תאריך היעד שלך',
      "button_text": "יצירה"
    },
    "settings_page": {
      "page_title": "הגדרות",
      "language_input": "שפה:",
      "currency_input": "מטבע:",
      "theme_input": "תבנית עיצוב:",
      "dark_theme": "כהה",
      "light_theme": "בהיר"
    },
    "about_page": {
      "page_title": "אודות",
      "write_us": "כתוב לנו",
      "name_title": "שם",
      "email_title": "אימייל",
      "message_title": "הודעה",
      "name_hint": "הזן את שמך",
      "email_hint": "הכנס את האימייל שלך",
      "message_hint": "הזן את ההודעה שלך",
      "button_text": "שליחה",
      "about_text": "AppVesto היא חברה אמריקאית שנוסדה על ידי יזמים ישראלים.\n\nהחל מהיום הראשון חרטנו על דגלנו את הזכות והחובה לספר לכל דורש מענה איכותי, שירות מהשורה הראשונה ותהליך פיתוח מקיף ומעמיק שמוריד רעיון למציאות בדרך היעילה והמהירה ביותר\n\nמידי יום אנחנו ממשיכים לשרת רשת רחבה של לקוחות מרוצים מתעשיות שונות שממשיכים לעבוד יחד איתנו כגב טכנולוגי איכותי ומקצועי."
    },
    "pop-ups": {
      "delete_pop-up": {
        "content": "האם אתה בטוח שברצונך \n *למחוק את המטרה?*",
        "cancel_button": "ביטול",
        "remove_button": "מחיקה"
      },
      "add_cash_pop-up": {
        "content": "יש להזין את *הסכום* שברצונך להוסיף ל ",
        "cancel_button": "ביטול",
        "add_button": "הוספה",
        "current_sum": "סכום נוכחי",
        "sum_left": "סכום שמאלי",
      },
      'email_sent': {
        'title': 'האימייל שלך נשלח!',
        'content': 'אנו נגיב בהקדם האפשרי!',
      },
      'congratulations': {
        'title': 'מזל טוב!',
        'content': 'סיימת את המטרה שלך, עבודה נהדרת!',
      },
    },

    "currency_list": {
      usd: "דולר",
      eu: "יורו",
      hrn: "גריוונה"
    },

    "bottom_bar": {
      "home": "בית",
      "settings": "הגדרות",
      "about_us": "עלינו",
    },

    'errors': {
      'name_too_short'           : 'שמך קצר מדי, בבקשה, הזן שם נכון!',
      'name_is_empty'            : 'שדה השם ריק, אנא, הזן שם נכון!',
      'email_not_valid'          : 'כתובת הדוא"ל שלך אינה תקפה, אנא הכנס נא דוא"ל תקף!',
      'email_is_empty'           : 'שדה הדוא"ל ריק, אנא הכנס את הדוא"ל הנכון!',
      'message_too_short'        : 'ההודעה שלך קצרה מדי, בבקשה, הזן הודעה נכונה!',
      'message_is_empty'         : 'שדה ההודעה ריק, בבקשה, הזן הודעה נכונה!',
      "goal_name_is_empty"       : "שדה שם המטרה ריק, בבקשה, הזן שם נכון!",
      "goal_image_is_empty"      : "לא בחרת את התמונה, בבקשה, בחר תמונה!",
      "goal_amount_is_empty"     : 'שדה סכום היעד ריק, אנא הכנס את הסכום הנכון!',
      "goal_current_sum_is_empty": 'שדה הסכום הנוכחי ריק, אנא הכנס את הסכום הנכון!',
      "goal_current_sum_bigger"  : "הסכום הנוכחי גדול מסכום היעד, בבקשה, הזן סכומים נכונים!",
      "goal_date_is_empty"       : "שדה שם התאריך ריק, אנא הכנס את התאריך הנכון!",
    }
  }
};

const Map<String,dynamic> russianLanguage = {
  "name": "Русский",
  "direction": "ltr",
  "locale": "ru",
  "content": {
    "main_page": {
      "page_title": "Цели",
      "create_first": "Создайте свою первую цель!",
      "expires": "До",
      "sort_widget": {
        "order_by": "Сортировать по",
        "name_sort": "Имени",
        "sum_sort": "Сумме",
        "create_date": "Дате создания",
        "finish_date": "Дате окончания",
        "finished_goals": "Завершенные цели"
      },
      "carousel": {
        "skip_block": "Пропустить",
        "first_page": "Нажмите на кнопку, чтобы создать цель",
        "second_page": "Напишите название цели, загрузите фото, напишите цену вашей цели",
        "third_page": "Когда вы нажимаете на цель, вы можете просмотреть всю информацию и добавить сумму к ней"
      }
    },
    "create_goal_page": {
      "page_title": "Создать цель",
      "name_title": "Название цели",
      "name_hint": "Твоя цель",
      "goal_image": "Изображение цели",
      "goal_amount": "Сумма цели:",
      "goal_hint": "Ваша сумма",
      "current_sum": "Текущая сумма которая есть:",
      "current_sum_hint": "Ваша текущая сумма",
      "current_date": "Собрать до:",
      'current_date_hint': 'Ваша дата',
      "button_text": "Создать"
    },
    "settings_page": {
      "page_title": "Настройки",
      "language_input": "Язык:",
      "currency_input": "Валюта:",
      "theme_input": "Тема:",
      "dark_theme": "Темная",
      "light_theme": "Светлая"
    },
    "about_page": {
      "page_title": "О нас",
      "write_us": "Напишите нам",
      "name_title": "Имя",
      "email_title": "Электронное почта",
      "message_title": "Сообщение",
      "name_hint": "Введите ваше имя",
      "email_hint": "Введите вашу почту",
      "message_hint": "Введите ваше сообщение",
      "button_text": "Отправить",
      "about_text": "AppVesto - американская компания, основанная израильскими предпринимателями. \n\nВ первый день мы выгравировали право и обязательство дать каждому частному клиенту или компании качественный ответ, первоклассный сервис, всесторонний и всесторонний анализ. Процесс разработки, который воплощает его идею в жизнь правильным, наиболее эффективным и быстрым способом. \n\nКаждый день нас возглавляет широкая сеть довольных клиентов из различных отраслей, которые продолжают работать вместе с нами над будущим их и их клиенты технологического развития."
    },
    "pop-ups": {
      "delete_pop-up": {
        "content": "Вы уверены, что хотите \n *удалить свою цель?*",
        "cancel_button": "Отмена",
        "remove_button": "Удалить"
      },
      "add_cash_pop-up": {
        "content": "Напишите *сумму*, которую вы хотите добавить в ",
        "cancel_button": "Отмена",
        "add_button": "Добавить",
        "current_sum": "Текущая сумма",
        "sum_left": "Осталось",
      },
      'email_sent': {
        'title': 'Ваше письмо было отправлено!',
        'content': 'Мы ответим вам как можно скорее!',
      },
      'congratulations': {
        'title': 'Поздравляем!',
        'content': 'Вы закончили свою цель, отличная работа!',
      },
    },

    "currency_list": {
      usd: "Доллары",
      eu: "Евро",
      hrn: "Гривны"
    },

    "bottom_bar": {
      "home": "Домой",
      "settings": "Настройки",
      "about_us": "О нас",
    },

    'errors': {
      'name_too_short'           : 'Введённое имя слишком короткое, пожалуйста, введите корректное имя!',
      'name_is_empty'            : 'Поле для имени пустое, пожалуйста, введите корректное имя!',
      'email_not_valid'          : 'Введённый e-mail не является валидным, пожалуйста, введите корректный e-mail!',
      'email_is_empty'           : 'Поле для e-mail пустое, пожалуйста, введите корректный e-mail!',
      'message_too_short'        : 'Введённое сообщение слишком короткое, пожалуйста, введите корректное сообщение!',
      'message_is_empty'         : 'Поле для сообщения пустое, пожалуйста, введите корректное сообщение!',
      "goal_name_is_empty"       : "Поле для названия цели пустое, пожалуйста, введите корректное имя",
      "goal_image_is_empty"      : "Вы не выбрали изображение цели, пожалуйста, выберите одно!",
      "goal_amount_is_empty"     : 'Поле для целевой суммы пустое, пожалуйста, введите корректное значение!',
      "goal_current_sum_is_empty": 'Поле для текущей суммы пустое, пожалуйста, введите корректное значение!',
      "goal_current_sum_bigger"  : "Текущая сумма больше целевой, пожалуйста, введите корректные значения!",
      "goal_date_is_empty"       : "Поле для даты пустое, пожалуйста, введите корректное значение!",
    }
  }
};


List<Map<String,dynamic>> languageMapList = [englishLanguage,hebrewLanguage,russianLanguage];

const usd = 'usd';
const eu  = 'eu';
const hrn = 'hrn';