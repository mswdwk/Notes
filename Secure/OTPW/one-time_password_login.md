# [OTPW – A one-time password login package](https://www.cl.cam.ac.uk/~mgk25/otpw.html)

Markus Kuhn, Computer Laboratory, University of Cambridge

Latest release: Version 1.5, 2014-08-07

Abstract
The OTPW package consists of the one-time-password generator otpw-gen plus two verification routines otpw_prepare() and otpw_verify() that can easily be added to programs such as login or ftpd on POSIX systems. For platforms that support the Pluggable Authentication Method (PAM) interface, a suitable wrapper is included as well. Login software extended this way will allow reasonably secure user authentication over insecure network lines. The user carries a password list on paper. The scheme is designed to be robust against theft of the paper list and race-for-the-last-letter attacks. Cryptographic hash values of the one-time passwords are stored for verification, either in the user’s home directory or in a dedicated system directory.

Introduction
A well-known classic vulnerability of the Internet application protocol suite is the frequent cleartext transfer of passwords in the telnet, rsh, and ftp protocols. Modern replacements for these protocols such as Tatu Ylönen’s Secure Shell allow comfortable and secure remote sessions and file transfers over network connection that are not trusted to provide confidentiality.

However, traveling computer users often want to connect to their home system via untrusted terminals at conference hotels, other universities, and airports, where trusted encryption software is not available. Even Secure Shell does not protect against keyboard eavesdropping software on the untrusted terminal. A loss of confidentiality is often acceptable in these situations for the session content, but not for reusable login passwords. One-time-password schemes avoid the transmission of authentication secrets that are of any value after they have been used. This provides a reasonable level of protection against the widely encountered password sniffing attacks. The goal of a one-time-password login scheme is merely to provide a significant increase of security over the classic telnet/rlogin login procedure. It does not aim to protect from sophisticated active attacks such as session hijacking, host emulation, man-in-the-middle, etc. against which ssh and SSL based protocols should be used if this level of protection is required.

A widely known one-time-password scheme is S/KEY [Hal94, HM96]. OTPW is not compatible with and is not derived from either S/KEY or OPIE. It is a completely independent and different design, which I believe fulfils my functional and security requirements better.

How it works
One-time password authentication with the OTPW package is accomplished via a file containing hash values of passwords. Depending on the installation option chosen, this can either be a file ~john/.otpw located in the user’s home directory, or it can be a file ~otpw/john in the home directory of a dedicated pseudo user “otpw”. In the latter case, the otpw-gen tool for generating new passwords must be owned by pseudo user “otpw” and have the SETUID bit set. As long as users do not have such a hash file, the one-time-password facility is not active for them.

A user who wants to setup the one-time-password capability just executes the otpw-gen program. The program will ask for a prefix password that the user has to select and memorize and it will then write to standard output a password list such as:

  OTPW list generated 2003-08-31 21:06 on trillium.cl.cam.ac.uk

  000 IZdB bqyH  006 rF62 k6zi  012 JCFe 6at3  018 uaYT azuu  024 Nt7n b=fQ
  001 yCSo /VQs  007 Phvb =6ZW  013 8Pm7 DbYJ  019 OdAk H62c  025 /pOm :ZEA
  002 mESf +nWK  008 J9fH iXrn  014 MAds 6TTS  020 Aj6W 9O4P  026 DhCc yrPY
  003 x4vX HXr2  009 DGPC amts  015 B=xZ waPx  021 MzUP Ahsc  027 UWTe G3Fh
  004 A5z9 japt  010 s6cr xwZ5  016 sCgq Da5Y  022 Q=XK 4I7w  028 xszW Ha9L
  005 YCcA k29/  011 inn6 Rsa/  017 m8za o/HB  023 umS= gYoU  029 +HmG Rr6P

              !!! REMEMBER: Enter the PREFIX PASSWORD first !!!
Normally the output of otpw-gen should be sent directly to the printer as in

  otpw-gen | lpr
or should be first formatted with an ASCII to PostScript converter where necessary.

Fetch the printed list immediately from the printer, fold it, and keep it with you. The list shows the machine name and the creation time to allow users to find the latest list for the right machine. It does not show the user’s name, because nobody is supposed to have the list of anyone else, but printer drivers such as a2ps might add it. Only a single list is required for a set of networked machines on which the user has a common home directory.

By default, otpw-gen generates 60 lines of output. Use the command line options -h lines, -w columns, and -s pages to specify the length of the output. No more than 1000 passwords will be generated at a time.

