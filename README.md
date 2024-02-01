#  MyNPBapp
https://github.com/SebaKrk/MyNBPapp

## Zdanie roczne:
- uzyc The Composable Architecture
- interfejs Master-Detail
- aplikacja ma działac przynajmniej w dwoch jezykach pl/en
- swift Charts (szkolnie zespolu)
- implementacja serwisów/modeli/ do odzielnych framework
- sprawdzenie import Network oraz import OSLog
- logowanie FireBase
- zależności między framework-kami
- testy jednostkowe
- użycie Factory (wstrzykiwanie zależności)
- coreData , migracja do SwiftData
- funkcionalnosci na feture togla
- widget, na glowny ekran iPhona (np jakis kurs ulubionych walut)
- keychain
- push notfication 

******************************************************************

### IOS-00001 Implementacja Interfejsu użytkownika
    * A: Implementacja Interfejsu użytkownika (Basic)
    Po starcie aplikacji w zalenosci od urzadzenia ma pojawic sie TabView (iPhone) badz NavigationView (iPad)
    * B: Zmiana nazwa enum AppScreen na docelowe (pierwsze trzy główne widoki)

### IOS-0002 Inicjalizacja pakietów
    * A: Stworzenie pakietu `Serwis`
    Tu ma sie odbywac caly serwsi zwiazany z api NBP + ewentualnie innne serwsiy
    * B: Stworzenie pakietu `DataModels`
    Tu beda wszystkie modele 
    * C: Stworzenie pakiet `Commons`
    Pakiet do plikow extension, formaterow, constants
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
