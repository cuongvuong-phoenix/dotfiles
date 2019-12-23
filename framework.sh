#!/bin/bash

declare -a ALL_PM=(
    # deb
    apt
    # rpm
    zypp
    yum
    urpmi
    # Arch Linux
    pacman
    # Solus
    eopkg
    # Gentoo
    portage
    # SlackWare
    slackpkg
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

REPO_URL=https://github.com/vuong-cuong-phoenix/dotfiles
MAIN_DIR="$HOME/.dotfiles"

CURRENT_TIME=$(date +"%F")

mkdir -p "$MAIN_DIR/BACKUP/$CURRENT_TIME" > /dev/null 2>&1
BACKUP_DIR="$MAIN_DIR/BACKUP/$CURRENT_TIME"

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
        apt)
            system_execute "apt-get install $1"
        ;;
        zypp)
            system_execute "zypper install $1"
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
        portage)
            system_execute "emerge $1"
        ;;
        slackpkg)
            system_execute "slackpkg install $1"
        ;;
        *)
            printf "Cannot find your Package Manager! Add it in 'install.sh'-> \$ALL_PM, package_install() and run it again!\n"
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
print_wtabs() {
    local num_tab=$1
    local left=$2
    local right=$3

    for i in $(seq 1 $num_tab); do
        printf "\t"
    done

    if [ -z $right ]; then
        printf "%s\n" "$left"
    else
        printf "%s %s %s\n" "$left" "${PROGRESS_BAR:$(( ${#left} + ${#right} + 2 + 4 * 2 * $num_tab ))}" "$right"
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
    local short_agree=$2
    local alter_agree=$3
    local short_refuse=$4
    local alter_refuse=$5

    local answer

    while :; do
        printf "$1 [$2/$4]: "
        read answer
        answer=$(echo "$answer" | tr "[:upper:]" "[:lower:]")

        if [ "$answer" = "$short_agree" -o "$answer" = "$alter_agree" ]; then
            return 0
        elif [ "$answer" = "$short_refuse" -o "$answer" = "$alter_refuse" ]; then
            return 1
        else
            printf "Wrong command! Please type again!\n"
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
            print_wtabs 2 "'$3' is already linked correctly!"
            return -1
        else
            printf "\t\t$target_file found.\n"
            backup_file "$target_file" "$BACKUP_DIR/$config_type"
            
            if [ $? -eq 0 ]; then
                print_wtabs 2 "Backing up to '$BACKUP_DIR/$config_type/'" "SUCCEED"
            else
                print_wtabs 2 "Backing up to '$BACKUP_DIR/$config_type/'" "FAILED"
            fi
        fi
    fi

    execute_quietly "ln -fs "$source_file" "$target_file""
    return_status=$?
    if [ $return_status -eq 0 ]; then
        print_wtabs 2 "Linking to '$target_file'" "SUCCEED"
    else
        print_wtabs 2 "Linking to '$target_file'" "FAILED"
    fi

    return $return_status
}

check_and_download() {
    local package=$1
    local directory=$2
    local download_command=$3

    if [ -d "$directory" ]; then
        print_wtabs 2 "FOUND '$package'"
    else
        $download_command

        if [ -d "$directory" ]; then
            print_wtabs 2 "Installing '$package'" "SUCCEED"
        else
            print_wtabs 2 "Installing '$package'" "FAILED"
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
        printf "'$package' is not installed => "
        ask_for_confirmation "Would you like to install '$package' now?" "y" "yes" "n" "no"

        if [ $? -eq 0 ]; then
            package_install $package

            if [ $? -eq 0 ]; then
                print_wtabs 2 "Installing '$package'" "SUCCEED"

                until [ $# = 1 ]; do
                    shift
                    printf "\t$1\n"
                    
                    link_file "$config_type" "$MAIN_DIR/$config_type/$1" "$HOME/$1" 
                done

                return_status=0
            else
                print_wtabs 2 "Installing '$package'" "FAILED"
                return_status=1
            fi
        else
            return 2
        fi

    else
        if [ -z "$config_type" ]; then
            printf "'$package' found.\n"
        
            return 0
        else
            printf "'$package' found => Start configuring now...\n"
            
            until [ $# = 1 ]; do
                shift
                printf "\t$1\n"
                
                link_file "$config_type" "$MAIN_DIR/$config_type/$1" "$HOME/$1" 
            done

            return_status=0
        fi
    fi

    if [ $return_status -eq 0 ]; then
        printf "Successfully installed and configured '$package'\n"
        return 0
    else
        printf "Failed to install or configure '$package'\n"
        return 1
    fi
}
