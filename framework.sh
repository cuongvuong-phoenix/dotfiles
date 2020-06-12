#!/bin/bash

# @author: Vuong Chi Cuong
# @email: vuongcuong.phoenix@gmail.com
# @github: https://github.com/vuong-cuong-phoenix/
# @repo: https://github.com/vuong-cuong-phoenix/dotfiles
#   Feel free to open an issue on my github repo.



#---------------------------------------- ENVIROMENT ----------------------------------------
tabs 4

# CHECK 'tput'
if ! command -v tput > /dev/null 2>&1; then
    printf "You must have 'tput' installed before running this script. Find how to install it here:\n"
    printf "https://command-not-found.com/tput"

    exit 1
fi

# Font colors
NORMAL=$(tput sgr0)
BOLD=$(tput bold)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)

# REPO_URL=https://github.com/vuong-cuong-phoenix/dotfiles
MAIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CURRENT_TIME=$(date +"%F_%T")

mkdir -p "$MAIN_DIR/BACKUP/$CURRENT_TIME" > /dev/null 2>&1
BACKUP_DIR="$MAIN_DIR/BACKUP/$CURRENT_TIME"

declare -a ALL_PM=(
    # macOS
    brew
    # deb (Debian & Ubuntu-based)
    apt
    # rpm (openSUSE)
    zypp
    # rpm (Fedora)
    dnf
    # rpm (CentOS)
    yum
    # rpm (Magela, Mandriva)
    urpmi
    # Arch Linux
    pacman
    # Solus
    eopkg
    # Gentoo
    emerge
    # SlackWare
    slackpkg
    # Void Linux
    xbps
    # FreeBSD
    pkg
)

unset CURRENT_PM
for i in "${ALL_PM[@]}"; do
    if command -v $i > /dev/null 2>&1; then
        CURRENT_PM=$i
        break
    fi
done


IS_ROOT=1
if [ $(id -u) -eq 0 ]; then
    IS_ROOT=0
fi

#--                                     ULTILIES
NUM_COLUMNS=$(( $( tput cols ) ))
SEPERATED_BAR=$(printf "%*s" "$NUM_COLUMNS" "" | tr " " "+")
PROGRESS_BAR=$(printf "%*s" "$NUM_COLUMNS" "" | tr " " ".")
#--                                     FUNCTIONS
################################################################################################
#                                   execute_quietly() $1
# Desc: Execute the command $1 without print anything to the screen.
# Arguments:    $1: command.
execute_quietly() {
    $1 > /dev/null 2>&1
    return $?    
}
################################################################################################
#                                   system_execute() $1
# Desc: Execute the command $1 with appropriate permission.
# Arguments:    $1: command.
system_execute() {
    if [ $IS_ROOT -eq 0 ]; then
        $1
    else
        sudo $1
    fi

    return $?
}
################################################################################################
#                                   package_install() $1
# Desc: Install package $1 with available Package Manager in the system.
# Arguments:    $1: package's name.
package_install() {
    local package_name=$1
    
    local install_command

    case $CURRENT_PM in
        brew)
            system_execute "brew install $1"
        ;;
        apt)
            system_execute "apt-get install $1"
        ;;
        zypp)
            system_execute "zypper install $1"
        ;;
        dnf)
            system_execute "dnf install $1"
        ;;
        yum)
            system_execute "yum install $1"
        ;;
        urpmi)
            system_execute "urpmi $1"
        ;;
        pacman)
            system_execute "pacman -S $1"
        ;;
        eopkg)
            system_execute "eopkg install $1"
        ;;
        emerge)
            system_execute "emerge $1"
        ;;
        slackpkg)
            system_execute "slackpkg install $1"
        ;;
        xbps)
            system_execute "xbps-install $1"
        ;;
        pkg)
            system_execute "pkg install $1"
        ;;
        *)
            printf "${RED}Cannot find your Package Manager! Add in ${UNDERLINE}install.sh${NORMAL}${RED}-> ${UNDERLINE}\$ALL_PM${NORMAL}${RED}, ${UNDERLINE}package_install()${NORMAL}${RED} and run it again!\n"
            printf "${NORMAL}"
            return 2
        ;;
    esac

    return $?
}

