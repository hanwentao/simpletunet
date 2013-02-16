#!/bin/sh

response=`curl -s -d "action=check_online" http://net.tsinghua.edu.cn/cgi-bin/do_login`
echo $response
