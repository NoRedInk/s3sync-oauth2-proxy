git clone -b ${S3FS_TAG} --single-branch https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse/ && ./autogen.sh && ./configure && make && make install
