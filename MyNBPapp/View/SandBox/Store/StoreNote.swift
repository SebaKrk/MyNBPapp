//
//  File.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/09/2024.
//
//
//Główne przypadki, w których Kompozyt będzie przydatny w sklepie:
//
//    1.    Zestawy produktów: Jeśli w sklepie sprzedajesz zarówno pojedyncze produkty, jak i pakiety produktów (np. zestawy komputerowe, które składają się z procesora, monitora, klawiatury itp.), wzorzec Kompozyt pomoże Ci łatwo zarządzać tymi zestawami.
//    2.    Produkty z akcesoriami: Jeżeli niektóre produkty są sprzedawane z akcesoriami lub dodatkami (np. telefon z etui, ładowarką i słuchawkami), możesz grupować te produkty w opakowania i traktować je jako jeden produkt złożony.
//    3.    Elastyczne promocje: Promocyjne zestawy produktów, takie jak „kup 2, trzeci gratis” lub „zestawy rodzinne”, można łatwo zorganizować w formie opakowań, które będą zawierały inne produkty.
//    4.    Złożone produkty: Jeżeli sprzedajesz produkty, które same w sobie są złożone z innych elementów, np. meble (stół i krzesła jako jeden zestaw), wzorzec Kompozyt umożliwi ich łatwe zarządzanie w systemie.
//
//Korzyści z użycia Kompozytu w sklepie:
//
//    1.    Łatwe zarządzanie hierarchią produktów: Produkty mogą być pojedyncze lub złożone, ale dzięki temu, że wszystkie one implementują ten sam interfejs (Item w naszym przykładzie), możesz nimi zarządzać w jednolity sposób. Bez względu na to, czy użytkownik kupuje pojedynczy produkt, czy cały zestaw, logika aplikacji będzie taka sama.
//    2.    Rozszerzalność: Możesz łatwo dodawać nowe rodzaje produktów lub zmieniać istniejące produkty, bez modyfikacji kodu zarządzającego sprzedażą, wyświetlaniem czy obliczaniem ceny. Wystarczy dodać nową implementację interfejsu dla nowego typu produktu.
//    3.    Uniwersalność: Wzorzec pozwala na łatwe zagnieżdżanie produktów w opakowaniach (pakiety, zestawy). Klienci mogą kupować pojedyncze produkty albo zestawy produktów, a kod sklepu nie musi wiedzieć, co dokładnie zawiera opakowanie – po prostu operuje na abstrakcji.
//    4.    Elastyczne ceny: Możesz z łatwością obliczać ceny zarówno dla pojedynczych produktów, jak i dla opakowań zawierających inne produkty, co pozwoli na precyzyjne zarządzanie kosztami.
//
//Przykłady z życia:
//
//    1.    Amazon: Na platformach takich jak Amazon, użytkownicy mogą kupować pojedyncze produkty, ale także pakiety składające się z kilku produktów. Można stworzyć zestaw „idealny do kuchni”, zawierający blender, toster i zestaw noży. Wszystkie te elementy mogą być zarządzane jako odrębne produkty lub pakiety.
//    2.    Apple Store: W Apple Store, gdzie możesz kupować zarówno pojedyncze urządzenia (np. iPhone), jak i zestawy, które mogą obejmować dodatkowe akcesoria (ładowarka, etui), można użyć tego wzorca, aby obsłużyć zarówno pojedyncze elementy, jak i ich kombinacje.
//
//Możliwe wyzwania:
//
//    •    Skalowalność: Przy dużych zestawach produktów lub głębokich hierarchiach (np. pakiety w pakietach), trzeba zwrócić uwagę na wydajność i na to, jak system będzie obsługiwał takie zagnieżdżone struktury.
//    •    Złożoność zarządzania promocjami: Przy bardziej skomplikowanych modelach sprzedaży (np. dynamiczne promocje, cross-sell) będziesz potrzebować dodatkowej logiki, aby rozwiązać te kwestie, ale wzorzec Kompozyt może nadal być bazą do zarządzania hierarchią produktów.
//
//Czy Kompozyt to jedyny wzorzec, który warto rozważyć?
//
//Nie, w sklepie internetowym możesz potrzebować innych wzorców w zależności od specyficznych potrzeb, np.:
//
//    •    Wzorzec Dekorator: do dynamicznego dodawania funkcji (np. personalizacja produktu).
//    •    Wzorzec Fabryka: do tworzenia różnych wariantów produktów (np. różne konfiguracje sprzętu).
//    •    Wzorzec Obserwator: do zarządzania powiadomieniami o zmianach w dostępności produktów czy zmianach cen.
//
//Podsumowanie:
//
//Wzorzec Kompozyt to dobry wybór, jeśli tworzysz sklep, w którym produkty mogą być złożone z innych produktów lub mogą występować w zestawach. Pozwala on na łatwe zarządzanie zarówno pojedynczymi produktami, jak i opakowaniami w sposób jednolity, a także na elastyczne rozszerzanie systemu o nowe typy produktów.
