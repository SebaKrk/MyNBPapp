#  MyNPBapp
https://github.com/SebaKrk/MyNBPapp

## Zdanie roczne:
- uzyc The Composable Architecture
- interfejs Master-Detail
- aplikacja ma działać przynajmniej w dwóch językach pl/en
- swift Charts (szkolnie zespołu)
- implementacja serwisów/modeli/ do oddzielnych framework
- sprawdzenie import Network oraz import OSLog
- logowanie FireBase
- zależności między framework-kami
- testy jednostkowe
- użycie Factory (wstrzykiwanie zależności)
- coreData , migracja do SwiftData
- funkcionalnosci na feture togla
- widget, na główny ekran iPhona (np jakiś kurs ulubionych walut)
- keychain
- push notfication 

******************************************************************

### IOS-00001 Implementacja Interfejsu użytkownika
    * A: Implementacja Interfejsu użytkownika (Basic)
        - Po starcie aplikacji w zależności od urządzenia ma pojawić się TabView (iPhone) bądź NavigationView (iPad)
    * B: Zmiana nazwa enum AppScreen na docelowe (pierwsze trzy główne widoki)

### IOS-0002 Inicjalizacja pakietów
    * A: Stworzenie pakietu `Serwis`
        - Tu ma się odbywać cały serwis związany z api NBP + ewentualnie inne serwisy
    * B: Stworzenie pakietu `DataModels`
        - Tu beda wszystkie modele 
    * C: Stworzenie pakiet `Commons`
        - Pakiet do plików extension, formaterów, constants
    * D: Zależności miedzy pakietami
    * E: Stworzenie pakiet `MonumentKit`
    
### IOS-0003 Dodanie biblioteki `The Composable Architecture`
    * A: TCA wersja 1.6.0 

### IOS-0004 Dodanie pliku do tłumaczeń
    * A: Utworzenie String Katalog w projekcie
    * B: Uzupełnienie tłumaczenia PL
    
### IOS-0005 `MonumentKit`
    * A: Prototypowanie Funkcjonalności MonumentKit
    * B: Wstępna Implementacja

### IOS-0006 Budowa widoku `MainView`
    * A: Wstępna budowa UI
    
### IOS-0007 TCA Account
    * A: Account Feature
    * B: Settings Feature
    * C: Dodanie biblioteki `Factory`
    * D: Dodanie `@Reducer` macro

### IOS-0008 Serwis NBP
    * A: Stworzenie serwisu, wstępna implementacja
    * B: Stworzyć `Dependencies` w pakietu `Service`
    - uzupełnij zależności miedzy pakietami
    * C: Wstępnie wykorzystanie danych z Swift Charts
    - euro widget
    - euro rate chart
    - pomocnicze funkcje w view modelu
    * D: Uzupełnienie pakietu `Commons` o formatowanie daty
### IOS-0009 `WidgetKit`
    * A: Stworzenie WidgetNBP
    - dodanie nowego targetu
    * B: Dodanie mock serwisu

### IOS-0010 `Swift OpenAPI Generator`
    * A: Dodanie pakietu zależność
    - stworzenie pakietu client - exchangeRateAPI
    https://github.com/APIs-guru/openapi-directory/blob/main/APIs/1forge.com/0.0.1/swagger.yaml
    - `Swift OpenAPI Generator`
    - `URLSession Transport for Swift OpenAPI Generator`
    - `Swift OpenAPI Generator Runtime` 
    * B: Wstępne testowanie api
    - dodanie i wyświetlenie danych na iście

### IOS-0011 upgrade `The Composable Architecture`
    * A: Migrating to 1.7.3
    - ViewAction
    - @ObservableState
    - ReducerOf<Self>
    - add additional TestFeature
    
### IOS-0012 Lista kursów walut
    * A: UI listy kursów
    * B: Refactor wyglądu aplikacji
    * C: Wydzielenie nowych Feature z MainFeature
        - CurrencyConverterFeature
    * D: Dodanie feature toggle isMultipleSourcesEnabled
    * E: Stworzenie MarketRate

### IOS-0014 TCA Navigation
    * A: Navigation
        - Your first presentation 
    * B: Multiple presentation destinations
    * C: Migration to TCA 1.8.2
        - clean up the TCA code
    * D: Improve domain modeling
    
### IOS-0015 Uporzadkowanie drzewa plików
    * A: Uporzadkowanie drzewa plików

### IOS-0016 CurrencyRateDetailFeature
    * A: dodanie NavigationStack
        - dodanie horizontalSizeClass do MainView, CurrencyConverterView 

