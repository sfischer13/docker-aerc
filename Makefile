.PHONY: clean build run run_pass

clean:
	scripts/clean.sh

build:
	scripts/build.sh ${VERSION}

run:
	scripts/run.sh ${VERSION}

run_pass:
	scripts/run_pass.sh ${VERSION}
