# *aerc* Docker Image

Docker image for the [aerc](https://aerc-mail.org/) email client.
The `Dockerfile` was not written with minimal container size in mind.
On the other hand, it should be able to build and run most versions of `aerc`.

## Credits

**Please read `aerc`'s [license terms](https://git.sr.ht/~sircmpwn/aerc/tree/master/LICENSE) before using this Dockerfile.**

## Usage

### Building

In order to build the image, you have to clone the repository.

``` shell
git clone https://github.com/sfischer13/docker-aerc
cd docker-aerc
```

Then, build the Docker image using one of the tags from `aerc`'s source code [repository](https://git.sr.ht/~sircmpwn/aerc/refs).

``` shell
make build VERSION=master
```

### Running

Before you can use `aerc`, you have to build the image as described above.

Configuration files must be made accessible by using Docker [bind mounts](https://docs.docker.com/storage/bind-mounts/).

#### Using host configuration

This will start the container and use the host's configuration files (`~/.config/aerc`).

``` shell
make run VERSION=master
```

For details, see `scripts/run.sh`.

#### Using `pass` tool

If you use `pass` for retrieval of your passwords, you should also mount your password directory (`~/.password-store`) and your GnuPG configuration (`~/.gnupg`) into the container.

``` shell
make run_pass VERSION=master
```

For details, see `scripts/run_pass.sh`.

#### Using `notmuch` tool

If you use `notmuch` for searching your mails, you should also mount your index directory, which contains `.notmuch/`, into the container.

#### Miscellaneous commands

For an overview of the container files, run the following command:

``` shell
docker run --rm -i sfischer13/aerc:master --help
```

Open a shell within the container:

``` shell
docker run --rm -i -t sfischer13/aerc:master bash
```

Read the manual:

``` shell
docker run --rm -i -t sfischer13/aerc:master man aerc
```
