.PHONY: deploy
deploy:
	heroku container:login
	heroku container:push web --app thesmallestyesodapp
	heroku container:release web --app thesmallestyesodapp
