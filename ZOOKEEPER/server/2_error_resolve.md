解决mkdir: can‘t create directory ‘/var/lib/grafana/plugins‘: Permission denied

出现这个报错，是因为所挂在的目录权限不足，需要给docker对应的卷读写权限。

chmod -R 777 grafana_storage_dir
