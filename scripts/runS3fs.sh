mkdir -p /home/shared/s3 && s3fs $BUCKETNAME /home/shared/s3 -o allow_other -o umask=0002 -o use_rrs -f $S3FS_ARGS
