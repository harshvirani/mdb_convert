#!/usr/bin/env bash
for file in Data/*; do
	filename="$(basename "$file")"

	filename1="${filename%.*}"
	sentence="$(mdb-tables Data/$filename)"
	dircreate="$(mkdir -p csv/$filename)"
	#sentence="This is   a sentence."
	for word in $sentence
	do
		    tabledata="$(mdb-export Data/$filename $word > csv/$filename/$word.csv)"
		    mongoimport -d $filename1 -c $word --type csv --file csv/$filename/$word.csv --headerline
		    #echo $tabledata;
	done
done