################################################################################################
#                                   print_wtabs() $1 $2 $3
# Desc: Print $2 on the most-left of screen and $3 on the most-right of screen with $1 of tabs. 
#       If $3 is empty then print only $2 with $1 of tabs.
# Arguments:    $1: number of tabs.
#               $2: left string to print at left-justified of the screen.
#               $3: right string to print at right-justified of the screen.
#               $4: status of progression
#               $5: color offset to calculate PROGRESS_BAR's length
print_wtabs() {
    local num_tab=$1
    local left=$2
    local status=$3
    local color_offset=$4
    local right=$5

    for i in $(seq 1 $num_tab); do
        printf "\t"
    done

    if [ -z $status ]; then
        printf "%s\n" "$left"
        printf "${NORMAL}"
    else
        if [ $status -eq 0 ]; then
            printf "%s ${GREEN}%s %s\n" "$left" "${PROGRESS_BAR:$(( ${#left} + ${#right} + 2 + 4 * 2 * $num_tab - $color_offset ))}" "$right"
            printf "${NORMAL}"
        else
            printf "%s ${RED}%s %s\n" "$left" "${PROGRESS_BAR:$(( ${#left} + ${#right} + 2 + 4 * 2 * $num_tab - $color_offset ))}" "$right"
            printf "${NORMAL}"
        fi
    fi
}

################################################################################################
#                           ask_for_confirmation() $1 $2 $3 $4 $5
# Desc: Ask for confirmation of $1. The allow string to confirm is $2, $3, $4 and $5.
# Arguments:    $1: string to be confirmed.
#               $2: short string to confirm "AGREE".
#               $3: alternative tring to confirm "AGREE".
#               $4: short string to confirm "REFUSE".
#               $5: alternative string to confirm "REFUSE".
ask_for_confirmation() {
    local ask_string=$1
    local short_agree=$2
    local alter_agree=$3
    local short_refuse=$4
    local alter_refuse=$5

    local answer

    while :; do
        printf "$ask_string ${NORMAL}[$short_agree/$short_refuse]: "
        printf "${NORMAL}"

        read answer
        answer=$(echo "$answer" | tr "[:upper:]" "[:lower:]")

        if [ "$answer" = "$short_agree" -o "$answer" = "$alter_agree" ]; then
            return 0
        elif [ "$answer" = "$short_refuse" -o "$answer" = "$alter_refuse" ]; then
            return 1
        else
            printf "${LIME_YELLOW}Wrong command! Please type again!\n"
            printf "${NORMAL}"
        fi
    done
}


