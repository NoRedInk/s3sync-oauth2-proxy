mkdir -p /home/shared/s3 && mkdir -p /tmp && s3fs $BUCKETNAME $S3FS_ARGS /home/shared/s3 -o use_cache=/tmp -o allow_other -o umask=0002 -o use_rrs -f
