#!/bin/bash
for d in */ ; do
    echo "Refactor -> $d"
	# Replace
	#find $d -type f -exec sed -i 's/orignal/new/g' {} +
	# Remove
	find $d -type f -exec sed -i '/Create Date:/d' {} +
done
