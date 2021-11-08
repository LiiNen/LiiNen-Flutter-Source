<h1 align='center'> SW Maestro 12 Team B2K <br> 목표 달성을 위한 모임 연결 및 관리 플랫폼 '이건모임' </h1>
<h3 align='center'>Repository of App Application Developer (김정훈)</h3>
<div align='center'><table align='center'><tr><td align='center'>THIS PROJECT ABOUT..</td><td align='center'>Github</td><td align='center'>Contact to</td><td align='center'>Portfolio</td></tr><tr><td align='center'><img src="https://img.shields.io/badge/macOS 11.4-000000?style=flat-square&logo=MACOS&logoColor=white"/>
  <img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=FLUTTER&logoColor=white"/><br>
  <img src="https://img.shields.io/badge/Android Studio-3DDC84?style=flat-square&logo=ANDROIDSTUDIO&logoColor=white"/>
  <img src="https://img.shields.io/badge/Xcode-147EFB?style=flat-square&logo=XCODE&logoColor=white"/></td><td align='center'><a href="https://github.com/LiiNen"><img src="http://img.shields.io/badge/LiiNen-655ced?style=social&logo=github"/></a></td><td><a href="mailto:kjeonghoon065@gmail.com"><img src="https://img.shields.io/static/v1?label=&message=kjeonghoon065@gmail.com&color=green&style=flat-square&logo=gmail"></a></td><td align='center'><a href="https://liinen.github.io">⭐🌟😊🌟⭐</a></td></tr></table></div>

<br>

## Design (Zeplin, outsourcing)
<img src="https://raw.githubusercontent.com/LiiNen/LiiNen/main/images/flutter-b2k/design-zeplin.png">

<br>

## App Dev Overview (iOS simulator)
- **로그인 및 회원가입 일부**
<img src="https://raw.githubusercontent.com/LiiNen/LiiNen/main/images/flutter-b2k/pages1.jpg">

- **메인페이지 및 검색 페이지**
<img src="https://raw.githubusercontent.com/LiiNen/LiiNen/main/images/flutter-b2k/pages2.jpg">

- **알림 및 더보기 페이지**
<img src="https://raw.githubusercontent.com/LiiNen/LiiNen/main/images/flutter-b2k/pages4.jpg">

- **모임 개설 절차**
<img src="https://raw.githubusercontent.com/LiiNen/LiiNen/main/images/flutter-b2k/pages5.jpg">

- **모임 상세 기능**
<img src="https://raw.githubusercontent.com/LiiNen/LiiNen/main/images/flutter-b2k/pages3.jpg">

<br>

## Focused ON
- **기기 간 해상도 차이에 따른 자연스러운 UI 구성**

  해상도가 다른 여러 모바일 기기 간에 불편함, 이질감 없이 앱을 사용할 수 있도록 반응형과 유동적인 constraint를 사용하였습니다. 또한 Android, iOS 에뮬레이터(virtual machine) 뿐만 아니라 여러 실제 디바이스를 바탕으로 테스트를 진행하여 Widget의 constraint에서 overflow가 발생하지 않는 것을 확인했습니다.

- **백엔드 서버와의 비동기/동기 처리를 통한 데이터 표출**

  Swift의 {variable_type}? 과 같이 nullable 한 변수를 선언함으로서 백엔드의 요청 이후에 동작이 실행되도록 로직 구성 및 요청 실패 테스트를 완료하였습니다. 또한 서버와의 요청 과정에 방해받지 않도록 하는 circular progress bar 등을 사용하여 모든 작업에 있어 문제가 발생하지 않도록 사전에 방지 작업을 수행했습니다.

- **주요 동작에 대한 컴포넌트화**

  웹과 다르게 CSS 가 존재하지 않아 '*Collection.dart' 라는 파일명에 재사용이 가능한 여러 Widget 및 스타일, 함수를 선언해놓음으로서 반복적인 동작을 효율적으로 실행하도록 구현하였습니다. 또한 clubCard, boardBox 등 여러 컴포넌트들 또한 별도로 분리하여 추후 추가된 기능 요소에도 손쉽게 반영하여 작업 소요시간을 크게 단축시켰습니다.

- **App navigator에 대한 이해와 효율적인 동선 구현**

  모든 앱에 존재하는 Navigator에 대한 이해를 충분히 하여 백엔드와 여러 복잡한 로직 위에서도 자연스러운 앱 플로우를 제공할 수 있도록 push/pop을 적절히 수행하였습니다. 또한 navigatorPush라는 함수를 별도로 만들고 여러 파라미터를 적절히 추가함으로서 단순히 Navigator.push 를 넘어선 더욱 효율적이고 다양한 기능의 함수를 사용하였습니다.

- **전체적인 앱 플로우 검토**

  디자이너와의 협업 과정에서 Zeplin을 사용하고, 이를 바탕으로 빠짐없이 전수체크하며 모든 디자인 결과물을 앱으로 이전하고, 이에 맞춘 로직도 정상 동작함을 매번 확인하고 검토하며 완성했습니다. 또한 디자이너와 함께 협업 중에 페이지의 추가적인 요소나 기획 단계에서 놓친 페이지를 캐치하여 더욱 완성도 높은 앱을 구현하였습니다.

<br>

## 요구 사항
**최소 요구 사항**
> IDE: Visual Studio Code or Android Studio  
> Language: Dart 2.7~  
> Framework: Flutter  

optional (for iOS debugging)
> OS: macOS  
> IDE: Xcode

<br>

## 이용 방법
pubspec.yaml
```
dependencies:
  ccupertino_icons: ^1.0.2
  fluttertoast: ^8.0.7
  flutter_swiper: ^1.1.6
  http: ^0.13.3
  url_launcher: ^6.0.9
  shared_preferences: ^2.0.6
  image_picker: ^0.8.1+4
  flutter_signin_button: ^2.0.0
  permission_handler: ^8.1.2
  flutter_dotenv: ^5.0.0
  cached_network_image: ^3.1.0
  flutter_svg: ^0.22.0
  google_mobile_ads: ^0.13.3
  flutter_slidable: ^0.6.0
  webview_flutter: ^2.0.12
  jwt_decode: ^0.3.1
```

```shell
$ flutter pub get
$ flutter pub upgrade
```

m1 mac
```
$ vi ~/.zshrc
alias intel="arch -x86_64"
```
