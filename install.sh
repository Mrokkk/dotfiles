set -e
echo "Copying files..."
for file in $(find . -type f -not -name "install.sh" -maxdepth 1 2>/dev/null); do
    echo "  Copying $file..."
    [[ ! -e ~/$file ]] && cp $file ~/$file
    [[ $(diff ~/$file $file) ]] && echo -n "    Differences found in $file. Do you wish to overwrite? [y/N] " && read input
done

