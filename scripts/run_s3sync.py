#!/usr/bin/env python
from __future__ import print_function
import os
import subprocess

from pid.decorator import pidfile


@pidfile()
def sync_bucket_to_local(bucket_name, local_dir):
    subprocess.check_call([
        'aws',
        's3',
        'sync',
        '--delete',
        's3://{0}'.format(bucket_name),
        local_dir])


if __name__ == '__main__':
    bucket_name = os.environ['BUCKETNAME']
    local_dir = '/home/shared/s3'
    sync_bucket_to_local(bucket_name, local_dir)
