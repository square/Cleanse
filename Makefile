.DUMMY: build documentation

SWIFT_ROOT=/Library/Developer/Toolchains/swift-latest.xctoolchain
SWIFT=$(SWIFT_ROOT)/usr/bin/swift

# This can go away once 
SWIFT_ARGS=-Xswiftc=-suppress-warnings

.build:

build: .build generated_sources
	$(SWIFT) build $(SWIFT_ARGS)

test: build
	$(SWIFT) test

clean:
	$(SWIFT) build --clean

generated_sources: Cleanse/BinderArities.swift Cleanse/PropertyInjectionArities.swift

Cleanse/BinderArities.swift: CleanseGen/GenerateBinderArities.swift
	xcrun swift CleanseGen/GenerateBinderArities.swift > Cleanse/BinderArities.swift
	
Cleanse/PropertyInjectionArities.swift: CleanseGen/GeneratePropertyInjectionArities.swift
	xcrun swift CleanseGen/GeneratePropertyInjectionArities.swift > Cleanse/PropertyInjectionArities.swift

docs/index.html: build
	jazzy

docs: docs/index.html

sphinx:
	make -C Documentation html
