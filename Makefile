.DUMMY: build documentation

SWIFT=swift

# This can go away once
SWIFT_ARGS=-Xswiftc=-warnings-as-errors

.build:

build: .build generated_sources
	$(SWIFT) build $(SWIFT_ARGS)

test: build
	$(SWIFT) test

clean:
	$(SWIFT) package clean

generated_sources: Cleanse/BinderArities.swift Cleanse/PropertyInjectionArities.swift

Cleanse/BinderArities.swift: CleanseGen/main.swift
	xcrun swift CleanseGen/main.swift > Cleanse/BinderArities.swift

Cleanse/PropertyInjectionArities.swift: CleanseGen/main.swift
	xcrun swift CleanseGen/main.swift > Cleanse/PropertyInjectionArities.swift

docs/index.html: build
	jazzy

docs: docs/index.html

sphinx:
	make -C Documentation html
