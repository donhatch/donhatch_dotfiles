# Aux files needed:
#       .exrc
#       .muttrc
#       .mailcap
#       .elm/elmrc
#       .xxdiffrc
#       .gaimrc
#       .gaim/

if ($?prompt) then
    # 
    # Absolute essentials...
    #
    set noclobber
    alias cp cp -i
    alias ln ln -i
    alias mv mv -i
    alias rm "mv -f \!* ~/trash"
    alias cleanup '(\rm -rf ~/trash; mkdir ~/trash)'

    #
    # Preference stuff...
    #
    set nonomatch
    set ignoreeof
    set prompt = "% "
    alias ls ls -AF
    set history = 1000;
    # special alias understood by tcsh, gets executed when directory changes
    if (-o /bin/su) then
        alias cwdcmd 'set prompt = "`dirs` $HOST# "'
    else
        alias cwdcmd 'set prompt = "`dirs` $HOST% "'
    endif
    cd .
    set time = 1

    #
    # Convenience stuff...
    #
    if (! $?TERM) setenv TERM unknown
    if (0) then
	if ($TERM == xterm && -e ~/.top) then
	    set top = (`cat ~/.top`)
	    alias title '(set noglob; echo -n $top[1]\!*$top[2])'
	    #alias ls ls --color=auto -AF
	endif
    else
	# XXX this works in tcsh and csh on linux,
	# XXX still need to try it on others
	if ($TERM == xterm) then
	    set top = ('\033]0;' '\007')
	    alias title '(set noglob; echo -n $top[1]\!*$top[2])'
	    #alias ls ls --color=auto -AF
	endif
    endif

    alias pd pushd
    alias pop popd
    alias calc 'perl -e "printf "'"'"'"%.17g\n"'"'"'", \!* "'
    alias calc 'perl -e "use Math::Trig; printf "'"'"'"%.17g\n"'"'"'", \!* "'
    alias m '(\!* |& more)'
    alias c perl -e "'"'map {printf "%.17g\n",$_} (\!*)'"'"
    alias gr "find . -maxdepth 1 \( -name '*.[chsylCS]' -o -name '*.[ch][px+][px+]' -o -name '*.cc' -o -name '*.hh' -o -name '*.p[lmh]' -o -name '*.inc' -o -name '*tcl' -o -name '*.cgi' -o -name '*.php' -o -name '*.java' -o -name '*.prejava' -o -name '*.jad' \) -print | xargs egrep -H"
    alias Gr "find . \( -name '*.[chsylCS]' -o -name '*.[ch][px+][px+]' -o -name '*.cc' -o -name '*.hh' -o -name '*.p[lmh]' -o -name '*.inc' -o -name '*tcl' -o -name '*.cgi' -o -name '*.php' -o -name '*.java' -o -name '*.prejava' -o -name '*.jad' \) -print | xargs egrep -H"
    # The include,CVS crap is for the OSG source tree.
    # Supposedly find has -regex, but syntax is undocumented and buggy
    # (according to a web search)
    alias Gr "find . -type f \( -name '*.[chsylCHS]' -o -name '*.[ch][px+][px+]' -o -name '*.cc' -o -name '*.hh' -o -name '*.p[lmh]' -o -name '*.inc' -o -name '*tcl' -o -name '*.cgi' -o -name '*.php' -o -name '*.java' -o -name '*.prejava' -o -name '*.jad' -o \( -path '*/include/*' ! -path '*/CVS/*' \) \) -print | xargs egrep -H"
    alias GRslow "find . -type f -print | egrep '/include/|((\.([chsylCHS]|[ch](pp|xx|\+\+)|cc|hh|p[lmh]|inc|cgi|php|java|prejava|jad)|tcl)"'$'")' | grep -v /CVS/ | xargs egrep -H"
    # Don Burns's suggestion...
    alias GRR "find . \( -name '*.[chsylCS]' -o -name '*.[ch][px+][px+]' -o -name '*.cc' -o -name '*.hh' -o -name '*.p[lmh]' -o -name '*.inc' -o -name '*tcl' -o -name '*.cgi' -o -name '*.php' -o -name '*.java' -o -name '*.prejava' -o -name '*.jad' \) -exec sh -c '[ "'"`head -c12 {}`"'" = "'"'"/* -*-c++-*-"'"'" ] && echo {}' \; | xargs egrep -H"

    # Would use SYSV options -efl, but BSD options work on old and new Linuces
    alias psgrep "ps auxwwwwwwwwwwwwwwwwwwww | grep \!* | grep -v grep"
    # I think the "New directory" thing is a bug
    # (it only happens using -n, and doesn't get suppressed even with -q)...
    alias cvsstatus "cvs -n update -PdA |& grep -v '^?' | grep -v 'cvs server: Updating' | egrep -v 'cvs server: New directory .* -- ignored'"
    alias cvsupdate "cvs update -PdA |& grep -v '^?' | grep -v 'cvs server: Updating'"
    alias p ping www.altavista.com
    alias fi "find . -name \*\!*\* -print"
    alias elm elm -z
    alias cd.. 'cd $cwd:h'
    alias call 'grep -i < ~/private/phones'

    #alias say 'echo '"'"'(SayText "\!*"'


    #
    # Local stuff (that's common to nt and linux)
    #

    # Stuff for trn (man trn and inn.conf)
    setenv NNTPSERVER news.scruznet.com
    setenv ORGANIZATION "BrigetCo, Inc."
    setenv FROMHOST plunk.org

    if (! -e /etc/passwd) then # nt {
	setenv VIM $HOME/installed/vim # XXX don't remember why
        setenv TERM xterm # cygwin vim messes up if it stays unknown
	alias more less

	alias vi vim
	alias view vim -R
	alias gdiff "c:/Program\ Files/Beyond\ Compare/1.9a/Beyond32"
	alias netswitcher Netsw.exe # XXX why do I seem to need .exe for this??
	set BACKHOME = `echo $HOME | C:/cygwin/bin/sed 's/\//\\\\/g'` # for winnt apps

	#
	# Some bindings aren't quite to my liking...
	#
	bindkey "^W" backward-delete-word
	bindkey "^U" kill-whole_line
	#
	# Make the arrow keys work (I don't know why this works,
	# it's from Chris Walker).
	#
	bindkey -b N-up up-history
	bindkey -b N-down down-history
	bindkey -b N-left backward-char
	bindkey -b N-right forward-char

	#
	# Local stuff..
	#
	# The visual C++ variables are manually translated from 
	# c:/Program\ Files/DevStudio/VC/bin/VCVARS32.BAT.
	#
	# XXX it's slow when logged in to local domain,
	# XXX but not when logged in to PREDICTIVE domain???
	# XXX argh, now it's not slow at all?  wish I could tell what's happening
	#echo -n "Setting PATH (why is this so slow?) ... "
	set path = ( \
	    ~/tmp/bin \
	    ~/bin \
	    ~/share/bin \
	    ~/dont_know_where_Craig_got_these_from \
	    ~/installed \
	    ~/installed/mpeg/bin \
	    ~/installed/ImageMagick-nt/ImageMagick-5.1.1 \
	    C:/ImageMagick \
	    C:/cygwin/bin \
	    C:/Perl/bin \
	    C:/Perl5.6/bin \
	    C:/Program\ Files/Aladdin/gs6.01/bin \
	    C:/Program\ Files/Ghostgum/gsview \
	    C:/Program\ Files/Ghostgum/pstoedit \
	    C:/Program\ Files/CincoNet/NetXRayNT/Program \
	    C:/Program\ Files/NAI/SnifferNT/Program \
	    C:/Program\ Files/VitalSigns/Net.Medic/Program \
	    C:/Program\ Files/NetSwitcher \
	    C:/Program\ Files/Netscape/Communicator/Program \
	    C:/Program\ Files/Thematic/Chroma \
	    C:/Program\ Files/WinZip \
	    C:/WINNT/system32 \
	    C:/WINNT \
	    C:/Program\ Files/DevStudio/SharedIDE/bin \
	    C:/Program\ Files/DevStudio/VC/bin \
	    C:/Program\ Files/DevStudio/VC/bin/winnt \
	)
	    # ~/installed/PerlCRT-2.05-bin-1-x86-VC \
	#echo " done."
	set cdpath = ( \
	    ~ \
	    ~/wrk \
	    ~/whiplash \
	    C:/Program\ Files/Apache\ Group/Apache \
	    C:/Program\ Files/Apache\ Group/Apache/users \
	    C:/Program\ Files/Apache\ Group/Apache/users/whiplash \
	)

        alias work "ipconfig /release && ipconfig /renew && route delete 0.0.0.0 10.66.66.66 && ipconfig"
        alias unwork "ipconfig /release AMDPCN1"
        alias home "ipconfig /release && ipconfig /renew AMDPCN2"
	alias dial rasphone
	alias client "perl -w ~/bin/client.pl"
	alias fuddd "perl -w ~/bin/fuddd.pl"

	# Per vim README.NT, this should be set
	# so that cygwin tools won't think I'm using a
	# shell that doesn't expand filename wildcards.
	# XXX it doesn't work :-(
	setenv CYGWIN noglob

	# GMT stuff, translated from src/gmtenv.bat
	setenv NETCDF ~/installed/GMT/NETCDF-3.4
	setenv GMTHOME ~/installed/GMT/GMT
	#setenv HOME ${GMTHOME} # ???
	setenv PATH "${PATH};${GMTHOME}/bin;${NETCDF}/bin"

	set ftp = /Inetpub/ftproot

	# Mount and unmount via vmnet1-smb
	alias mountredhat "net use r: \\\\ick-redhat\\hostfs"
	alias unmountredhat "net use r: /delete"

	#
	# Temporary stuff...
	#

    else # }{ linux or other unix
        umask 022
        # note, /usr/java/jre1.3/bin must come before /usr/bin
        # so that java will be found there.
        # /usr/local stuff comes before other stuff,
        # so it will override what's installed via rpms.
	set path = ( \
	    ~/bin \
	    ~/share/bin \
	    /usr/local/bin \
	    /usr/local/sbin \
	    /usr/sbin \
	    /sbin \
	    /bin \
            #/usr/java/jdk1.3.1/bin \
            #/usr/java/j2sdk1.4.0/bin \
            #/usr/java/j2sdk1.4.2/bin \
            #/usr/java/j2sdk*/bin \
            /usr/java/jdk1.5.0/bin \
	    /usr/bin \
	    /usr/ucb \
            /usr/ccs/bin \
	    $path \
	)

            #/usr/java/jdk1.3.1_03/bin \

	if ($?tcsh) then
	    bindkey -c ^Z bg # so hitting ^Z twice kicks it into background
        else # csh
            set filec
	endif
        #
        # XXX Don't remember why I had the following,
        # XXX but it started screwing up (insert mode in vi)
        # XXX when I upgraded from redhat 6.1 to 7.1...
        #
	#stty erase ^H

        # XXX this is Linux-specific
        set mail = (0 /var/spool/mail/$USER)

	# parens so man doesn't get executed and get broken pipe if it exists
	#alias Man "(man \!* | sed s/.//g) > ~/tmp/man\!$ ; view ~/tmp/man\!$ "
	alias Man "(man \!* | manfilt > ~/tmp/man\!$ ) ; view ~/tmp/man\!$ "
        # what the fuck, redirecting man gives a broken pipe message on rh8
	alias Man "(man \!* | manfilt > ~/tmp/man\!$ ) |& grep -v 'gunzip: stdout: Broken pipe' | grep -v '^"'$'"'; view ~/tmp/man\!$ "

	# So stuff like showfont will work
	setenv FONTSERVER unix/:-1
	# More specific is preferable, in case there are lots of fonts.

	# But less specific is preferable in case the exact font isn't available. :-|

	# All of the following work on my Linux system...
	alias tiny 'gnome-terminal --font="-*-*-*-*-*-*-6-*-*-*-*-*-*-*"'
	alias tiny 'gnome-terminal --font="-schumacher-clean-medium-r-normal-*-*-60-*-*-c-*-iso646.1991-irv"'
	alias tiny 'gnome-terminal --font="-schumacher-clean-medium-r-normal--6-60-75-75-c-40-iso646.1991-irv"'
	alias loadmyfonts xset +fp ~/myfonts
	alias gt gnome-terminal
	alias tiny gt --font=4x6

        alias vm vmware -x -q ~/vmware/nt4/nt4.cfg
        # when coming out of suspend on my laptop, my key repeat
        # is all messed up.  changing it to a different value
        # and back fixes it...
        alias fixkr "xset r rate 500 4; xset r rate 500 5"
        alias fixns "killall -v -9 netscape-communicator"
        alias t tcpdump -n net 127.0/8 or net 10.0/8 or
        alias work "fwup -n -paranoid; pump -d; ifconfig eth0 | grep 'inet addr'"
        alias unwork "pump -r"
        alias home "fwup -n; dial"

	setenv WEATHERMAP_HOME ~/weathermap/cvs/weathermap/server
	if (! $?cdpath) set cdpath = ()
	set cdpath = ($cdpath \
                ~ \
                ~/share \
                ~/wrk \
                ~/share/wrk \
                $WEATHERMAP_HOME \
                ~/predictive \
        )
        setenv WEATHERMAP_DATAROOTROOT ~/weathermap/opt_Omnibus_datalogs

        #
        # Aliases for logging in through multiple levels using rrr.exp...
        #
        alias kt 'killall udptunnel.pl' # XXX argh, it waits for the connections to close otherwise.  maybe should detect "Waiting for forwarded connections to terminate..."
        alias routertunnel 'rrr.exp "ssh -L 5123:192.168.50.21:23 -L 5223:192.168.50.22:23 studly_from_outside -l dhatch"'
        alias routertunnel 'rrr.exp "(udptunnel.pl 5161/udp:5161/tcp&); ssh -R 5161:localhost:5161 -L 5123:192.168.50.21:23 -L 5223:192.168.50.22:23 studly_from_outside -l dhatch" "udptunnel.pl localhost:5161/tcp:192.168.50.21:161/udp"'

        alias routertunnel 'rrr.exp \\
            "(udptunnel.pl 5161/udp:5161/tcp&); \\\
             (udptunnel.pl 5261/udp:5261/tcp&); \\\
             ssh \\\
                  -R 5161:localhost:5161 \\\
                  -R 5261:localhost:5261 \\\
                  -L 5123:192.168.50.21:23 \\\
                  -L 5223:192.168.50.22:23 \\\
                  studly_from_outside -l dhatch" \\
            "udptunnel.pl localhost:5161/tcp:192.168.50.21:161/udp&; \\\
             udptunnel.pl localhost:5261/tcp:192.168.50.22:161/udp&; \\\
             " \\
        '
        # XXX for when the previous tunnel's tcp connection on the far end is in TIME_WAIT state which last 1 minute on studly (probably the default)
        # XXX should really figure out how to make that not happen!
        # XXX and we can't get tftp forwarding in this case because it conflicts.
        alias routertunnel2 'rrr.exp \\
            "(udptunnel.pl 5161/udp:5161/tcp&); \\\
             (udptunnel.pl 5261/udp:5261/tcp&); \\\
             ssh \\\
                  -R 5361:localhost:5161 \\\
                  -R 5461:localhost:5261 \\\
                  -L 5123:192.168.50.21:23 \\\
                  -L 5223:192.168.50.22:23 \\\
                  studly_from_outside -l dhatch" \\
            "udptunnel.pl localhost:5361/tcp:192.168.50.21:161/udp&; \\\
             udptunnel.pl localhost:5461/tcp:192.168.50.22:161/udp&; \\\
            " \\
        '

        alias studly 'rrr.exp "ssh studly_from_outside -l dhatch"'
        alias studlymapper 'rrr.exp "ssh studly_from_outside -l dhatch" "exec rlogin 192.168.50.39 -l dhatch"'
        alias orion 'rrr.exp "ssh2 portal.ops.icg.net -l weathermap" "ssh orion.ops -l trendadm; exit"'
        alias pythia 'rrr.exp "ssh2 portal.ops.icg.net -l weathermap" "ssh orion.noc -l weathermap; exit"'
        # XXX get rid of the 1's when no longer needed
        alias plunk1 'rrr "ssh1 www.plunk.org -l hatch"'
        alias plunkr1 'rrrrepeat "ssh1 www.plunk.org -l hatch"'
        alias plunk 'rrr "ssh plunk.org -l hatch"'
        alias Plunk 'rrr "ssh plunk.org -l hatch -L 2525:localhost:25 -L 1143:localhost:143 -L 143:localhost:143"'
        alias plunkr 'rrrrepeat "ssh www.plunk.org -l hatch"'
	# XXX argh, need to rewrite rrr
        #alias plunk "ssh www.plunk.org -l hatch"
        alias Scp 'rrr "scp `echo \!*`"'
        alias Scp1 'rrr "scp1 `echo \!*`"'

        alias Telnet router_telnet.exp -p
        alias letmein21 snmpset 192.168.50.21 noc .1.3.6.1.4.1.9.2.1.50.192.168.50.39 s routerAllowTelnet.config
        alias letmein22 snmpset 192.168.50.22 noc .1.3.6.1.4.1.9.2.1.50.192.168.50.39 s routerAllowTelnet.config

	#
	# cvs stuff...
        # To do cvs stuff from outside (studly from outside is 207.251.1.12):
        #       (in another window, create the tunnel:)
        #       % ssh -L 2401:studly:2401 studly_from_outside
        #       % setenv CVSROOT :pserver:dhatch@localhost:/usr/local/cvsroot
        # If you already have cvspserver service on your local host,
        # then use another port (I haven't tried that).
	# XXX where is this pserver stuff documented?
	#
        alias cvstunnel 'rrr.exp "ssh -L 2401:studly:2401 studly_from_outside"'
	alias normal setenv CVSROOT :pserver:dhatch@studly_cvs:/usr/local/cvsroot
	alias mirror setenv CVSROOT ~/weathermap/cvsroot.mirror
	alias nowhere unsetenv CVSROOT
	normal

        # small screen versions...
        #alias xdiff xdiff -geometry 1000x650
        #setenv XDIFF "xdiff -geometry 1000x650" # for xrcsdiff and xcvsdiff
        alias xdiff xdiff -geometry 1200x940
        #setenv XDIFF "xdiff -geometry 1200x940" # for xrcsdiff and xcvsdiff

        #
        # Java stuff...
        #
        alias Jikes jikes +P -classpath /usr/java/jdk1.5.0/jre/lib/rt.jar
        alias echidna java -classpath ~/src/echidna/echidna-0.4.2_01/src org.javagroup.tools.processmanager.Main

        # For when on east coast... (from tzselect)
        #setenv TZ 'America/New_York'

        # Magiccube4d params...
        setenv M4D_NFRAMES_180 60
        setenv M4D_NFRAMES_120 40
        setenv M4D_NFRAMES_90 30

        # some versions of tcsh on sun complain if TERMCAP not set
        /bin/sun >& /dev/null && setenv TERMCAP /usr/share/lib/termcap

	# Mount and unmount via vmnet1-smb.
        # For some reason C: was already being shared as name "C" but
        # I couldn't change permissions, so I created "CC".
        alias mountnt mount -t smbfs -o username=dhatch,workgroup=predictive //10.66.66.128/CC /mnt/ick-nt
        alias unmountnt umount /mnt/ick-nt

        alias elm "echo mutt!"

        alias fixnw "ifdown eth1; rmmod orinoco_pci; ifup eth1"

        alias vibm 'vi ~/share/.bookmarks.bmmgr'
        alias bm 'bmmgr.pl < ~/share/.bookmarks.bmmgr >! ~/.mozilla/default/*/bookmarks.html; (cd ~/.netscape; \ln -s -f ../.mozilla/default/*/bookmarks.html .); (cd ~/.mozilla/firefox/*.default; ln -s -f ../../*/bookmarks.html .)'

        alias prox 'wine ~/src/extern/proxomitron/Proxomitron.exe'

        alias syncon setenv __GL_SYNC_TO_VBLANK 1
        alias syncoff unsetenv __GL_SYNC_TO_VBLANK

        alias dhclient-eth0 "dhclient -lf /var/lib/dhcp/dhclient-eth0.leases -pf /var/run/dhclient-eth0.pid -cf /etc/dhclient-eth0.conf eth0 \!*"
        alias dhclient-eth1 "dhclient -lf /var/lib/dhcp/dhclient-eth1.leases -pf /var/run/dhclient-eth1.pid -cf /etc/dhclient-eth1.conf eth1 \!*"
        alias dhcprelease-eth0 dhclient-eth0 -r
        alias dhcprelease-eth1 dhclient-eth1 -r
        # XXX this is totally awkward.  Note, you might want to ps to see if any extra dhclients are running, since this is all so fragile. XXX should I just killall them? No, because I don't want to clobber the other interface...
        alias dhcprenew-eth0 'kill `cat /var/run/dhclient-eth0.pid`; dhclient-eth0'
        alias dhcprenew-eth1 'kill `cat /var/run/dhclient-eth1.pid`; dhclient-eth0'

        alias view vi -R

    endif # linux or other unix }
    if (-e ~/.cshrc.local) source ~/.cshrc.local
else # no prompt
    # So that scp will be found even if we are the peer...
    set path = ($path /usr/local/bin)
endif
