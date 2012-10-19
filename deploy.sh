#!/bin/bash -e

cabal clean
cabal configure
cabal build

strip dist/build/site/site

rsync -avz -e ssh --exclude '.*'    \
                  --exclude '*.aes' \
                  --exclude 'dist'  \
                  ../smallest patrick@thesmallestyesodapp.com:~/

ssh patrick@thesmallestyesodapp.com '
  kill -9 $(pgrep site); cd ./smallest &&
  bash -c "nohup ./site &>/dev/null </dev/null &" &&
  sleep 3
'
