# General
LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_out.bash"
if [ -f "$LIMERICKS_OUT_PATH" ]; then
    # shellcheck source="Shell Package/limericks_out.bash"
    source "$LIMERICKS_OUT_PATH"
fi

# For Midas
LIMERICKS_OUT_PATH="$HERMANS_CODE_INSTALL_PATH/Shell Package/limericks_out_midas.bash"
if [ -f "$LIMERICKS_OUT_PATH" ]; then
    # shellcheck source="Shell Package/limericks_out_midas.bash"
    source "$LIMERICKS_OUT_PATH"
fi
