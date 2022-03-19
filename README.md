# Notatki na temat git

## Utworzenie lokalnego repozytorium

Aby utworzyć repozytorium git'a wystarczy wykonać polecenie

```
git init
```

W odpowiedzi dostajemy zwrotkę

```
Initialized empty Git repository in HERE_YOUR_REPO_FOLDER_PATH
```

Spróbuj sam! Otwórz terminal i wykonaj polecenia:

```
cd ~ # przejście do domowego katalogu
mkidr myrepo # utworzenie katalogu na nasze repozytorium
cd myrepo # przechodzimy do folderu
git init # inicujemy swoje repozytorium!
```

## Git Rebase

Podczas pracy tworzymy nowe branche aby z boku przygotować zmiany. W tym samym czasie inni dev wrzucają swoje zmiany, co skutkuję potrzebą mergowania w trybie recursive. Finalnie nasze drzewo zaczyna wyglądać chaotycznie.

### Uproszczenie gałęzi repozytorium

```
git fetch origin/master
git merge master
git rebase master
```

### Łaczenie commitów


