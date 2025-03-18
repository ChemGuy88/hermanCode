# General

LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_out.sh"
if [ -f "$LIMERICKS_OUT_PATH" ]; then
    # shellcheck source="Shell Package/limericks_out.sh"
    source "$LIMERICKS_OUT_PATH"
fi

# Specific logout procedures
source "Shell Package/constants.sh"

if [[ $OSTYPE == "darwin"* ]]; then
    # :: macOS ::
    :
    if [[ "$(hostname)" =~ ("$MACHINE_NAME_HERMANS_IMAC") ]]; then
        # :: macOS at home ::
        # :: >>> macOS at home - Midas project >>> ::
        LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_out_midas.sh"
        if [ -f "$LIMERICKS_OUT_PATH" ]; then
            # shellcheck source="Shell Package/limericks_out_midas.sh"
            source "$LIMERICKS_OUT_PATH"
        fi
        # :: <<< macOS at home - Midas project <<< ::
        :
    elif [[ "$(hostname)" =~ ("$MACHINE_NAME_HERMANS_MBA") ]]; then
        # :: macOS on MBA ::
        # :: >>> macOS on MBA - AWS Tutorial >>> ::
        LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_out_aws.sh"
        if [ -f "$LIMERICKS_OUT_PATH" ]; then
            # shellcheck source="Shell Package/limericks_out_aws.sh"
            source "$LIMERICKS_OUT_PATH"
        fi
        # :: <<< macOS at home - Midas project <<< ::
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
