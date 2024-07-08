
# Print feedback every N iterations

# shellcheck source="/data/herman/Documents/Git Repositories/Herman Code/Shell Package/functions/functions.bash"
source "$HERMANS_CODE_INSTALL_PATH/Shell Package/functions/functions.bash"

num_its=200
it=0
while [[ "$it" -lt 1000 ]];
do
    it=$((it+1))
    if [[ $((it % "$num_its")) -eq 0 ]]; then
        echo "[$(getTimestamp)]    Working on file $it."
    else
        :
    fi
done
