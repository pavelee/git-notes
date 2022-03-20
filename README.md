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

Pierwsze podejście jest bardzo proste. Resetujemy nasze commity do tego co znajduję się na masterze. Następnie zmiany które nam wpadły commitujemy.

Resetujemy stan do mastera

```
git reset master
```

W tym momencie możemy wykonać commita i zweryfikować że nasza historia wygląda znacznie schludniej

```
git add . && git commit -m "my feature"
git log --graph
* commit 62182374b6460a36e8453b86e1ac552b22b81503 (HEAD -> feature2)
| Author: test <test@test.com>
| Date:   Sun Mar 20 16:38:55 2022 +0100
| 
|     my feature
| 
* commit 6e152b05d8d67a55769a42cf68888cad938d0efc (master)
| Author: test <test@test.com>
| Date:   Sun Mar 20 16:37:33 2022 +0100
| 
|     my feature3
| 
* commit 881b434a6ce6d70814e6f3df06e8f18f1563b642
  Author: test <test@test.com>
  Date:   Sun Mar 20 16:37:33 2022 +0100
  
      my feature1
```

#### Drugie podejście - git rebase w trybie interactive

Drugie podejście polega na wykorzystaniu inteaktywnego rebase, co pozwala nam wskazać aby połączyć commity

Rozpoczynamy od uruchomienia interaktywnego trybu rebase

```
git rebase -i master
```

Ukazuje nam się poniższy widok

```
pick a9c8fa6 my feature2
pick 0f391d1 my feature2 change 1
pick 4aed29e my feature2 change 2

# Rebase fcd014e..d0975c2 onto fcd014e (3 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup [-C | -c] <commit> = like "squash" but keep only the previous
#                    commit's log message, unless -C is used, in which case
#                    keep only this commit's message; -c is same as -C but
#                    opens the editor
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified); use -c <commit> to reword the commit message
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
```

To co musimy zrobić to wskazać że chcemy wykonać squash dla wszystkich commitów starszych od pierwszego który jest ponad masterem. Logika tutaj wskazuje gitowi że chcemy do tego commita załaczyć wszystkie pozostałe.

W tym przypadku zmieniamy pick na s (skrót od squash) dla wszysktkich commitów oprócz pierwszego ponad masterem. Tak jak poniżej

```
pick a9c8fa6 my feature2
s 0f391d1 my feature2 change 1
s 4aed29e my feature2 change 2

# Rebase fcd014e..d0975c2 onto fcd014e (3 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup [-C | -c] <commit> = like "squash" but keep only the previous
#                    commit's log message, unless -C is used, in which case
#                    keep only this commit's message; -c is same as -C but
#                    opens the editor
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified); use -c <commit> to reword the commit message
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
```

Zapisujemy wynik, jest to przekazywane do silinka gita

Następnie zobaczymy widok który prosi nas o wiadomość dla commita. Domyślnie jest to połaczenie wiadomości dla łączonych commitów. Możemy to zmodyfikować pod własne potrzeby.

```
# This is a combination of 3 commits.
# This is the 1st commit message:

my feature2

# This is the commit message #2:

my feature2 change 1

# This is the commit message #3:

my feature2 change 2

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Date:      Sun Mar 20 17:34:18 2022 +0100
#
# interactive rebase in progress; onto fcd014e
# Last commands done (3 commands done):
#    squash 0f391d1 my feature2 change 1
#    squash 4aed29e my feature2 change 2
# No commands remaining.
# You are currently rebasing branch 'feature2' on 'fcd014e'.
#
# Changes to be committed:
#       new file:   feature2
```

Finalnie mamy jednego commita i schludną historie zmian.