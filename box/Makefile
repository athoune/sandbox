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
	cp box /opt/box

apparmor:
	sudo cp opt.box.box /etc/apparmor.d/
	sudo apparmor_parser -r  /etc/apparmor.d/opt.box.box

user:
	sudo adduser --system  --home=/opt/box --disabled-password --disabled-login --group box
	#sudo addgroup --system box

cgcreate:
	sudo cgcreate -a box -t box -g memory,cpu:box

limit: cgcreate
	# 25%
	 sudo sh -c "echo 256 > /sys/fs/cgroup/cpu/box/cpu.shares"
	# 32Mo
	sudo sh -c "echo 32000000 > /sys/fs/cgroup/memory/box/memory.limit_in_bytes"

upstart:
	sudo cp ../upstart/sandbox.conf /etc/init/
	sudo init-checkconf /etc/init/sandbox.conf
	sudo initctl reload-configuration
