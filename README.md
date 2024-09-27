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
    * F: Refactor Model, serwisu NBP, porzadki
        - porządki w CurrencyRateViewModel
        - porządki w CurrencyRate+EuroChart
    * (F): Rozwiazanie konfliktów z developem

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
    * A: UI CurrencyRateDetail
        - dodanie NavigationStack
        - dodanie horizontalSizeClass do MainView, CurrencyConverterView 
        - wstępny szkic CurrencyRateDetailView
    * B: Strzał do NBP
        - rozszsznie modeli o Equatable
    * C: Wybór zakresu daty w MainFeature 
    * D: Przekazanie danych z MainFeature do CurrencyRateDetailFeature
    * E: CurrencyRateDetailViewModel
        - nowa logika do ViewModelu
        - zmiana nazwy ContainerRateDetailFeature
        - dodany CurrencyChartViewFactory
    * F: Dependencies
        - utworzenie Dependencies w głównym
        - uporzadkowanie drzewia plików
        
### IOS-0017 CurrencyRateDetailView
    A: AxisMarks
        - tworzenie toggle switch dla AxisMarks
    B: Dodanie annotationSelectionView
    C: PeriodsCurrencyOption
        - przekaż `Periods`
        - dodać flagę `isExpand` do widoku wykresu
        - MainView zasilić widokiem 
        - Przy wybranym periods widoczne są tylko odpowiednie toggle 
        
### IOS-0018 Szczegóły waluty
    A: Budowanie UI
        - hardcore data
    B: Budowanie UI cz.2
        - wydzielenie ChartView oraz TableView do odizlenycch klas.
        - dostarczenie poprawnych danych z NBP data C.
    C: Aktualizacja typów zmiennych
        - zmiana typu zmiennej i rzutowania typów: `RatesC`

### IOS-0019 Rozbudowa widoku `CurrencyRateDetailView`
    A: Rozróżnienie miedzy RateA a RateC
        - piaskownica 

### IOS-0020 Wybór kursu walutowego w z `MainFeature`
    A: Obsługa zapytania w zależności od wybranego kursu 
    B: Poprawka stanu oraz akacji
        - selectedCurrency: MainCurrencyState
        - tytuł kontenera chart by hardcode, roszenie `MainCurrencyState` o subtitle
        - przekazanie wybranej waluty przez feature-y
    C: Opcje dla bid oraz ask

### IOS-0021 `WidgetKit`
    A: Stworzenie Widgetu z mok-owymi danymi 
    B: Wstępna implantacja api, przekazanie rzeczywistych danych do widgetu
        - wydzielenie plików
    C: Poprawa cześci serwisowej
    D: `AppIntents` / WidgetConfigurationIntent
     - Rozdzielenie starej części od nowej związanej z AppIntents
     - Zapytanie api musi być asynchroniczne
     - Opcja edycji widgetu , przekazania innych parametrów
     - ColoredWidget test
     - dodanie metod odnośnie rysowania chartow (pózniej wydzielić do VM)
     - rozszerzenie WidgetEntryConfiguration o `WidgetColor: AppEntity`
     
### IOS-0022 iPhone UI
    A: Dostosowanie UI do iPhone 
    
### IOS-0023 TCA `Stack-based navigation`
    A: SandBox - navigation TCA
    B: SandBox - Favorites flow
    - save data
    - swipe action
    - add to favorites
    C: SandBox CoreData cz.1
    - https://www.youtube.com/watch?v=BPQkpxtgalY
    D: Sandbox CoreData cz.2
    - https://www.youtube.com/watch?v=huRKU-TAD3g

### IOS-0024 ChatGPT 
    A: SandBox - ChatGPT
    B: Testing 
    - create new network call 
    - cleanup the code
    - testing MapKit
    C: SandBox&Upgrade
    - Upgrade Xcode Beta 16.1
    - Upgrade TCA 1.13
    - SandBox MapKit
    D: PointOfInterest
    - UIViewRepresentable MKMapView - Map(SwiftUI)
    - Map MKMapItem to MKPlacemark and show on MapView
    - Add a button to toggle between maps
    
### IOS-0025 GitIgnore
    - add git ignore file

### IOS-0026 MapView SwiftUI
    A: Create a list displaying places
    - implement MapSelection<MKMapItem>?
    - SearchResultsListView - create new cell
    B: Add filters options
    - sort by distance
    C: Add filters by category
    - pass category data to FiltersPlaceView
    - handle selected category
    D: Cleanup project folders / Refactor
    - create Factories for different MapView
    - Create a MainViewModel to manage search results, handle user interactions, and coordinate data flow
    - Create Singleton to manage CLLocationManager
    - Refactored SearchService and add DocC documentation (testing)
    E: Create POI Buttons
    
### IOS-0027 Paymnet, #CodingPatterns
    A: Create paymnet service
    - Used Abstract Factory
    B: Refactor state management in PaymentViewModel
    C: Implemented Bridge pattern for color abstraction in PaymentActionButton #StructuralPatterns
    -  Applied Bridge pattern to decouple color handling from button logic
    - Enhanced flexibility by allowing different color strategies without modifying button structure
    D: Test
