#!/data/data/com.termux/files/usr/bin/bash

show_menu() {
    CHOICE=$(dialog --clear \
                --title "TERMUX BOOTING MENU" \
                --menu "Choice one of them." \
                10 43 2 \
                1 "Arch Plasma Desktop (PRoot)" \
                2 "Termux XFCE4 Desktop (Native)" \
				3 "X11 with WM XFWM4 (Native)" \
                --stdout)

    case $CHOICE in
        1)
            clear
            echo "Starting Arch KDE Plasma..."
	    	echo #
            ~/startkde_arch.sh
            ;;
        2)
            clear
            echo "Starting Termux XFCE4..."
	    	echo #
            ~/startxfce4_termux.sh
            ;;
			
        3)
            clear
            echo "Starting Termux XFWM4..."
	    	echo #
            ~/startx11.sh
            ;;
        *)
            clear
            ;;
    esac
}

show_menu
