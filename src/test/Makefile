all: test
test: ../FileHandling/FileHandling.swift main.swift
	swiftc -o $@ $^
CLEAN_FILES = test
clean:
	rm -f $(CLEAN_FILES)
force: clean all
