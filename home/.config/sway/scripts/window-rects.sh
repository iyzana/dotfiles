#!/bin/env bash

tree=$(swaymsg -t get_tree)
tree="[$tree]"

function get_rects() {
    local tree=$1
    local focus=$2
    declare -a nodes

    mapfile -t nodes <<< $(jq -c '.[]' <<< "$tree")

    for node in "${nodes[@]}"; do
        if [[ -z "$node" ]]; then
            continue
        fi

        if [[ -n "$focus" ]]; then
            local id=$(jq -r '.id' <<< "$node")
            if [[ ! "$focus" == "$id" ]]; then
                continue
            fi
        fi

        local type=$(jq -r '.type' <<< "$node")
        if [[ "$type" == "con" ]]; then
            jq -r '(.rect.x | tostring) + "," + (.rect.y | tostring) + " " + (.rect.width | tostring) + "x" + (.rect.height | tostring)' <<< "$node"
        elif [[ "$type" == "output" ]]; then
            child_nodes=$(jq '.nodes' <<< "$node")
            child_focus=$(jq -r '.focus[0]' <<< "$node")
            get_rects "$child_nodes" "$child_focus"
        else
            child_nodes=$(jq '.nodes' <<< "$node")
            get_rects "$child_nodes"
        fi
    done
}

get_rects "$tree"
