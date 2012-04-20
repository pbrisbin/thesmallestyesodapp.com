#!/bin/bash -e

ghc -XQuasiQuotes \
    -XTypeFamilies \
    -XTemplateHaskell \
    -XMultiParamTypeClasses \
    -XOverloadedStrings \
    --make -o site site.hs

rsync -avz -e ssh --exclude '.*'    \
                  --exclude '*.o'   \
                  --exclude '*.hi'  \
                  --exclude '*.aes' ../smallest patrick@thesmallestyesodapp.com:~/

ssh patrick@thesmallestyesodapp.com '
  kill -9 $(pgrep site); cd ./smallest &&
  bash -c "nohup ./site &>/dev/null </dev/null &" &&
  sleep 3
'
