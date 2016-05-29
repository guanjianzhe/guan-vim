#
# tuxingsun.net
#
function start_tuproxy {
    export http_proxy='bat.2.7182818.in:13018'
    export HTTPS_PROXY='bat.2.7182818.in:13018'
}

function stop_tuproxy {
    export http_proxy=
    export HTTPS_PROXY=
}

source ~/.bashrc
