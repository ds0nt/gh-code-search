#!/bin/bash


input=$(realpath $1)
output=$(realpath $2)
cd "$input"
out=
find -name *.go | while read file;  do
	cat $file | while read x; do
		if [[ "$(echo $x | grep -E '^func [a-zA-Z0-9]+')" != "" ]] ; then 
			out="$x"

			while read y && [[ "$y" != "}" ]]; do
				out="$out\n$y"
			done
			out="$out\n$y"
			echo -e "$out" > "$output/$(echo "$x" | grep -Eo 'func [a-zA-Z0-9]+' | cut -d\  -f2)"
		else
			continue
		fi	
	done; 
done;

