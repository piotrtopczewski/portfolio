# Instrukcja: repozytorium GitHub i LinkedIn

## Co znajduje się w tym katalogu

- `**README.md**` — treść portfolio po polsku (nadaje się jako główny opis repozytorium na GitHub).
- Opcjonalnie możesz dodać własne pliki: CV w PDF, zrzuty ekranu, linki do demo.

## Utworzenie repozytorium na GitHub

1. Zaloguj się na [github.com](https://github.com).
2. **New repository** → nazwa np. `portfolio` lub `moje-portfolio` (może być publiczne).
3. **Nie** zaznaczaj „Add a README” jeśli wypchniesz lokalny katalog z gotowym `README.md`.
4. Lokalnie (w folderze zawierającym zawartość `portfolio`):

```bash
cd portfolio
git init
git add README.md 
git commit -m "Initial portfolio: QUADRACOGNI products and selected projects"
git branch -M main
git remote add origin https://github.com/TWOJA_NAZWA_UZYTKOWNIKA/TWOJE_REPO.git
git push -u origin main
```

*(Zamień `TWOJA_NAZWA_UZYTKOWNIKA` i `TWOJE_REPO` na własne wartości.)*

## GitHub „profile README” (opcjonalnie)

Żeby README wyświetlał się **na profilu** GitHub (nad repozytoriami), utwórz repozytorium o nazwie **identycznej** jak Twój login, np. `jan-kowalski/jan-kowalski`, z plikiem `README.md` w głównym katalogu. Możesz skróconą wersję skopiować z tego `README.md` lub dać link do pełnego repo portfolio.

## Powiązanie z LinkedIn

1. W profilu LinkedIn: sekcja **Kontakt** lub **Strona internetowa** — dodaj link:
  `https://github.com/TWOJA_NAZWA_UZYTKOWNIKA/TWOJE_REPO`
2. W sekcji **Projekty** / **Featured** możesz dodać ten sam link z krótkim tytułem, np. „Portfolio — GitHub”.
3. Jeśli pracujesz w QUADRACOGNI, możesz równolegle podać [quadracogni.ai](https://quadracogni.ai) jako stronę firmy / projekt.

## Uwagi

- Repozytorium **nie zawiera** kodu źródłowego klientów — tylko opisy publiczne i Twoje realizacje; przed dodaniem fragmentów kodu upewnij się, że nie naruszasz NDA.
- Jeśli promptujesz modele z listą projektów, trzymaj ten katalog zsynchronizowany z tym, co publikujesz na LinkedIn.

