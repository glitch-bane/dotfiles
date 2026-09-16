source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

if status is-login
    if test (tty) = /dev/tty1
        # uwsm returns 0 if no graphical session is active and starting one is allowed
        if uwsm check may-start >/dev/null 2>&1
            read -l -P "Launch Hyprland? [y/N]: " response
            switch $response
                case Y y
                    exec uwsm start hyprland-uwsm.desktop
            end
        end
    end
end