################################################################################################
#                                   backup_file() $1 $2
# Desc: Backup file $1 to directory $2.
# Arguments:    $1: file to be backed up.
#               $2: destination directory.
backup_file() {
    local source_file=$1
    local target_dir=$2

    execute_quietly "mkdir "$target_dir""
    execute_quietly "cp "$source_file" "$target_dir""
    return $?
}
################################################################################################
#                                   link_file() $1 $2 $3
# Desc: Link config file $2 to file $3.
# Arguments:    $1: config's type to determine correctly source file.
#               $2: source file to be linked from.
#               $3: target file to link.
link_file() {
    local config_type=$1
    local source_file=$2
    local target_file=$3

    local return_status
    
    # Check if $target_file exists
    if [ -e "$target_file" ]; then
        # Check if $target_file is already linked to $source_file
        if [ "$(readlink "$target_file")" = "$source_file" ]; then
            print_wtabs 2 "${BLUE}$target_file ${GREEN}is already linked correctly!"
            return -1
        else
            printf "\t\t${GREEN}FOUND ${BLUE}$target_file.\n"
            printf "${NORMAL}"

            backup_file "$target_file" "$BACKUP_DIR/$config_type"
            
            if [ $? -eq 0 ]; then
                print_wtabs 2 "${LIME_YELLOW}Backing up to ${BLUE}BACKUP/$CURRENT_TIME/$config_type/" 0 $(( ${#LIME_YELLOW} + ${#BLUE} )) "SUCCEED"
            else
                print_wtabs 2 "${LIME_YELLOW}Backing up to ${BLUE}BACKUP/$CURRENT_TIME/$config_type/" 1 $(( ${#LIME_YELLOW} + ${#BLUE} )) "FAILED"
            fi
        fi
    fi

    execute_quietly "ln -fs "$source_file" "$target_file""
    return_status=$?
    if [ $return_status -eq 0 ]; then
        print_wtabs 2 "${LIME_YELLOW}Linking to ${BLUE}$target_file" 0 $(( ${#LIME_YELLOW} + ${#BLUE} )) "SUCCEED"
    else
        print_wtabs 2 "${LIME_YELLOW}Linking to ${BLUE}$target_file" 1 $(( ${#LIME_YELLOW} + ${#BLUE} )) "FAILED"
    fi

    return $return_status
}
################################################################################################
#                                   check_and_download() $1 $2 $3
# Desc: Check if package/config $1 is already installed by checking if directory $2 exists.
#       If not, then download it by running the command $3 and check it again to verify.
# Arguments:    $1: package's name.
#               $2: package's directory to check.
#               $3: download command.
check_and_download() {
    local package=$1
    local directory=$2
    local download_command=$3

    if [ -d "$directory" ]; then
        print_wtabs 2 "${GREEN}FOUND ${BLUE}$package."
    else
        $download_command

        if [ -d "$directory" ]; then
            print_wtabs 2 "${LIME_YELLOW}Installing ${BLUE}$package" 0 $(( ${#LIME_YELLOW} + ${#BLUE} )) "SUCCEED"
        else
            print_wtabs 2 "${LIME_YELLOW}Installing ${BLUE}$package" 1 $(( ${#LIME_YELLOW} + ${#BLUE} )) "FAILED"
            return 1
        fi
    fi

    return 0
}
################################################################################################
#                               install_and_config $1 $2 $3 $4 $5...
# Desc: Link all the config files ($3, $4, $5...) of package $2. 
#       If $1 is empty, only install package $2 and doesn't configure anything.
# Arguments:    $1: config's type to determine correctly config file.
#               $2: package's name.
#               $3, $4, $5,...: config file's name.
install_and_config() {
    local config_type=$1
    local package=$2
    local return_status

    shift
    if ! command -v "$package" > /dev/null 2>&1; then
        printf "${BOLD}${YELLOW}$package ${NORMAL}${YELLOW}is not installed => "
        printf "${NORMAL}"

        ask_for_confirmation "${YELLOW}Would you like to install ${BOLD}${YELLOW}$package ${NORMAL}${YELLOW}now?" "y" "yes" "n" "no"

        if [ $? -eq 0 ]; then
            package_install $package

            if [ $? -eq 0 ]; then
                print_wtabs 2 "${LIME_YELLOW}Installing ${BOLD}${YELLOW}$package" 0 $(( ${#LIME_YELLOW} + ${#BOLD} + ${#YELLOW} )) "SUCCEED"

                until [ $# = 1 ]; do
                    shift
                    printf "\t${BOLD}${YELLOW}$1\n"
                    printf "${NORMAL}"
                    
                    link_file "$config_type" "$MAIN_DIR/$config_type/$1" "$HOME/$1" 
                done

                return_status=0
            else
                print_wtabs 2 "${LIME_YELLOW}Installing ${BLUE}$package" 1 $(( ${#LIME_YELLOW} + ${#BLUE} )) "FAILED"
                return_status=1
            fi
        else
            return 2
        fi

    else
        if [ -z "$config_type" ]; then
            printf "${BOLD}${YELLOW}$package ${NORMAL}${YELLOW}found.\n"
            printf "${NORMAL}"
        
            return 0
        else
            printf "${BOLD}${YELLOW}$package ${NORMAL}${YELLOW}found => Start configuring now...\n"
            printf "${NORMAL}"
            
            until [ $# = 1 ]; do
                shift
                printf "\t${BOLD}${YELLOW}$1\n"
                printf "${NORMAL}"
                
                link_file "$config_type" "$MAIN_DIR/$config_type/$1" "$HOME/$1" 
            done

            return_status=0
        fi
    fi

    if [ $return_status -eq 0 ]; then
        printf "${BOLD}${GREEN}Successfully installed and configured ${UNDERLINE}$package\n"
        printf "${NORMAL}"
        return 0
    else
        printf "${BOLD}${RED}Failed to install or configure ${UNDERLINE}$package\n"
        printf "${NORMAL}"
        return 1
    fi
}
