SHELL=C:/Windows/System32/cmd.exe

build:
	rm -rf build/
	mkdir build
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


# for f in origs/*.jpg ; do convert "$f" -sigmoidal-contrast 7,50%  $(basename "$f" .jpg).png ; done && mogrify -format png -path thumbs -thumbnail 350x350 *.png && for f in img/work/*.png ; do optipng -clobber "$f"; done
img:
	for f in origs/*.jpg ; do convert "$$f" -sigmoidal-contrast 7,50%  $$(basename "$$f" .jpg).png ; done
	mogrify -format png -path thumbs -thumbnail 350x350 *.png
	for f in img/work/*.png ; do optipng -clobber "$$f"; done

deploy:
	aws s3 sync ./build s3://harea.co.uk/ --profile "harea-s3" 

.PHONY: build img css
