DOCKERIMGNAME=cypresstestdocker
DOCKERRUNCMD=docker-compose run --rm $(DOCKERIMGNAME)
CYPRESSRUNCMD=npm run test
CYPRESSGUICMD=npx cypress open

test:
	$(CYPRESSRUNCMD)

test-gui:
	$(CYPRESSGUICMD)

test-local:
	$(CYPRESSRUNCMD) --env configFile=development

test-record:
	$(CYPRESSRUNCMD) --record

combine-reports:
	npx mochawesome-merge --reportDir cypress/reports/mocha > mochareports/report-$$(date +'%Y%m%d-%H%M%S').json

generate-report:
	npx marge mochareports/*.json -f report-$$(date +'%Y%m%d-%H%M%S') -o mochareports

slack-alert:
	npx cypress-slack-reporter --logger

docker-build:
	docker build . -t $(DOCKERIMGNAME)

docker-bash:
	$(DOCKERRUNCMD) /bin/bash

docker-test:
	$(DOCKERRUNCMD) $(CYPRESSRUNCMD)

docker-test-local:
	$(DOCKERRUNCMD) $(CYPRESSRUNCMD) --env configFile=development

docker-test-record:
	$(DOCKERRUNCMD) $(CYPRESSRUNCMD) --record