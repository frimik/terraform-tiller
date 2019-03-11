#!/usr/bin/env bash

# 5 mins
max_wait=5

wait_for_tiller () {
	kubectl --namespace kube-system get pods \
	--field-selector=status.phase==Running | grep 'tiller-deploy' \
	| grep '1/1' \
	> /dev/null 2>&1
}

while [[ ${max_wait} -gt 0 ]]; do 
	wait_for_tiller
	max_wait=$(($max_wait - 5));
	sleep 5
done

if [${max_wait} -eq 0]
	then
		echo "Failed waiting for tiller-deploy"
		exit 1
fi

echo "tiller-deploy is ready"