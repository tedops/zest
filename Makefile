QA_DEPS = agent/qa/Dockerfile resources/qa/provision.sh resources/qa/supervisord.conf

clean: clean-files clean-containers clean-images

clean-files:
	-rm -rf agent/qa/resources
	-find . -type f -name '*~' -exec rm -f {} \;

clean-containers:
	-docker rm $$(docker ps -aq)

clean-images:
	-docker images -a | grep none | awk '{print $$3}' | xargs -r docker rmi

qa-agent: build-qa-agent
	@$(eval PORT := $(shell resources/qa/get-port.sh))
	@docker run -d -i -p $(PORT):80 -t localhost:5000/agent/qa-java:f21

build-qa-agent: $(QA_DEPS)
	@rsync -a resources/qa/ agent/qa/resources/
	@docker build -t localhost:5000/agent/qa-java:f21 agent/qa

