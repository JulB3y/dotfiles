function open --description 'Öffnet Dateien/URLs getrennt vom Terminal (disowned)'
    # Prüft, ob xdg-open oder ein spezifischer open-Befehl existiert
    if command -q xdg-open
        command xdg-open $argv >/dev/null 2>&1 &
    else
        command open $argv >/dev/null 2>&1 &
    end
    disown
end
