# General

LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_out.sh"
if [ -f "$LIMERICKS_OUT_PATH" ]; then
    # shellcheck source="Shell Package/limericks_out.sh"
    source "$LIMERICKS_OUT_PATH"
fi

# Specific logout procedures

if [[ $OSTYPE == "darwin"* ]]; then
    # :: macOS ::
    :
    if [[ "$(hostname)" =~ ("herman-imac.attlocal.net"|"herman-imac.local") ]]; then
        # :: macOS at home ::
        # :: >>> macOS at home - Midas project >>> ::
        LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_out_midas.sh"
        if [ -f "$LIMERICKS_OUT_PATH" ]; then
            # shellcheck source="Shell Package/limericks_out_midas.sh"
            source "$LIMERICKS_OUT_PATH"
        fi
        # :: <<< macOS at home - Midas project <<< ::
        :
    elif [[ "$(hostname)" =~ ("Hermans-MacBook-Air.local") ]]; then
        # :: macOS on MBA ::
        # :: >>> macOS on MBA - AWS Tutorial >>> ::
        LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_out_aws.sh"
        if [ -f "$LIMERICKS_OUT_PATH" ]; then
            # shellcheck source="Shell Package/limericks_out_aws.sh"
            source "$LIMERICKS_OUT_PATH"
        fi
        # :: <<< macOS at home - Midas project <<< ::
    elif [[ "$(hostname)" =~ ("Hermans-MacBook-Pro.local") ]]; then
        # :: macOS on MBP ::
        :
    elif [[ "$(hostname)" == "AHC-Mac-Admins-MacBook-Pro.local" ]]; then
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
