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

### IOS-0002 Inicjalizacja framework Serwis
    * A: Stworzenie framework Serwis
    Tu ma sie odbywac caly serwsi zwiazany z api NBP + ewentualnie innne serwsiy
