source /usr/share/cachyos-fish-config/cachyos-config.fish

# OVERWRITE GREETING POTENTIALLY DISABLING FASTFETCH
#function fish_greeting
#    # smth smth
#end

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

            read -l -P "Launch Hyprland? [y/N]: " response
            switch $response
                case Y y
                    exec uwsm start hyprland-uwsm.desktop
            end
        end
    end
end