Where one-time-password authentication is used, the password prompt will be followed by a 3-digit password number. Enter first the prefix password that was given to otpw-gen, followed directly (without hitting return between) by the password with the requested number from the printed password list:

  login: kuhn
  Password 019: geHeimOdAkH62c
In this example, geHeim was the prefix password. The spaces in the password list are just there to increase readability and can be dropped.

A clever attacker might observe the password being entered and might try to use the fact that computers can send data much faster than users can finish entering passwords. In the several hundred milliseconds that the user needs to press the return key after the last character, an attacker could on a parallel connection to the same machine send the code of the return key faster than the user.

To prevent such a race-for-the-last-key attack, any login attempt that is taking place concurrently with another attempt will require three one-time passwords to be entered:

  login: kuhn
  Password 022/000/004: geHeimQ=XK4I7wIZdBbqyHA5z9japt
This might look inconvenient at first, but remember that three passwords will only be requested when someone tries to login simultaneously, which in itself should already cause suspicion. The three requested passwords are randomly selected but they will never include the single password that was requested in the first of the concurrent login attempts. Only the first requested single password will be locked, not any of the requested triples. This way, the three-password method ensures that an attacker cannot disable the OTPW mechanism by locking all passwords. The triple challenge ensures that many ten thousand network connections would be necessary to perform a race attack on the same password triple, which is not practical. The OTPW package creates a symbolic link .otpw.lock in the user’s home directory to lock the first requested password while its input is pending. If a system crash created a stale lock, it will be removed after 24 hours.

The .otpw file looks like

  OTPW1
  30 3 12 8
  ---------------
  ---------------
  023vf+Uvbg7AqjC
  025Mm+mJWbStzL5
  024aPEXvP3pgUYa
  008r3b5efMVT%IU
  002AQ63iP8ymMWq
  005:PcEr:LoieKO
  ---------------
  0135:Gw==tjv=rA
  020rQQ2C2SQP%EU
  02197Jh5deXd8ga
  016qN9qPHh4CNz6
  010BcqejWc+kI6i
  027hkkmBcMZYxgg
  029tkB6Wm5yS=F7
  003BpcMoM=YwTPY
  018f=4hAXWpwetr
  014jiOz/aMow83k
  0099gRB2+8QX8BC
  012QBhdmm7k=Hqs
  007g6zMK%Ryp6hZ
  015XsTSUVUYTJ+8
  017uxVFK6BikgpV
  ---------------
  0067t5Z8SIdz/6h
  026CN/JqBQJLKZE
  028V5hj+3wYkFHq
  011VooKgV4PAJRD
  0016AtPvgkVe+Rw
The first line identifies the file format. The second line shows the

number of originally generated password entries,
digits per password number (3),
characters per base-64 encoded hash value (12),
characters per one-time password.
Every subsequent line is a password number followed by the RIPEMD-160 hash value of the prefix password concatenated with one of the printed one-time passwords. Only the first 12×6 = 72 bits of the hash value encoded in the same modified base-64 encoding that was used to generate the passwords is stored there. As soon as a one-time password has been entered correctly, the corresponding .otpw line will be overwritten with hyphens to prevent any reuse of this password.

Installation
Get the OTPW package otpw-*.*.tar.gz from https://www.cl.cam.ac.uk/~mgk25/download/ or use

  git clone https://www.cl.cam.ac.uk/~mgk25/git/otpw
First have a look into otpw.c and otpw-gen.c where some system parameters can be changed. The only item there really worth being checked carefully is entropy_cmds. It contains a list of shell commands, whose output is used to initialize the random number generator in otpw-gen. Make sure that at least most of these shell commands actually do work on your system and produce an output that is extremely difficult to predict for potential attackers. If your operating system has a /dev/random or /dev/urandom device that gives access to a good true random number generator, then make sure that a command reads and outputs about 20 bytes from there. In entropy_env, some environment variables (e.g., PATH) can be set for these shell commands.

Just start make to compile the otpw-gen and demologin programs. While otpw-gen can directly be made available to the user, demologin is only an example of the modifications that you have to make to your login program to support one-time passwords using OTPW.

The login program has to call

  #include "otpw.h"

  struct challenge ch;
  struct passwd *pwd;

  otpw_prepare(&ch, pwd);
after the user name has been entered and the POSIX password database entry has been read into *pwd. The routine will select a challenge password, which will be stored in ch.challenge, and will lock it if necessary. If this was not possible, for instance because the user has no unused passwords left, then ch.challenge will be an empty string. Otherwise, ch.challenge should be displayed to the user in some way before the password prompt. After the password has been entered, call

  result = otpw_verify(&ch, password);
