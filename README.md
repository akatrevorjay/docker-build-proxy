docker-build-proxy
==================

Ever get tired of waiting for your docker images to `apt-get update`?

Yeah, me too. So does Jenkins.

Use this with something similar to the provided wrapper around `docker` and `docker-compose`, which automatically add `--build-args` for `http_proxy` and `https_proxy`. For `docker-compose`, you'll need to add in a blank passthrough build_arg for the proxy URLs, as shown in `docker-compose.build.yml`.

Usage
-----

Just use the `docker-compose.yml`:
```sh
# Start proxy instance
docker-compose up
```
This compose file sets `restart=always`, making sure it's always available when you need it.
*Due to this, the provided `docker-compose.yml` file requires `docker-compose`>=1.6.0 due to it's requirement on version 2 syntax.*

You'll then need to wrap `docker` and `docker-compose` by putting the provided script in your local user `PATH`, somewhere before the wrapped commands.
If you don't have one of these setup:

```sh
mkdir -p "$HOME/bin"
echo 'PATH="$HOME/bin:$PATH"' >> ~/.bashrc
```

Troubleshooting
---------------

Every once in a while you run into a crappy image that doesn't support the `http_proxy` build argument.
In that case, just set the `NOPROXY` variable for that run:

```sh
## Standard
$ docker build -t blah .
<ERROR>
$ NOPROXY=1 !!
#           ^ Replaced with last command in most shells.
```

