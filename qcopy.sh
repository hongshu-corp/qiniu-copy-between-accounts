#!/bin/sh
qshell='./qshell'

ak_src=source-ak
sk_src=source-sk
bucket_src=source-bucket

ak_dest=dest-ak
sk_dest=dest-sk
bucket_dest=dest-bucket

mkdir -p $bucket_src

echo "{
  \"dest_dir\": \"$bucket_src\",
  \"bucket\": \"$bucket_src\",
  \"log_file\": \"download.log\"
}
"> qdown.conf

$qshell account --overwrite $ak_src $sk_src q_s
$qshell user cu q_s
$qshell qdownload -c 10 qdown.conf

$qshell account --overwrite $ak_dest $sk_dest q_d
$qshell user cu q_d
$qshell qupload2 --src-dir=$bucket_src --bucket=$bucket_dest
