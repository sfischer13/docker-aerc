# temporary image
FROM ubuntu:19.04 AS aerc_builder

# aerc version
ARG VERSION=master

# metadata
LABEL maintainer="Stefan Fischer <sfischer13@ymail.com>"

# apt-get settings
ARG DEBIAN_FRONTEND=noninteractive

# install packages
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
ca-certificates \
publicsuffix \
gcc \
git \
golang-1.12-go \
libc6-dev \
libnotmuch-dev \
make \
scdoc \
&& apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# PATH
ENV PATH /usr/lib/go-1.12/bin:$PATH

# aerc location
RUN mkdir /local/
WORKDIR /local/

# clone repository
RUN git clone https://git.sr.ht/~sircmpwn/aerc aerc.git

# install aerc
WORKDIR /local/aerc.git/
RUN git checkout $VERSION
ENV PREFIX /local
RUN GOFLAGS=-tags=notmuch make
RUN make install

# cleaning
WORKDIR /local/
RUN rm -r aerc.git/

# final image
FROM ubuntu:18.04 AS aerc

# metadata
LABEL maintainer="Stefan Fischer <sfischer13@ymail.com>"

# install packages
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
ca-certificates \
publicsuffix \
catimg \
dante-client \
gawk \
notmuch \
man \
pass \
python3 \
python3-colorama \
w3m \
&& apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# copy tagger from previous stage
COPY --from=aerc_builder /local/ /local/

# set path
ENV PATH /local/bin:$PATH
ENV MANPATH /local/share/man:$MANPATH

# add non-root user
RUN groupadd docker \
&& useradd -g docker -m docker

# change owner
RUN chown -R docker:docker /local/

# default command
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["aerc"]

# default working directory
WORKDIR /home/docker/

# default user
USER docker
