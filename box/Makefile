gem:
	bundle install
	bundle install --deployment --binstubs

clean:
	rm -rf .bundle
	rm -rf vendor

/opt/box:
	sudo mkdir -p /opt/box
	sudo chown -R ${USER} /opt/box

install: gem /opt/box
	cp -r vendor bin /opt/box/
	cp box box.eye Gemfile Gemfile.lock /opt/box

apparmor:
	sudo cp opt.box.box /etc/apparmor.d/
	sudo apparmor_parser -r  /etc/apparmor.d/opt.box.box

user:
	sudo adduser --system  --home=/opt/box --disabled-password --disabled-login --group box
	#sudo addgroup --system box

init.d:
	sudo cp ../init.d/sandbox /etc/init.d/
	sudo chmod +x /etc/init.d/sandbox
	sudo update-rc.d sandbox defaults

deps:
	sudo apt-get install -y bundler cgroup-bin
