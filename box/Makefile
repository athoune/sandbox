gem:
	bundle install --deployment

clean:
	rm -rf .bundle
	rm -rf vendor
	bundle install

/opt/box:
	mkdir -p /opt/box

install: gem /opt/box
	cp -r vendor /opt/box/
	cp box box.rb /opt/box
