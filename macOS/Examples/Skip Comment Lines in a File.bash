# Formatting
bold=$(tput bold)
normal=$(tput sgr0)
RED=$'\e[0;31m'
GRN=$'\e[0;32m'
BLU=$'\e[0;34m'
NC=$'\e[0m'

TEXT=$(cat ".hermanCode/macOS/uninstallers/List To Delete.txt")
TEXT=$'This is line 1, the first line.\n# This is a commented line followed by a blank line.\n\n# The previous line was blank!\nThis is another line.'

echo " ${bold}${GRN}>>>${normal}${NC} This is the text being fed to the for loop ${bold}${GRN}>>>${normal}${NC}"
echo "$TEXT"
echo " ${bold}${GRN}<<<${normal}${NC} This is the text being fed to the for loop ${bold}${GRN}<<<${normal}${NC}"

# Read all lines
echo " ${bold}${BLU}>>>${normal}${NC} Segmentation of the text ${bold}${BLU}>>>${normal}${NC}"
it=0
while read -r line
do
    it=$((it+1))
    echo "  Line $it: \"$line\""
done < <(echo "$TEXT")
echo " ${bold}${BLU}<<<${normal}${NC} Segmentation of the text ${bold}${BLU}<<<${normal}${NC}"

# Skip lines commented with "#" or empty lines
echo " ${bold}${RED}>>>${normal}${NC} Selective reading of the text ${bold}${RED}>>>${normal}${NC}"
while read -r line
do 
    echo "  Working on \"$line\""
done < <(echo "$TEXT" | grep -v -e '^#' -e '^$')
echo " ${bold}${RED}<<<${normal}${NC} Selective reading of the text ${bold}${RED}<<<${normal}${NC}"

# FILE_PATH=".hermanCode/macOS/uninstallers/List To Delete.txt"