and if result == OTPW_OK then accept the user as authorized, otherwise do not. It is very important that otpw_verify() is always called after otpw_prepare() has returned successfully (i.e., with a non-empty ch.challenge string), as otherwise a stale lock might remain set. In otpw_prepare(), the current working directory will be changed to the user’s home directory, and otpw_verify() expects that it is still there. If after otpw_verify() has returned, the condition ch.entries > 2 * ch.remaining is true and half of all passwords have been used, the user should be remembered to generate a new password list by executing otpw-gen. The security of OTPW is increased if a new password list is created long before all passwords on the old list have been used.

Both routines can be called with the root user id and they will temporarily change the effective user-id to that of the user in order to access the password file in the home directory. OTPW does not use any of the POSIX advisory file locking system calls, as those often do not work reliably over network file systems.

PAM installation
If your system supports Pluggable Authentication Modules [Mor01,XSSO], then simply compile the shared library pam_otpw.so and copy it to the directory in which other PAM modules reside (under Linux usually /lib/security/). Then edit the PAM configuration file for the application in which you want to use OTPW, as described in your PAM System Administrators’ Guide. The pam_otpw.so provides both an authentication and a session component. The authentication component asks for and verifies a one-time password, the session component prints after each successful login a reminder on how many unused passwords you have left.

To use both components when loggin into your system via Secure Shell, you might have to add in /etc/pam.d/sshd the lines

  auth            required        pam_otpw.so
  session         optional        pam_otpw.so
With OpenSSH 5.9p1 for example, you need to make sure that it has PAM support compiled in, and you will need in /etc/ssh/sshd_config the lines

  UsePrivilegeSeparation            no
  UsePAM                            yes
  ChallengeResponseAuthentication   yes
To force OpenSSH to use PAM authentication (instead of its own hostbased or publickey methods, which it normally tries first), use “ssh -o PreferredAuthentications=keyboard-interactive”.

Pseudo user setup
Starting with otpw-1.5, if you would like to keep the password hash files out of the reach of your users, you can create a pseudo user “otpw” (uid < 1000) and an associated home directory where the password files will be stored. On Ubuntu Linux, for example, the steps necessary for such a setup might be

  $ adduser --system --gecos 'OTPW pseudouser' --home /var/lib/otpw otpw
  $ chown otpw /usr/bin/otpw-gen && chmod u+s /usr/bin/otpw-gen
Design rationale
Unlike S/KEY [Hal94, HM96], OTPW is not based on the Lamport scheme [Lam77] in which every one-time password is the one-way hash value of its successor. Password lists based on the Lamport scheme have the problem that if the attacker can see one of the last passwords on the list, then all previous passwords can be calculated from it. We also do not store the encrypted passwords as suggested by Rubin [Rub96], in order to keep the host free of files with secrets. Both proposals aimed to save memory in the host system. Instead, we store the one-way hash value of every single password in a potentially widely readable file in the user’s home directory. For instance, hash values of 300 passwords (a typical A4 page) require only a four kilobyte long .otpw file, a typically negligible amount of storage space.

The passwords are carefully generated random numbers. The random number generator is based on the RIPEMD-160 secure hash function [DBP96, ISO03]. The random number generator is seeded by hashing together the output of various shell commands. These provide unpredictability in the form of a system random number seed, access times of important system files, usage history of the host, and more. The random state is the 160-bit output of the hash function. The random state is iterated after each use by concatenating the old state with the current high-resolution timer output and hashing the result again. The first 72 bits of the hash output are encoded with a modified base64 [FB96] scheme to produce readable passwords, while the remaining 88 bits represent the undisclosed internal state of the random number generator.

In many fonts, the characters 0O or 1lI are difficult to distinguish, therefore the modified base64 encoding replaces the three characters 01l by :=%. If for instance a zero is confused with a capital O by the user, the password verification routine will automatically correct for this.

S/KEY uses sequences of short English words as passwords. OTPW uses by default a base64 encoding instead, because that allows more passwords to be printed on a single page, with the same password entropy. In addition, an average human spy needs over 30 seconds to write a 12-character random string into short-term memory, which provides a good protection against brief looks that an attacker might have on a password list. Lists of short words on the other hand are much faster to memorize. OTPW can handle arbitrary password generation algorithms, as long as the length of the password is fixed. In the current version, otpw-gen can generate both base-64 encoded (option -p) and 4-letter-word encoded (option -p1) passwords with a user-specified entropy (option -e).

