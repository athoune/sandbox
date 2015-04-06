Sandbox
=======

A prototype for sandboxing ruby stuff on Linux, with cgroups and Apparmor.

The box
-------

 * All the library are bundled
 * Apparmor bans network, removes capabilities
 * The disk is almost hidden, just ruby tool and code can be read.
 * The UNIX socket is the only thing writable, the only way to communicate.
 * Cgroup will check CPU and RAM usage

Install and test it
-------------------

The ruby code is neutral, but the security wrapping is specific for Ubuntu Trusty.

    cd box
    make
    make install
    make apparmor

The code should not be run as root

Prepare the socket dir

    sudo mkdir /run/box
    sudo chown ${USER} /run/box

Run the server

    /opt/box/box /run/box/box.sock

In real life, the server is launched with bluepill, supervisor, upstart, systemd…

You can now use the tiny client

    cat toto.haml | ./cli.rb /run/box/box.sock

Real world
----------

There is no limit in paranoia.

Restart the daemon periodicaly.

Install `tcpspy` and `auditd`, export syslog to a distant server.

Isolate the sandbox with virtualization, KVM or Xen, try grsec patch.

Auditing apparmor rules
-----------------------

    sudo apparmor_parser -Q --debug /etc/apparmor.d/opt.box.box

Only two writable things, /run/box and /run/box/box.sock

Licence
-------

LPGL © 2015 Mathieu Lecarme
