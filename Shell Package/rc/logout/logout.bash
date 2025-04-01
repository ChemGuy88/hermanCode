#!/usr/bin/env bash

# General logout procedure

LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/rc/logout/limericks_out.sh"
if [ -f "$LIMERICKS_OUT_PATH" ]; then
    # shellcheck source="Shell Package/limericks_out.sh"
    source "$LIMERICKS_OUT_PATH" || echo "MASH: Warning: ($LINENO): Safety mechanism failed."
else
    echo "MASH: Info: ($LINENO): Safety mechanism absent."
fi

# >>> Specific logout procedures >>>
CONSTANTS_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/rc/constants/constants.mash"
# shellcheck source="Shell Package/constants.sh"
source "$CONSTANTS_PATH"

if expr "$OSTYPE" : "darwin"* 1>/dev/null; then
    # :: macOS ::
    if expr "$(hostname)" : "$MACHINE_NAME_HERMANS_IMAC" 1>/dev/null; then
        # :: macOS at home ::
        # :: >>> macOS at home - Midas project >>> ::
        LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/rc/limericks_out_midas/limericks_out_midas.mash"
        if [ -f "$LIMERICKS_OUT_PATH" ]; then
            # shellcheck source="Shell Package/limericks_out_midas.sh"
            source "$LIMERICKS_OUT_PATH" || echo "MASH: Warning: ($LINENO): Safety mechanism failed."
        else
            echo "MASH: Info: ($LINENO): Safety mechanism absent."
        fi
        # :: <<< macOS at home - Midas project <<< ::
    elif expr "$(hostname)" : "$MACHINE_NAME_HERMANS_MBA" 1>/dev/null; then
        # :: macOS on MBA ::
        # :: >>> macOS on MBA - AWS Tutorial >>> ::
        LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/rc/limericks_out_aws/limericks_out_aws.mash"
        if [ -f "$LIMERICKS_OUT_PATH" ]; then
            # shellcheck source="Shell Package/limericks_out_aws.sh"
            source "$LIMERICKS_OUT_PATH" || echo "MASH: Warning: ($LINENO): Safety mechanism failed."
        else
            echo "MASH: Info: ($LINENO): Safety mechanism absent."
        fi
        # :: <<< macOS at home - AWS project <<< ::
    else
        echo "Unsupported machine."
    fi
elif expr "$OSTYPE" : "linux-gnu"* 1>/dev/null; then
    # :: Linux ::
    :
else
    echo "Unsupported OS."
fi
# <<< Specific logout procedures <<<
