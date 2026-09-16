source /usr/share/cachyos-fish-config/cachyos-config.fish

# OVERWRITE GREETING POTENTIALLY DISABLING FASTFETCH
#function fish_greeting
#    # smth smth
#end

# DEFINE COLORS FOR PRETTY OUTPUT
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

# PROMPT FOR HYPRLAND
if status is-login
    if test (tty) = /dev/tty1
        if uwsm check may-start >/dev/null 2>&1
            # RUN FASTFETCH (OR CACHYOS'S DEFAULT GREETING)
            if functions -q fish_greeting
                fish_greeting
                set -g fish_greeting ""
            else
                fastfetch
            end
            
            sleep 5

            read -l -P "\n${GREEN}Would you like to launch Hyprland? [y/N]${NO_COLOR}: " response
            switch $response
                case Y y
                    exec uwsm start hyprland-uwsm.desktop
            end
        end
    end
end
