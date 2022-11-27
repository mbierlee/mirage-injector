.PHONY: build
.PHONY: test
.PHONY: clean

build:
	dub build --build=release

build-docs:
	dub build --build=ddox

test:
	dub test

clean:
	dub clean

run-quickstartExample:
	dub run --build=release --config=quickstartExample