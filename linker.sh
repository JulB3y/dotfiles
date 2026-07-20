#!/usr/bin/env bash

# Fehler abfangen
set -euo pipefail

CSV_FILE="paths.csv"

show_help() {
    echo "Nutzung: $0 [-d] <keyword>"
    echo "  <keyword>  Der Name des Ordners, der verlinkt werden soll."
    echo "  -d         Löscht den erstellten Ordner-Symlink (Delete-Modus)."
    exit 1
}

# Parameter parsen
DELETE_MODE=false
KEYWORD=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
        -d)
            DELETE_MODE=true
            shift
            ;;
        -*)
            echo "Fehler: Unbekannte Option $1" >&2
            show_help
            ;;
        *)
            if [[ -z "$KEYWORD" ]]; then
                KEYWORD="$1"
            else
                echo "Fehler: Zu viele Argumente." >&2
                show_help
            fi
            shift
            ;;
    esac
done

# Prüfen, ob ein Keyword übergeben wurde
if [[ -z "$KEYWORD" ]]; then
    echo "Fehler: Kein Keyword angegeben." >&2
    show_help
fi

# 1. Prüfen, ob der lokale Ordner existiert
if [[ ! -d "$KEYWORD" ]]; then
    echo "Fehler: Der Ordner '$KEYWORD' existiert hier nicht." >&2
    exit 1
fi

# 2. Prüfen, ob paths.csv existiert
if [[ ! -f "$CSV_FILE" ]]; then
    echo "Fehler: '$CSV_FILE' wurde nicht gefunden." >&2
    exit 1
fi

# 3. Pfad aus der CSV auslesen
TARGET_DIR=""
while IFS=',' read -r key val || [[ -n "$key" ]]; do
    key=$(echo "$key" | tr -d '\r' | xargs)
    val=$(echo "$val" | tr -d '\r' | xargs)
    
    if [[ "$key" == "$KEYWORD" ]]; then
        TARGET_DIR="${val/#\~/$HOME}"
        break
    fi
done < "$CSV_FILE"

if [[ -z "$TARGET_DIR" ]]; then
    echo "Fehler: Keyword '$KEYWORD' wurde nicht in $CSV_FILE gefunden." >&2
    exit 1
fi

# Helper-Funktion für Schreibrechte
check_write_permission() {
    local dir="$1"
    if [[ ! -w "$dir" ]]; then
        echo "Fehler: Keine Schreibrechte in '$dir'." >&2
        echo "Bitte führe das Skript mit 'sudo' aus." >&2
        exit 1
    fi
}

# Absoluten Pfad des lokalen Keyword-Ordners ermitteln
LOCAL_SOURCE="$(pwd)/$KEYWORD"
# Das exakte Ziel (z.B. /etc/keyd oder ~/.config/nvim)
TARGET_DEST="$TARGET_DIR/$KEYWORD"

# --- LINK / UNLINK LOGIK ---

if [ "$DELETE_MODE" = false ]; then
    echo "Verlinke Ordner '$LOCAL_SOURCE' nach '$TARGET_DEST'..."
    
    # Sicherstellen, dass das übergeordnete Zielverzeichnis (z.B. /etc oder ~/.config) existiert
    check_write_permission "$(dirname "$TARGET_DIR")"
    mkdir -p "$TARGET_DIR"
    check_write_permission "$TARGET_DIR"

    # Falls dort schon etwas existiert
    if [[ -e "$TARGET_DEST" || -L "$TARGET_DEST" ]]; then
        if [[ -L "$TARGET_DEST" && "$(readlink "$TARGET_DEST")" == "$LOCAL_SOURCE" ]]; then
            echo " [Existiert bereits] Symlink zeigt schon auf $LOCAL_SOURCE"
            exit 0
        fi
        echo "Fehler: '$TARGET_DEST' existiert bereits (Ordner oder Datei blockiert den Link)!" >&2
        exit 1
    fi
    
    # Den gesamten Ordner als Symlink anlegen
    ln -s "$LOCAL_SOURCE" "$TARGET_DEST"
    echo " [Erstellt] $TARGET_DEST -> $LOCAL_SOURCE"

else
    echo "Entferne Ordner-Symlink '$TARGET_DEST'..."
    
    if [[ -L "$TARGET_DEST" ]]; then
        # Nur löschen, wenn der Symlink auch wirklich auf unseren Dotfiles-Ordner zeigt
        if [[ "$(readlink "$TARGET_DEST")" == "$LOCAL_SOURCE" ]]; then
            check_write_permission "$(dirname "$TARGET_DEST")"
            rm "$TARGET_DEST"
            echo " [Gelöscht] Symlink $TARGET_DEST entfernt."
        else
            echo "Fehler: Der Symlink unter '$TARGET_DEST' zeigt nicht auf '$LOCAL_SOURCE'. Wird nicht gelöscht." >&2
            exit 1
        fi
    elif [[ -e "$TARGET_DEST" ]]; then
        echo "Fehler: '$TARGET_DEST' ist ein echter Ordner/eine echte Datei, kein Symlink. Wird ignoriert." >&2
        exit 1
    else
        echo " [Info] Kein Symlink unter '$TARGET_DEST' gefunden."
    fi
fi
