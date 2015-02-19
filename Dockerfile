# Use my ubuntu with latex container until we get rid of tex libs. Saves me
# having to rebuild it every time
FROM heytrav/trusty-with-latex
MAINTAINER Travis Holton <travis@ideegeo.com>

ADD ./plenv.sh /etc/profile.d/plenv.sh
ADD ./perls.txt /build/perls.txt

RUN apt-get update && \
    apt-get install -y --force-yes build-essential curl git && \
     apt-get install -y libssl-dev && \
    apt-get clean && \
    git clone git://github.com/tokuhirom/plenv.git /usr/local/.plenv && \
    git clone git://github.com/tokuhirom/Perl-Build.git \
          /usr/local/.plenv/plugins/perl-build/ && \
    . /etc/profile && \
    xargs -L 1 plenv install < /build/perls.txt && \
    for i in `cat /build/perls.txt`; \
        do  \
            export PLENV_VERSION=$i ; \
            echo Installing modules for Perl $i ; \
            . /etc/profile.d/plenv.sh ; \
            plenv install-cpanm ; \
            cpanm Carton  \
                local::lib \
                List::Util \
                experimental \
                Module::Install;  \ 
        done

