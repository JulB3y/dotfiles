# fish dbus session config

# start dbus session 
if not set -q DBUS_SESSION_BUS_ADDRESS
    for line in (dbus-launch)
        set -l item (string split -m 1 = -- $line)
        if test (count $item) -eq 2
            set -gx $item[1] (string trim -c "';" -- $item[2])
        end
    end
end


