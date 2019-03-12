#!/usr/bin/env bash

# Patch Tiller 
kubectl -n kube-system patch deployment tiller-deploy -p '{"spec": {"template": {"spec": {"automountServiceAccountToken": true}}}}'

# Verfiy Tiller is Patched
# 5 mins
max_wait=300

check_tiller_is_patched () {
	kubectl get deployments -n kube-system tiller-deploy \
	-o json | jq -r '. | .status.conditions[1].reason' | \
	grep 'NewReplicaSetAvailable' \
	> /dev/null 2>&1
}

until check_tiller_is_patched; do 
	max_wait=$(($max_wait - 5));
	if [ ${max_wait} -eq "0" ];
		then
			echo "Failed waiting for tiller-deploy to be patched"
			exit 1
	fi
	sleep 5
done

echo "tiller-deploy is patched"
