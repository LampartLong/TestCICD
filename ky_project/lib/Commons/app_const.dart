const authorization  = "Bearer ";

//Home screen
const lblHome = "ホーム";
const lblNotification = "お知らせ";
const lblRecord = "記録";
const lblSchedule = "スケジュール";
const lblSettings = "設定";

//Notification screen
const appBarTitle = "お知らせ";
const popupTitle = "タイトル";
const listNotificationEmptyLabel = "お知らせはありません";
const listNotificationErrorLabel = "エラーが発生しました";
const formatDate = "yyyy年 MM月 dd日";

//Enter Account Info screen
const enterAccountInfoAppBarTitle = "新規アカウント登録";
const emailMaxLength = 256;
const passwordMaxLength = 50;
const showErrorRedLetterType = 0;
const showErrorPopupType = 1;
const hntEmail = "メールアドレスを入力";
const lblEmail = "メールアドレス";
const hntEmailConfirm = "確認のため再入力";
const lblEmailConfirm = "メールアドレス（確認のため再入力）";
const hntPassword = "パスワードを入力";
const lblPassword = "パスワード";
const lblPasswordTooltip = "パスワードは最低でも8文字以上である必要があります。\n パスワードは英字の大文字と小文字、数字、特殊文字（例: !@#\$%^&*）の組み合わせを含む必要があります。";
const hntPasswordConfirm = "確認のため再入力";
const lblPasswordConfirm = "パスワード（確認のため再入力）";
const lblTermsOfService = "利用規約";
const lblPrivacyPolicy = "個人情報保護方針";
const lblAgreeCheckBox = "利用規約および個人情報保護方針に同意する";
const lblCreateAccountButton = "登録";
const regExpEmail =
    r"^([a-z0-9\+\_\-\.\/\?\!\%\&\~\#\$\'\*\=\^\{\}\|]+)([a-z0-9\+\_\-\.\/\?\!\%\&\~\#\$\'\*\=\^\{\}\|]*)@([a-z0-9\-]+\.)+[a-z]{1,64}$";
const regExpPassword =
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
const errEmailInvalidate =
    "無効なメールアドレス形式です。正しい形式で入力してください。例: example@example.com\nメールアドレスの長さ制限は最大256文字です。";
const errFieldEmpty = "必須項目が未入力です。すべての必須情報を入力してください。";
const errPasswordInvalidate = "パスワードには、英字、数字、特殊文字を組み合わせたものを8文字以上50文字以内含めてください。";
const errEmailConfirmNotMatch = "メールアドレスと確認用メールアドレスが一致しません。";
const errPasswordConfirmNotMatch = "パスワードと確認用パスワードが一致しません。";
const errConnectServer = "メールアドレス登録に失敗しました。インターネット接続を確認して、もう一度お試しください。";
const errOther = "エラーが発生しました。もう一度お試しください。";
const emailField = "mailaddress";
const passwordField = "password";

//Check Onetime Code screen
const appBarTitleCheckOnetimeCode = "認証コードを入力";
const checkOneTimeCodeLabel = "に認証コードを送信しました。\n認証コードを入力してください。";
const checkOneTimeCodeResendBtn = "認証コードを再送する";
const checkOneTimeCodeConfirmBtn = "確認";
const checkOneTimeCodeInfoBtn = "認証コードがまだ届いていない場合";
const checkOneTimeCodeHintMsg = "1. 送信までに数分かかる場合がありますので、しばらくお待ちください。\n2. 迷惑メールフォルダに入っている可能性があります。\n3. お使いのメールアドレスに誤りがある可能性があります。正しいメールアドレスを入力し、再度リクエストしてください。";
const checkOneTimeCodeDialogMsg = "認証コードを再送しました";
const checkOneTimeCodeDialogBtn = "閉じる";
const errInvalidCode = "無効な認証コードです。コードを再度確認し、正確に入力してください。";
const errEmptyPINCode = "6桁の認証コードを入力してください。";

//Complete Register Account screen
const completeRegisterAccountAppBarTitle = "アカウント登録完了";
const lblCreateAccountSuccess = "アカウント登録を完了しました";
const lblTopBack = "ログイン画面へ";

//Forgot Password
const passwordResetAppBarTitle = "パスワードの再設定";
const passwordResetLabel = "登録しているメールアドレスを入力してください。\n認証コードをメールで送信します。";
const passwordResetBtn = "送信";
const passwordResetConfirmAppbarTitle = "パスワードの再設定";
const passwordResetConfirmLabel = "に認証コードを送信しました。\n認証コードを入力してください。";
const passwordResetConfirmPinLbl = "認証コード";
const passwordResetConfirmPasswordLbl = "新しいパスワード";
const passwordResetConfirmPasswordConfirmLbl = "新しいパスワード（確認のため再入力）";
const passwordResetConfirmBtn = "新しいパスワードを設定";
const codeField = "code";
const passwordResetConfirmPasswordHint = "新しいパスワードを入力";
const passwordResetConfirmPasswordConfirmHint = "確認のため再入力";

//Password Reset Complete screen
const passwordResetCompleteAppBarTitle = "パスワードの再設定完了";
const lblPasswordResetSuccess = "パスワードが変更されました。";

//Top screen
const lblGreeting = "〇〇さん、こんにちは！";
const formatDateNoSpace = "yyyy年MM月dd日";
const formatDateTop = "yyyy.MM.dd";
const lblTodayPlan = "本日の予定";
const lblDocument = "文書の管理";
const lblDocumentDescription = "同意書など大切な文書を保存することができます。";
const lblRecordButton = "本日の記録をする";
const lblScheduleButton = "予定を確認する";
const lblDocumentButton = "文書を管理する";
const weekdays = ["月", "火", "水", "木", "金", "土", "日"];

//Login screen
const logo = "assets/image/logo.png";
const lblLoginButton = "ログイン";
const lblRegisterAccountButton = "新規アカウント登録";
const lblForgotPassword = "パスワードを忘れた方：";
const lblForgotPasswordLink = "パスワード再発行";
const lblRegisterAccount = "アカウント登録がまだの方：";
const errLoginConnectServer = "ログインに失敗しました。インターネット接続を確認して、もう一度お試しください。";
const errLoginOther = "エラーが発生しました。再度ログインしてください。";

//Schedule screen
const formatDateRequestApi = "yyyy-MM-dd";
const formatDateSchedule = "yyyy年MM月dd日";
const formatHour = "yyyy年MM月dd日";
const lblActionButtonSchedule = "予定";
const lblActionButtonRecord = "記録";
const listScheduleDayEmptyLabel = "予定なし";
const reservationType = "reservation";
const recordType = "record";
const deviceType = "device";
const calendarName = "ky_calendar";

//events
const backPageEvent = "back_page_event";
const pushPageEvent = "push_page_event";

//key local storage
const fkToken = "fk_token";
const fkMailAddress = "fk_mail_address";
const fkPassword = "fk_password";
const fkCalendar = "fk_ky_calendar";
