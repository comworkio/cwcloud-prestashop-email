#!/usr/bin/env bash

REPO_PATH="${PROJECT_HOME}/cwcloud-prestashop-email"

cd "${REPO_PATH}" && git pull origin main || :

declare -a APIS

APIS=("cloud-api.comwork.io" "api.cwcloud.tn")

for api in "${APIS[@]}"; do
    ext="$(echo $api|awk -F '.' '{print $NF}')"
    dir="cwcloud-email-plugin-${ext}"
    rm -rf "${dir}.zip"
    mkdir -p "${dir}"
    sed "s/CWCLOUD_ENDPOINT_URL/${api}/g" "cwcloud-email-plugin.php.tpl" > "${dir}/cwcloud-email-plugin.php"
    zip "${dir}.zip" "${dir}/cwcloud-email-plugin.php"
    rm -rf "${dir}"
done

git add .
git commit -m "New release of archives plugin"
git push origin main
