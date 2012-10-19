#!/bin/bash -e

(
  cd ./vm

  vagrant up
  vagrant ssh -c 'cd /app         &&
                  cabal clean     &&
                  cabal configure &&
                  cabal build'
)

strip dist/build/site/site

cp dist/build/site/site .

git commit site -m 'update binary'

git push heroku master
