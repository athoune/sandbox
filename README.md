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

Licence
-------

LPGL © 2015 Mathieu Lecarme
