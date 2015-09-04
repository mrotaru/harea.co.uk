BIN=C:/Program\ Files\ (x86)/Git/bin
CONVERT=C:/pdev/imagemagick/convert.exe
MOGRIFY=C:/pdev/imagemagick/mogrify.exe
# CONVERT_OPTIONS="-sigmoidal-contrast 7,50%"
CONTENT_OUT=build/content

build:
	rm -rf build/
	mkdir build
	mkdir -p $(CONTENT_OUT)
	mkdir -p $(CONTENT_OUT)/thumbs
	jade index.jade --out build
	jade contact.jade --out build
	jade about.jade --out build
	jade sample-panels.jade --out build
	jade work.jade --out build
	cp -r css build
	cp -r fonts build
	cp -r img build
	cp -r js build
	cp favicon.ico build
	cp robots.txt build

css:
	rm -rf build/css
	cp -r css build

img:
	rm -rf $(CONTENT_OUT)
	mkdir -p $(CONTENT_OUT)
	for f in content/*.jpg ; do echo "$$f" && $(CONVERT) -equalize -contrast -resize 1024x "$$f"  "$(CONTENT_OUT)"/$$(basename "$$f") ; done
	for f in content/*.png ; do echo "$$f" && $(CONVERT) -equalize -contrast -resize 1024x "$$f"  "$(CONTENT_OUT)"/$$(basename "$$f" .png).jpg ; done

thumbs:
	mkdir -p $(CONTENT_OUT)/thumbs
	$(MOGRIFY) -format jpg -path $(CONTENT_OUT)/thumbs -thumbnail 350x350 $(CONTENT_OUT)/*.jpg


deploy:
	aws s3 sync ./build s3://harea.co.uk/ --profile "harea-s3" 

.PHONY: build img css
