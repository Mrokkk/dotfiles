[[ $- != *i* ]] && return

for file in ~/.bash/*.sh; do
    source $file
done
