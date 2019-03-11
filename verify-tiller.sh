#!/usr/bin/env bash

# 5 mins
max_wait=300

wait_for_tiller () {
	kubectl --namespace kube-system get pods \
	--field-selector=status.phase==Running | grep 'tiller-deploy' \
	| grep '1/1' \
	> /dev/null 2>&1
}

while [[ ${max_wait} -gt 0 ]]; do 
	wait_for_tiller
	echo "Waiting for tiller-deploy to be ready..."
	max_wait=$(($max_wait - 30));
	sleep 5
done

echo "tiller-deploy is ready"