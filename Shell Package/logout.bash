# General
LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_out.bash"
if [ -f "$LIMERICKS_OUT_PATH" ]; then
    # shellcheck source="Shell Package/limericks_out.bash"
    source "$LIMERICKS_OUT_PATH"
fi

if [[ $OSTYPE == "darwin"* ]]; then
    # :: macOS ::
    :
    if [[ "herman-imac.attlocal.net" == "$(hostname)" ]]; then
        # :: macOS at home ::
        # :: >>> macOS at home - Midas project >>> ::
        LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_out_midas.bash"
        if [ -f "$LIMERICKS_OUT_PATH" ]; then
            # shellcheck source="Shell Package/limericks_out_midas.bash"
            source "$LIMERICKS_OUT_PATH"
        fi
        # :: <<< macOS at home - Midas project <<< ::
        :
    elif [[ "AHC-Mac-Admins-MacBook-Pro.local" == "$(hostname)" ]]; then
        # :: macOS at work ::
        :
    else
        echo "Unsupported machine."
    fi
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    # :: Linux ::
    :
else
    echo "Unsupported machine."
    return
fi
