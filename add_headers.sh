IFS=$'\n'; set -f
for f in $(find . -name '*.md'); do
    echo -n "# " > $f;
    basename $f .md >> $f;
done
unset IFS; set +f