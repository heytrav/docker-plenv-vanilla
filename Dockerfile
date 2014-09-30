# Use my ubuntu with latex container until we get rid of tex libs. Saves me
# having to rebuild it every time
FROM heytrav/trusty-with-latex

RUN apt-get update
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get clean

RUN git clone git://github.com/tokuhirom/plenv.git /root/.plenv
RUN git clone git://github.com/tokuhirom/Perl-Build.git /root/.plenv/plugins/perl-build/
ADD ./plenv.sh /etc/profile.d/plenv.sh

RUN mkdir /build
ADD ./perls.txt /build/perls.txt

RUN . /etc/profile; xargs -L 1 plenv install < /build/perls.txt
