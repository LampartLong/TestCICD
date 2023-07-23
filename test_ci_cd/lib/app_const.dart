const authorization = "Bearer ";

//Home screen
const lblHome = "ホーム";
const lblNotification = "お知らせ";
const lblRecord = "記録";
const lblSchedule = "スケジュール";
const lblSettings = "設定";
const backgroundBeige1 = "assets/image/beige1.png";
const lblPleaseWait = "しばらくお待ちください。";

//Notification screen
const appBarTitle = "お知らせ";
const popupTitle = "タイトル";
const listNotificationEmptyLabel = "お知らせはありません";
const listNotificationErrorLabel = "エラーが発生しました";

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
const regExpEmail = r"^([a-z0-9\+\_\-\.\/\?\!\%\&\~\#\$\'\*\=\^\{\}\|]+)([a-z0-9\+\_\-\.\/\?\!\%\&\~\#\$\'\*\=\^\{\}\|]*)@([a-z0-9\-]+\.)+[a-z]{1,64}$";
const regExpPassword = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
const errEmailInvalidate = "無効なメールアドレス形式です。正しい形式で入力してください。例: example@example.com\nメールアドレスの長さ制限は最大256文字です。";
const errFieldEmpty = "必須項目が未入力です。すべての必須情報を入力してください。";
const errPasswordInvalidate = "パスワードには、英字、数字、特殊文字を組み合わせたものを8文字以上50文字以内含めてください。";
const errEmailConfirmNotMatch = "メールアドレスと確認用メールアドレスが一致しません。";
const errPasswordConfirmNotMatch = "パスワードと確認用パスワードが一致しません。";
const errCreateAccountConnectServer = "メールアドレス登録に失敗しました。インターネット接続を確認して、もう一度お試しください。";
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
const formatDateRequestApiSecondary = "yyyy-MM-ddTHH:mm";
const lblActionButtonSchedule = "予定";
const lblActionButtonRecord = "記録";
const listScheduleDayEmptyLabel = "予定なし";
const dialogConfirmDeleteScheduleMsg = "スケジュールを削除 しますか？";
const reservationType = "reservation";
const recordType = "record";
const deviceType = "device";
const calendarName = "ky_calendar";

//Record screen
//Record reservation screen
const reservationMaxLength = 20;
const clinicMaxLength = 50;
const doctorMaxLength = 20;
const memoMaxLength = 300;
const recordReservationAppBarTitle = "予約を登録";
const lblReservation = "タイトル";
const reservationHint = "タイトルを入力";
const lblClinic = "クリニック名";
const clinicHint = "クリニック名入力";
const lblDoctor = "担当医師";
const doctorHint = "担当医師を入力";
const memoHint = "メモ";
const reservationField = "title";
const startDateTimeField = "start_datetime";
const endDateTimeField = "end_datetime";
const clinicField = "clinic_name";
const doctorField = "doctor_name";
const memoField = "memo";
const lblSelectDocument = "文書";
const lblSelectDocumentButton = "文書を選ぶ";
const lblSelectFromDeviceButton = "ファイルを選択";
const lblSelectFromDocumentButton = "書類から選ぶ";
const lblDeleteButton = "削除";
const lblSaveButton = "保存";
const lblCloseDialogButton = "閉じる";
const lblStartDate = "開始日";
const lblStartTime = "開始時間";
const lblEndDate = "終了日";
const lblEndTime = "終了時間";
const lblDialogSelectTime = "開始時間を設定";
const lblDialogButtonCancel = "キャンセル";
const lblDialogButtonAccept = "保存";
const errBlankField = "タイトルを入力してください。";
const errConnectServer = "ロインターネット接続を確認して、もう一度お試しください。";
const errInvalidDateTime = "無効な日時範囲です。開始日時は終了日時よりも前に設定してください。";
const errFileSizeLarger = "ファイルのサイズが大きすぎます。ファイルサイズは5MBまでです。";
const fileValidFormat = ['jpeg', 'jpg', 'png', 'pdf', 'doc', 'txt'];
const recordPageType = 1;
const reservationPageType = 2;
//Record memo
const lblButtonOpenCamera = "写真を撮る";
const lblButtonOpenPicture = "写真を選ぶ";
const lblCompareButton = "画像を比較する";
const lblDialogConfirmDeleteRecord = "の画像とメモを削除 しますか？";
const errRecordBlankField = "必須項目が未入力です。保存するため画像かメモを追加してください。";
const warningMaximumFileSelected = "画像を最大３枚まで追加できます";
const maximumFileSelected = 3;
const photoActionCreate = "create";
const photoActionDelete = "delete";

//Compare photo
const comparePhotoAppBarTitle = "記録を比較";
const comparePhotoAPhotoBtn = "A写真を選ぶ";
const comparePhotoBPhotoBtn = "B写真を選ぶ";
const comparePhotoMouthBtn = "口";
const comparePhotoFaceBtn = "輪郭";
const comparePhotoEyeBtn = "目";
const comparePhotoNoseBtn = "鼻";
const comparePhotoMouthType = 0;
const comparePhotoFaceType = 1;
const comparePhotoEyeType = 2;
const comparePhotoNoseType = 3;
const comparePhotoActionDownload = "画像をダウンロード";
const comparePhotoActionShare = "画像をシェア";

//Record camera page
const recordCameraCancelBtn = "キャンセル";
const recordCameraAppbarTitle = "正面を撮影する";
const recordCameraGuideFront = "・顔を中心にフレームに収めて正面を向いて撮影してください。\n・無背景（無地・白色等)で撮影してください。\n・明るい場所で撮影することを心がけましょう。";
const recordCameraGuideLeft = "・顔を中心にフレームに収めて左を向いて撮影してください。\n・無背景（無地・白色等)で撮影してください。\n・明るい場所で撮影することを心がけましょう。";
const recordCameraGuideRight = "・顔を中心にフレームに収めて右を向いて撮影してください。\n・無背景（無地・白色等)で撮影してください。\n・明るい場所で撮影することを心がけましょう。";
const recordCameraFrontBtn = "正面を撮影する";
const recordCameraLeftBtn = "左斜めを撮影する";
const recordCameraRightBtn = "右斜めを撮影する";
const recordCameraRetakeBtn = "撮り直す";
const recordCameraSelectTypeBtn = "撮影を続ける";
const recordCameraDialogTitle = "顔の向きを選んでください";
const recordCameraFinishBtn = "撮影終了";

const recordCameraGuideTypeFront = 0;
const recordCameraGuideTypeLeft = 1;
const recordCameraGuideTypeRight = 2;

//events
const backPageEvent = "back_page_event";
const pushPageEvent = "push_page_event";
const showCalendarDayEvent = "show_calendar_day_event";

//key local storage
const fkToken = "fk_token";
const fkMailAddress = "fk_mail_address";
const fkPassword = "fk_password";
const fkCalendar = "fk_ky_calendar";
