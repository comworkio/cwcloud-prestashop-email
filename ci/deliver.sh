#!/usr/bin/env bash

REPO_PATH="${PROJECT_HOME}/cwcloud-prestashop-email"

cd "${REPO_PATH}" && git pull origin main || :

declare -a APIS

APIS=("api.cwcloud.tech" "api.cwcloud.tn")

for api in "${APIS[@]}"; do
    ext="$(echo $api|awk -F '.' '{print $NF}')"
    archive="cwcloud-email-plugin-${ext}.zip"
    dir="cwcloudemailplugin"
    rm -rf "${archive}"
    mkdir -p "${dir}"
    sed "s/CWCLOUD_ENDPOINT_URL/${api}/g" "cwcloudemailplugin.php.tpl" > "${dir}/cwcloudemailplugin.php"
    cp "./ci/logo.png" "${dir}"
    cp "./README.md" "${dir}"
    zip -r "${archive}" "${dir}/"
    rm -rf "${dir}"
done

git add .
git commit -m "New release of archives plugin"
git push origin main
