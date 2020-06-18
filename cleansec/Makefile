
WORKSPACE=cleansec.xcworkspace
XCODEBUILD_WORKSPACE=xcodebuild -workspace $(WORKSPACE)

clean:
	rm -fr bin
	$(XCODEBUILD_WORKSPACE) -scheme cleansec clean

build:
	$(XCODEBUILD_WORKSPACE) -scheme cleansec build 

release: clean
	mkdir bin
	$(XCODEBUILD_WORKSPACE) -scheme cleansec archive -archivePath bin/cleansec
	zip -j bin/cleansec bin/cleansec.xcarchive/Products/usr/local/bin/cleansec script/swiftc-ast.rb
	rm -fr bin/cleansec.xcarchive
  
