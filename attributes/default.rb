#
# Cookbook Name:: security
# Attributes:: default
#
# Copyright 2012, Dominik Richter
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default[:desktop][:disable]                                = true
default[:network][:forwarding]                             = false
default[:network][:ipv6][:disable]                         = true
default[:network][:nfs][:disable]                          = true
default[:network][:nfs4][:disable]                         = true
default[:env][:extra_user_paths]                           = []
default[:env][:umask]                                      = "027"
default[:env][:root_path]                                  = "/"
default[:auth][:pw_max_age]                                = 99999
default[:auth][:pw_min_age]                                = 0
default[:auth][:retries]                                   = 5
default[:auth][:timeout]                                   = 60
default[:auth][:allow_homeless]                            = false
default[:auth][:kerberos][:disable]                        = true
default[:auth][:pam][:caching]                             = false
# may contain: cron, consolemssaging, self_management, locate, fuse, change_user
default[:security][:users][:allow]                         = []
default[:security][:kernel][:disable_module_loading]       = true
default[:security][:kernel][:disable_sysrq]                = true
default[:security][:kernel][:disable_core_dump]            = true
default[:security][:suid_sgid][:enforce]                   = true
# user-defined blacklist and whitelist
default[:security][:suid_sgid][:blacklist]                 = []
default[:security][:suid_sgid][:whitelist]                 = []
# if this is true, remove any suid/sgid bits from files that were not in the whitelist
default[:security][:suid_sgid][:remove_from_unkown]        = false
default[:security][:suid_sgid][:dry_run_on_unkown]         = false
default[:security][:sudo][:disable]                        = false
default[:security][:pkexec][:disable]                      = false


# SYSTEM CONFIGURATION
# ====================
# These are not meant to be modified by the user

# misc
default[:security][:kernel][:secure_sysrq]                 = 4 + 16 + 32 + 64 + 128

# suid and sgid blacklists and whitelists
# don't change values in the system_blacklist/whitelist
# adjust values for blacklist/whitelist instead, they can override system_blacklist/whitelist
default[:security][:suid_sgid][:system_blacklist]          = [
# blacklist as provided by NSA
"/usr/bin/rcp", "/usr/bin/rlogin", "/usr/bin/rsh",
# sshd must not use host-based authentication (see ssh cookbook)
"/usr/libexec/openssh/ssh-keysign",
"/usr/lib/openssh/ssh-keysign",
# misc others
"/sbin/netreport",                                         # not normally required for user
"/usr/sbin/usernetctl",                                    # modify interfaces via functional accounts
# connecting to ...
"/usr/sbin/userisdnctl",                                   # no isdn...
"/usr/sbin/pppd",                                          # no ppp / dsl ...
# lockfile
"/usr/bin/lockfile",
"/usr/bin/mail-lock",
"/usr/bin/mail-unlock",
"/usr/bin/mail-touchlock",
"/usr/bin/dotlockfile",
# need more investigation, blacklist for now
"/usr/bin/arping",
"/usr/sbin/uuidd",
"/usr/bin/mtr",                                            # investigate current state...
"/usr/lib/evolution/camel-lock-helper-1.2",                # investigate current state...
"/usr/lib/pt_chown",                                       # pseudo-tty, needed?
"/usr/lib/eject/dmcrypt-get-device"
]
# conditional blacklists as provided by NSA
default[:security][:suid_sgid][:blacklist_ipv6]            = ["/bin/ping6","/usr/bin/traceroute6.iputils"]
default[:security][:suid_sgid][:blacklist_nfs]             = ["/sbin/mount.nfs", "/sbin/umount.nfs"]
default[:security][:suid_sgid][:blacklist_nfs4]            = ["/sbin/mount.nfs4", "/sbin/umount.nfs4"]
# user stuff:
default[:security][:suid_sgid][:blacklist_cron]            = ["/usr/bin/crontab"]
default[:security][:suid_sgid][:blacklist_consolemssaging] = ["/usr/bin/wall", "/usr/bin/write"]
default[:security][:suid_sgid][:blacklist_locate]          = ["/usr/bin/mlocate"]
default[:security][:suid_sgid][:blacklist_usermanagement]  = ["/usr/bin/chage", "/usr/bin/chfn", "/usr/bin/chsh"]
default[:security][:suid_sgid][:blacklist_fuse]            = ["/bin/fusermount"]
default[:security][:suid_sgid][:blacklist_pkexec]          = ["/usr/bin/pkexec"]
default[:security][:suid_sgid][:blacklist_sudo]            = ["/usr/bin/sudo","/usr/bin/sudoedit"]
# desktop:
default[:security][:suid_sgid][:blacklist_desktop]         = [
"/usr/bin/Xorg",                                           # xorg
"/usr/bin/X",                                              # xorg
"/usr/lib/dbus-1.0/dbus-daemon-launch-helper",             # freedesktop ipc
"/usr/lib/vte/gnome-pty-helper",                           # gnome
"/usr/lib/libvte9/gnome-pty-helper",                       # gnome
"/usr/lib/libvte-2.90-9/gnome-pty-helper"                  # gnome
]
default[:security][:suid_sgid][:blacklist_apache]          = ["/usr/sbin/suexec"]
default[:security][:suid_sgid][:blacklist_squid]           = ["/usr/lib/squid/ncsa_auth", "/usr/lib/squid/pam_auth"]
default[:security][:suid_sgid][:blacklist_kerberos]        = ["/usr/kerberos/bin/ksu"]
default[:security][:suid_sgid][:blacklist_pam_caching]     = ["/usr/sbin/ccreds_validate"]
default[:security][:suid_sgid][:system_whitelist]          = [
# whitelist as provided by NSA
"/bin/mount", "/bin/ping", "/bin/su", "/bin/umount", "/sbin/pam_timestamp_check",
"/sbin/unix_chkpwd", "/usr/bin/at", "/usr/bin/gpasswd", "/usr/bin/locate",
"/usr/bin/newgrp", "/usr/bin/passwd", "/usr/bin/ssh-agent", "/usr/libexec/utempter/utempter", "/usr/sbin/lockdev",
"/usr/sbin/sendmail.sendmail", "/usr/bin/expiry"
]