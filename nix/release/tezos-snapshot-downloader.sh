#!/usr/bin/env sh
set -e
set -x

node="$1"
data_dir="$2"
node_dir="$data_dir/node"
node_data_dir="$node_dir/data"

if [ -d "${node_dir}/data/context" ]; then
    echo "Blockchain has already been imported, exiting"
    exit 0
elif [ -z "$SNAPSHOT_URL" ]; then
    echo "No snapshot was passed as parameter, exiting"
else
    echo "Did not find pre-existing data, importing blockchain"
    mkdir -p "${node_dir}/data"
    echo '{ "version": "0.0.4" }' > "${node_dir}/version.json"
    cp -v /usr/local/share/tezos/alphanet_version "${node_dir}"
    snapshot_file="${node_dir}/chain.snapshot"
    [ -f "${node_data_dir}/lock" ] && rm "${node_data_dir}/lock"
    curl -L -o "$snapshot_file" "$SNAPSHOT_URL"
    exec "${node}" snapshot import "${snapshot_file}" --data-dir "${node_data_dir}" --network "$TEZOS_NETWORK" --config-file "${node_data_dir}/config.json"
    find "${node_dir}"
    rm -rvf "${snapshot_file}"
    exit 0
fi

if [ -z "$TARBALL_URL" ]; then
    echo "No tarball was passed as parameter"
else
    echo "Downloading and extracting tarball from $TARBALL_URL"
    curl -LfsS "$TARBALL_URL" | lz4 -d | tar -x -C "$data_dir"
fi
