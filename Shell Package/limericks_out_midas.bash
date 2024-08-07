if [[ -z "$MIDAS_INSTALL_PATH" ]]; then
    :
else
    # >>> NOTE HACK: Hack block >>>
    # NOTE HACK: Changing directory to location of script to accomodate for the use of relative paths.
    current_working_directory="$(pwd)"
    cd "$MIDAS_INSTALL_PATH" || exit  # NOTE HACK: 
    python "$MIDAS_INSTALL_PATH/data/reference/limericks/script_out.py"
    cd "$current_working_directory" || exit
    # << NOTE HACK: Hack block <<<
    file_path="$MIDAS_INSTALL_PATH/data/reference/limericks/limericks_out.bash"
    if [ -f "$file_path" ]; then
        # shellcheck source="/Users/herman/Documents/midas/data/reference/limericks/limericks_out.bash"
        source "$file_path"  # NOQA: File is created dynamically by a Python process.
        rm "$file_path"
    fi
fi
