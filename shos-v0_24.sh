#!/bin/bash

show_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "Welcome to SHOS On-Debian by Parrot Installer Script"
    echo -e "\t\trev 0.1 - 2017-02-01"
    echo -e "${MENU}**${NUMBER} 1)${MENU} SHOS Rolling - openHAB 2  Stable  - Oracle Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} SHOS Rolling - openHAB 2   Beta   - Oracle Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} SHOS Rolling - openHAB 2 Snapshot - Oracle Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} SHOS Rolling - openHAB 2  Stable  -  Azul  Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} SHOS Rolling - openHAB 2   Beta   -  Azul  Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} SHOS Rolling - openHAB 2 Snapshot -  Azul  Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 7)${MENU} SHOS Testing - openHAB 2  Stable  - Oracle Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 8)${MENU} SHOS Testing - openHAB 2   Beta   - Oracle Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 9)${MENU} SHOS Testing - openHAB 2 Snapshot - Oracle Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 10)${MENU} SHOS Testing - openHAB 2  Stable  -  Azul  Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 11)${MENU} SHOS Testing - openHAB 2   Beta   -  Azul  Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 12)${MENU} SHOS Testing - openHAB 2 Snapshot -  Azul  Java${NORMAL}"
    echo -e "${MENU}**${NUMBER} 13)${MENU} PINE64 SHOS Testing - openHAB 2 Snapshot -  Azul  Java${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and hit return or ${RED_TEXT} press enter to exit. ${NORMAL}"
    read opt
}

function option_picked() {
    COLOR='\033[01;31m' # bold yellow
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}


function shos_install_r_s_o() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo -e "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 stable main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 stable #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install oracle-java8-installer:armhf oracle-java8-set-default:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_r_b_o() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo -e "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 beta main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 stable #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install oracle-java8-installer:armhf oracle-java8-set-default:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_r_p_o() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo -e "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 testing main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 stable #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install oracle-java8-installer:armhf oracle-java8-set-default:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_t_s_o() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo -e "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 stable main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 testing #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install oracle-java8-installer:armhf oracle-java8-set-default:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_t_b_o() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo -e "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 beta main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 testing #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install oracle-java8-installer:armhf oracle-java8-set-default:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_t_p_o() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo -e "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 testing main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 testing #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install oracle-java8-installer:armhf oracle-java8-set-default:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_r_s_a() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 stable main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 stable #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install zulu-8:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_r_b_a() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 beta main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 stable #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install zulu-8:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_r_p_a() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 testing main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 stable #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install zulu-8:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_t_s_a() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 stable main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 testing #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install zulu-8:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_t_b_a() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 beta main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 testing #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install zulu-8:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_t_p_a() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	echo -e 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 testing main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 testing #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install zulu-8:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}

function shos_install_p64() {
	echo -e "deb http://mit-usa.archive.parrotsec.org/parrot parrot main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	#echo -e 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list
	echo -e 'deb http://dl.bintray.com/openhab/apt-repo2 testing main' | sudo tee /etc/apt/sources.list.d/openhab2.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
	#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector 2 testing #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	dpkg --add-architecture armhf
	apt-get -y --force-yes install openjdk-8-jdk-headless:armhf libc6:armhf libncurses5:armhf libstdc++6:armhf 
	wget http://cdn.azul.com/zulu-embedded/bin/ezdk-1.8.0_112-8.19.0.31-eval-linux_aarch32hf.tar.gz
	mkdir ~/zulu
	tar xvfpz ezdk-1.8.0_112-8.19.0.31-eval-linux_aarch32hf.tar.gz -C ~/zulu
	update-alternatives --install /usr/bin/java java ~/zulu/ezdk-1.8.0_112-8.19.0.31-eval-linux_aarch32hf/bin/java 100
	update-alternatives --config java
	apt-get -y --force-yes install openhab2 openhab2-addons
	apt-get -y --force-yes autoremove
	systemctl enable openhab2.service
}




function init_function() {
clear
show_menu
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in
        1) clear;
        option_picked "Installing SHOS Rolling - openHAB 2  Stable  - Oracle Java";
		shos_install_r_s_o;
		option_picked "Operation Done!";
        	exit;
			;;

        2) clear;
		option_picked "Installing SHOS Rolling - openHAB 2  Beta  - Oracle Java";
		shos_install_r_b_o;
		option_picked "Operation Done!";
			exit;
            ;;

        3) clear;
		option_picked "Installing SHOS Rolling - openHAB 2 Snapshot - Oracle Java";
		shos_install_r_p_o;
		option_picked "Operation Done!";
			exit;
            ;;

        4) clear;
		option_picked "Installing SHOS Rolling - openHAB 2  Stable  -  Azul  Java";
		shos_install_r_s_a;
		option_picked "Operation Done!";
			exit;
            ;;
		
		5) clear;
		option_picked "Installing SHOS Rolling - openHAB 2   Beta   -  Azul  Java";
		shos_install_r_b_a;
		option_picked "Operation Done!";
			exit;
			;;
		
		6) clear;
		option_picked "Installing SHOS Rolling - openHAB 2 Snapshot -  Azul  Java";
		shos_install_r_p_a;
		option_picked "Operation Done!";
			exit;
			;;
        
        7) clear;
		option_picked "Installing SHOS Testing - openHAB 2  Stable  - Oracle Java";
		shos_install_t_s_o;
		option_picked "Operation Done!";
			exit;
			;;
		
		8) clear;
		option_picked "Installing SHOS Testing - openHAB 2   Beta   - Oracle Java";
		shos_install_t_b_o;
		option_picked "Operation Done!";
			exit;
			;;
		
		9) clear;
		option_picked "Installing SHOS Testing - openHAB 2 Snapshot - Oracle Java";
		shos_install_t_p_o;
		option_picked "Operation Done!";
			exit;
			;;
			
		10) clear;
		option_picked "Installing SHOS Testing - openHAB 2  Stable  -  Azul  Java";
		shos_install_t_s_a;
		option_picked "Operation Done!";
			exit;
			;;
			
		11) clear;
		option_picked "Installing SHOS Testing - openHAB 2   Beta   -  Azul  Java";
		shos_install_t_b_a;
		option_picked "Operation Done!";
			exit;
			;;
			
		12) clear;
		option_picked "Installing SHOS Testing - openHAB 2 Snapshot -  Azul  Java";
		shos_install_t_p_a;
		option_picked "Operation Done!";
			exit;
			;;
			
		13) clear;
		option_picked "PINE64 Installing SHOS Testing - openHAB 2 Snapshot - Azul Java";
		shos_install_p64;
		option_picked "Operation Done!";
			exit;
			;;
        x)exit;
        ;;

	q)exit;
	;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi
done
}

if [ `whoami` == "root" ]; then
	init_function;
else
	echo "R U Drunk? This script needs to be run as root!"
fi