The prefix password ensures that neither stealing the password list nor eavesdropping the line alone can provide unauthorized access. Admittedly, the security obtained by OTPW is not comparable with that of a challenge-response system in which the user has a PIN protected special calculator that generates the response. On the other hand, a piece of paper is much more portable, much more robust, and much cheaper than a special calculator. OTPW was designed for the large user base, for which an extra battery-powered device is inconvenient or not cost effective and who therefore still use normal Unix passwords everywhere.

In contrast to the suggestion made in RFC 1938, OTPW does not lock more than one one-time password at a time. If we did this, an attacker could easily exhaust our list of unlocked passwords and force us to either not login at all or use the normal Unix login password. Therefore, OTPW locks only one single password and for all further logins a triple-challenge is issued. If more than 100 unused passwords remain available, then there are over a million different challenges and an attacker has very little chance to perform a successful race attack while the authorized user finishes password entry.

The RIPEMD-160 routine was provided by Antoon Bosselaers (Katholieke Universiteit Leuven). Steven Murdoch wrote significant parts of the PAM wrapper and prepared a test setup. Also thanks to Kan Zhang, Piete Brooks and David Wheeler for useful suggestions.

Known problems
The OTPW PAM module exposes a bug in OpenSSH 3.6.1–5.9 (and possibly many other versions) under Linux:
Observation: If the ssh user aborts the keyboard-interactive password entry, for example by pressing Ctrl-C, then OTPW will not remove its ~/.otpw.lock file. As a result, the user will get a triple-password request prompted at the next login attempt.

Analysis: Debugging the sshd process with a breakpoint at the start of pam_end() shows that when ssh aborts the connection while sshd is inside the “conversation function” that sshd provides to the PAM system, then the conversation function never returns to PAM. Instead sshd calls pam_end() directly from inside the conversation function. This is in violation of The Linux-PAM application developers’ guide (draft 0.73, 2000-12-02), which states in section 3.2.1, page 14 that “should an error occur the application should [...] simply return PAM_CONV_ERR”. Linux-PAM keeps in pamh->caller_is track of whether the calling thread was supposed to come from the application (caller_is=2) or from the PAM module (caller_is=1). (See Linux-PAM-0.75/libpam/pam_private.h for the relevant macros.) The incorrect call of pam_end() simply results in an error message by Linux-PAM, because Linux-PAM thinks based on its pamh->caller_is=1 value that pam_end() was accidentally called by the module. As a result, none of the PAM data structures are cleaned up, one side effect of which is that the OTPW lock file remains in place. Sshd reacts on the failure of pam_end() with the syslog message “Cannot release PAM authentication[4]: System error”. Another security-relevant side effect is that the memory scrubbing that PAM normally applies carefully to any password buffers never takes place!

Workaround: None. This needs to be fixed urgently by the OpenSSH developers, as it also breaks the proper deallocation of buffers with secrets.

License
OTPW – A one-time password login package

Copyright © 1998–2014 Markus Kuhn

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

References
[Lam77]   Leslie Lamport: Password Authentication with Insecure Communication, Communications of the ACM, Vol 24, No 11, November 1981, pp 770–772

[Hal94]   Neil Haller, The S/KEY One-Time Password System, Proceedings of the ISOC Symposium on Network and Distributed System Security, February 1994, San Diego, CA.

[HM96]   Neil Haller, Craig Metz: A One-Time Password System, RFC 1938, May 1996.

[Rub96]   Aviel D. Rubin: Independent One-Time Passwords, USENIX Journal of Computer Systems, February, 1996.

[DBP96]   H. Dobbertin, A. Bosselaers, B. Preneel: RIPEMD-160, a strengthened version of RIPEMD, Fast Software Encryption, LNCS 1039, D. Gollmann, Ed., Springer-Verlag, 1996, pp. 71-82.

[ISO03]   ISO/IEC 10118-3, Information technology — Security techniques — Hash-functions — Part 3: Dedicated hash-functions, International Organization for Standardization, Geneva, 2003.

[FB96]   Ned Freed, Nathaniel S. Borenstein: Multipurpose Internet Mail Extensions (MIME) – Part One: Format of Internet Message Bodies, RFC 2045, November 1996.

[Mor01]   Andrew G. Morgan: Linux-PAM.

[XSSO]   X/Open Single Sign-On Service (XSSO) – Pluggable Authentication. June 1997.

Markus Kuhn

created 1997-11-25 – last modified 2014-08-07 – https://www.cl.cam.ac.uk/~mgk25/otpw.html
