#!/bin/sh

uf () {
	docker run --name uf -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
		unifield
} 

pg () {
	docker run -d --name pg -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
		postgres:9.6
} 

mkpw () {
	dd if=/dev/urandom bs=8192 count=1 2>/dev/null | \
		md5sum | awk '{print $1}'
}

do="$*"
[ -z "$do" ] && do="pg uf"

if [ -z "$POSTGRES_PASSWORD" ]; then
	POSTGRES_PASSWORD=`mkpw`
fi

for i in $do
do
	$i
done
