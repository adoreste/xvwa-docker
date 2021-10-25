# Xtreme Vulnerable Web Application Docker

This is a docker image based on [lamp](https://registry.hub.docker.com/u/tutum/lamp/ ) containing [XVWA](https://github.com/s4n7h0/xvwa).

Build image:

```bash
docker build -t xvwa
```

Start container:

```bash
docker run -d --rm -p 80:80 --name xvwa xvwa
```

Setup XVWA:

http://localhost/xvwa/setup/