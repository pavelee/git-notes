#!/bin/sh

rm -rf recursive_merge_booster_example2
mkdir recursive_merge_booster_example2 && cd recursive_merge_booster_example2
git init # init git repository
git config user.name test # change user name
git config user.email test@test.com # change user email
echo 'my changes' > feature1 && git add feature1 && git commit -m "my feature1"
git checkout -b feature2
echo 'my changes' > feature2 && git add feature2 && git commit -m "my feature2"
echo 'my changes' >> feature2 && git add feature2 && git commit -m "my feature2 change 1"
echo 'my changes' >> feature2 && git add feature2 && git commit -m "my feature2 change 2"
git switch master
echo 'my changes' > feature3 && git add feature3 && git commit -m "my feature3"
git switch feature2
git merge master -m "merge master" # wykonujemy merge metoda rekursywną