> # Buscacep

>:warning: This project is a challenge for a job vacancy.

See:

    root
    ....├─ AppIcons.zip
    ....├─ preview.png
    └─ src
    ....└─ REQUIREMENTS.md // Here you can find the details of the challenge.

> ## The Project:

A simple application that allows you to consult zip codes..

* Preview:

![Preview](/src/preview.png)

> ## Good habits:

The project as a whole was designed to follow good programming practices, including project creation:

    flutter create busca_cep --platforms android,ios --org br.com.busca_cep

[Esse erro simples pode CUSTAR sua vaga de Flutter](https://www.youtube.com/watch?v=_wGqTXhAgMM)

Clean arch was used for the architecture, with the aim of reducing code coupling, and other designer patterns such as [ADAPTER](https://medium.com/flutter-community/flutter-design-patterns-2-adapter-3f05c02a7c84).

> ## Features:

* Darkmode;
* Error Handling (even without connection like airplane mode);
* Local bank consumption;
* l10n;

> ## Arch ([Clean Architecture](https://github.com/Flutterando/Clean-Dart)):

Architecture example:

    root
    └─ lib
    ....├─ l10n
    ........├─ app_en.arb
    ........└─ app_pt.arb
    ....├─ modules
    ........└─ home
    ............├─ domain
    ............├─ infra
    ............├─ presenter
    ............└─ home_module.dart
    ....├─ shared
    ........├─ core
    ........└─ widgets
    ....├─ app_module.dart
    ....├─ app_widget.dart
    ....└─ main.dart

> ## Endpoint:

api: http://viacep.com.br

> ## Dependencies:

* Flutter version: 3.13.6;
* Dart version: 3.1.3

Flutter packages:

    bloc: ^8.1.2
    dio: ^5.3.3
    flutter_bloc: ^8.1.3
    flutter_localizations:
      sdk: flutter
    flutter_modular: ^6.3.2
    http: ^1.1.0
    meta: ^1.9.1
    sqflite: ^2.3.0
    fpdart: ^1.1.0
    path: ^1.8.3

Flutter dev packages:

    bloc_test: ^9.1.4
    mocktail: ^1.0.1

> ## Framework and Tools:

* Flutter 3.3.0;
* Dart 3.1.3
* Android Studio Giraffe | 2022.3.1

> ## Possible improvements:

As the author of this project, for the love and care given to it, I would like to include here possible improvements that could be applied in the future, due to the end of the time available to me to carry it out.

* End of unit tests ([LocalAddressDatasource](/lib/modules/home/infra/datasources/local_address_datasouce.dart));
* Creation of Widget tests ([HomePage](/lib/modules/home/presenter/pages/home_page.dart) and [ResultPage](/lib/modules/result/presenter/pages/result_page.dart));
* Creation of the integration test (Possibly using PATROL);

https://pub.dev/packages/patrol

https://patrol.leancode.co/

* Restoration of the project for MULTI REPO (with MELOS);

https://pub.dev/packages/melos

https://melos.invertase.dev/

* Termination of the internationalization application (see extension [AppClientErrorMessage](/lib/shared/core/client/validations/app_client_error.dart));

> ## License:

    MIT License

    Copyright (c) 2022 Matheus Ferreira

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
