gem:
	bundle install --deployment

clean:
	rm -rf .bundle
	rm -rf vendor
	bundle install

/opt/box:
	sudo mkdir -p /opt/box
	sudo chown -R ${USER} /opt/box

install: gem /opt/box
	cp -r vendor /opt/box/
	cp box box.rb /opt/box

apparmor:
	sudo cp opt.box.box /etc/apparmor.d/
	sudo apparmor_parser -r  /etc/apparmor.d/opt.box.box
