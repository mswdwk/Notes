# https://zhuanlan.zhihu.com/p/535088350?utm_id=0
# 找回存储在DBeaver连接中的数据库密码
openssl aes-128-cbc -d -K babb4a9f774ab853c96c2d653dfe544a -iv 00000000000000000000000000000000 -in credentials-config.json | dd bs=1 skip=16 2>/dev/null
