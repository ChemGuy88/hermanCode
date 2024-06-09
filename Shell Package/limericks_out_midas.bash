python "/Users/herman/Documents/midas/data/reference/limericks/script_out.py"
file_path="/Users/herman/Documents/midas/data/reference/limericks/limericks_out.bash"
if [ -f "$file_path" ];
then
    # shellcheck source="/Users/herman/Documents/midas/data/reference/limericks/limericks_out.bash"
    source "$file_path"
    rm "$file_path"
fi
