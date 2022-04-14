# 指定数组 降序排序
awk 'BEGIN{ PROCINFO["sorted_in"]="@val_num_desc";id=0};{arr[id]=$1;id++};END{print "array size=",length(arr);for(i=0;i<length(arr);++i)printf "%s,",arr[i];}'   test_file.txt
