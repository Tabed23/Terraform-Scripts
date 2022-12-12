#!/bin/bash

HOSTNAME="$(curl http://169.254.169.254/latest/meta-data/local-ipv4)" NUMBER_OF_NODES="$(yq eval '.nodes | length' cluster.yml)" yq eval -i '
  .nodes[env(NUMBER_OF_NODES)].address = env(HOSTNAME) |
  .nodes[env(NUMBER_OF_NODES)].user = "ec2-user" |
  .nodes[env(NUMBER_OF_NODES)].role[0] = "controlplane" |
  .nodes[env(NUMBER_OF_NODES)].role[1] = "etcd"
' ./cluster.yml