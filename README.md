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

Możemy "wyprostować" historie git'a poprzez wykonanie rebase po zmergowaniu zmian.

### Uproszczenie gałęzi repozytorium



```
echo 'my changes' > feature1 && git add feature1 && git commit -m "my feature1"
git checkout -b feature2
echo 'my changes' > feature2 && git add feature2 && git commit -m "my feature2"
git switch master
echo 'my changes' > feature3 && git add feature3 && git commit -m "my feature3"
git switch feature2
git merge master # wykonujemy merge metoda rekursywną
```

Następnie zobaczmy jak wygląda drzewo po wykonaniu merga. Tak jak poniżej widać mamy wykonaną odnogę, która zaburza czytelność historii zmian.

```
git log --graph
*   commit 7c0ea2babcea93cbf3ad5f4365c95f309d784b28 (HEAD -> feature2)
|\  Merge: 47927a4 93fb3a2
| | Author: test <test@test.com>
| | Date:   Sat Mar 19 23:26:04 2022 +0100
| | 
| |     Merge branch 'master' into feature2
| | 
| * commit 93fb3a217bd353aba982ec2ef8d2be4262af8723 (master)
| | Author: test <test@test.com>
| | Date:   Sat Mar 19 23:25:12 2022 +0100
| | 
| |     my feature3
| | 
* | commit 47927a4c6d0cd05baf85a5640e3b2a7c74f5a5b3
|/  Author: test <test@test.com>
|   Date:   Sat Mar 19 23:24:21 2022 +0100
|   
|       my feature2
| 
* commit 5416a0fc30daa6d6274fe3134cc3e0c93ea796f7
  Author: test <test@test.com>
  Date:   Sat Mar 19 23:23:21 2022 +0100
```

Aby wyprostować historie wykonajmy rebase

```
git rebase master
```



### Łaczenie commitów


