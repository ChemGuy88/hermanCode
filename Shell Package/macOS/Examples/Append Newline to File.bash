FILE_PATH="/Users/herman/.hermanCode/macOS/Examples/data/t1.txt"

FILE_PATH_TEMP="$FILE_PATH.tmp1"
sed -e '$ a \ '$'\n' "$FILE_PATH" > "$FILE_PATH_TEMP"
cat "$FILE_PATH_TEMP"