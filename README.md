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

Wykonaj poniższe polecenia aby zasymulować sytuacje kiedy powstają zmiany podczas naszej pracy na innym branchu.

```
chmod +x recursive_merge_booster1.sh && ./recursive_merge_booster1.sh
```

Następnie zobaczmy jak wygląda drzewo po wykonaniu merga. Tak jak poniżej widać mamy wykonaną odnogę, która zaburza czytelność historii zmian.

```
cd recursive_merge_booster_example1
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
  
      my feature1
```

Aby wyprostować historie wykonajmy rebase

```
git rebase master
```

Poniżej widać poprawę czytelności historii zmian po wykonaniu rebase.

```
cd recursive_merge_booster_example1
git log --graph
* commit 12a9b3a59045631ff01bdf6c6803b077091dce06 (HEAD -> feature2)
| Author: test <test@test.com>
| Date:   Sat Mar 19 23:24:21 2022 +0100
| 
|     my feature2
| 
* commit 93fb3a217bd353aba982ec2ef8d2be4262af8723 (master)
| Author: test <test@test.com>
| Date:   Sat Mar 19 23:25:12 2022 +0100
| 
|     my feature3
| 
* commit 5416a0fc30daa6d6274fe3134cc3e0c93ea796f7
  Author: test <test@test.com>
  Date:   Sat Mar 19 23:23:21 2022 +0100
  
      my feature1
```

### Łaczenie commitów

W momencie kiedy podczas pracy wykonujemy commity może zajeść sytuacja że chielibyśmy uporządkować naszą historie i wszystkie zmiany złączyć do jednego commita.

W pierwszej kolejności zasymulujmy przypadek takiej sytuacji

```
chmod +x recursive_merge_booster2.sh && ./recursive_merge_booster2.sh
```

Następnie zobaczmy jak wygląda drzewo

```
cd recursive_merge_booster_example2
git log --graph
*   commit 5dc3b6c058ae2c2eaee289feb43439a1c6fc5a19 (HEAD -> feature2)
|\  Merge: 1e772ad 8e045bf
| | Author: test <test@test.com>
| | Date:   Sun Mar 20 15:03:16 2022 +0100
| | 
| |     merge master
| | 
| * commit 8e045bf89b0cd7c29d2083b7c92f2d7df7b44e4c (master)
| | Author: test <test@test.com>
| | Date:   Sun Mar 20 15:03:16 2022 +0100
| | 
| |     my feature3
| | 
* | commit 1e772adfd9c458076891529605407259d157825e
| | Author: test <test@test.com>
| | Date:   Sun Mar 20 15:03:16 2022 +0100
| | 
| |     my feature2 change 2
| | 
* | commit 6bbc5c6d6db73b83c94dd1d57f8fc25183c5f2cb
| | Author: test <test@test.com>
| | Date:   Sun Mar 20 15:03:16 2022 +0100
| | 
| |     my feature2 change 1
| | 
* | commit 8882da704171a990e627bdac0157d6ffd766e59f
|/  Author: test <test@test.com>
|   Date:   Sun Mar 20 15:03:16 2022 +0100
|   
|       my feature2
| 
* commit bfaf512bbd24c9fb315800a7e4d3723843b07b6e
  Author: test <test@test.com>
  Date:   Sun Mar 20 15:03:16 2022 +0100
  
      my feature1
```

Analogicznie do poprzedniego przykładu, wyprostujmy drzewo i wykonajmy rebase

```
git rebase master
```

Sprawdźmy wynik w postaci drzewa po wykonaniu rebase

```
cd recursive_merge_booster_example2
git log --graph
* commit c4a7ba184686bebc097d27928a137bdb4bdf9676 (HEAD -> feature2)
| Author: test <test@test.com>
| Date:   Sun Mar 20 15:03:16 2022 +0100
| 
|     my feature2 change 2
| 
* commit 00cc4b8a1eb348fb2135fa5364d473750ab75b01
| Author: test <test@test.com>
| Date:   Sun Mar 20 15:03:16 2022 +0100
| 
|     my feature2 change 1
| 
* commit 11d71c79bfba10e90cf0cbaaaab8bc03006ad561
| Author: test <test@test.com>
| Date:   Sun Mar 20 15:03:16 2022 +0100
| 
|     my feature2
| 
* commit 8e045bf89b0cd7c29d2083b7c92f2d7df7b44e4c (master)
| Author: test <test@test.com>
| Date:   Sun Mar 20 15:03:16 2022 +0100
| 
|     my feature3
| 
* commit bfaf512bbd24c9fb315800a7e4d3723843b07b6e
  Author: test <test@test.com>
  Date:   Sun Mar 20 15:03:16 2022 +0100
  
      my feature1
```

Tak jak widać na powyższym listingu jesteśmy trzy commity ponad gałęzią master.

Założmy że nasz współpracownik poprosił nas abyśmy troche upodządkowali nasze zmiany i złaczyli w jednego commita

#### Pierwsze podejście - wykonanie git reset i ponowny commit

Pierwsze podejście jest bardzo proste. Resetujemy nasze commity do tego co znajduję się na masterze. Następnie zmiany które nam wpadły 