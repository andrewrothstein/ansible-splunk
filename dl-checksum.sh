#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://www.splunk.com/bin/splunk/DownloadActivityServlet

dl_ver() {
    local ver=$1
    local sha=$2
    local os=$3
    local arch=$4
    local file=splunk-${ver}-${sha}-${os}-${arch}.tgz
    local url="$MIRROR?architecture=${arch}&platform=${os}&version=${ver}&product=splunk&filename=${file}&wget=true"

    local lfile=$DIR/$file

    if [ ! -e $lfile ]; then
        wget -q -O $lfile $url
    fi

    printf "  # %s\n" $url
    printf "  '%s': sha256:%s\n" $ver $(sha256sum $lfile | awk '{print $1}')
}

# https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.1&product=splunk&filename=splunk-8.1.1-08187535c166-Linux-x86_64.tgz&wget=true
dl_ver 8.1.1 08187535c166 Linux x86_64

