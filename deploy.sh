#!/bin/bash

ghc --make -o site site.hs

rsync -avz -e ssh --exclude '.*'    \
                  --exclude '*.o'   \
                  --exclude '*.hi'  \
                  --exclude '*.aes' ../smallest patrick@thesmallestyesodapp.com:~/

ssh patrick@thesmallestyesodapp.com 'kill -9 $(pgrep site); cd ./smallest && ./site &'
