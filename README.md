# s3 sync + oauth2_proxy
Modern-day `UserDir public_html` with authentication.

The Docker image is based on Alpine with periodic S3 sync and
[oauth2_proxy](https://github.com/bitly/oauth2_proxy) managed by [supervisor](http://supervisord.org).

S3 sync is done through awscli's `s3 sync` command and is run once per minute.

## Example

```
docker run \
  -e BUCKETNAME=.. \
  -e AWS_ACCESS_KEY_ID=.. \
  -e AWS_SECRET_ACCESS_KEY=.. \
  -e OAUTH2_PROXY_CLIENT_ID=.. \
  -e OAUTH2_PROXY_CLIENT_SECRET=.. \
  -e OAUTH2_PROXY_ARGS="-provider=github -github-org=MyOrg -email-domain=* -cookie-secret=.. -skip-auth-regex=healthcheck" \
  -p 8080:80 \
  --rm \
  -it s3sync-oauth2-proxy:latest
```

## Configurations

### Environment variables

For S3:

- `$BUCKETNAME` - the AWS bucket name to sync
- `$AWS_ACCESS_KEY_ID` - the AWS key id - these can be replaced by instance-role based access
- `$AWS_SECRET_ACCESS_KEY` - the AWS secret key

For oauth2_proxy:

- `OAUTH2_PROXY_ARGS` - arguments to pass to oauth2_proxy. by default, `-http-address` and `-upstream`
  are set to listen to `0.0.0.0:80` and proxy to the synced s3 folder, respectively.
- other environment variables listed in [oauth2_proxy's documentation](https://github.com/bitly/oauth2_proxy#environment-variables)

### supervisor
You can overwrite `config/supervisord.conf` to change the parameters for supervisord.
But usually you do not need to unless you need to start additional processes. Noted that daemon is off by default for supervisor.

### Default S3 folder
The s3 bucket is synced to `/home/shared/s3`.
