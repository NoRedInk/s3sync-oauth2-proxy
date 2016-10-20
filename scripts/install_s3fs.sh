git clone -b v1.79 --single-branch https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse/ && ./autogen.sh && ./configure && make && make install
