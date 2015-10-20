#!/bin/bash
ls -1 | while read file; do

	body=$(cat $file | sed -e 's/"/\\\"/g')
	curl -XPUT "http://localhost:9200/golang/funcs/$(basename \"$file\")" -d '
	{   
	    "body": "''$body''"
	}'
done
