#!/usr/bin/env python3
""" usage: ./listen SHELLDIR

SHELLDIR points to a directory with sscripts
"""

from docopt import docopt
from socket import *

from glob import glob
import subprocess
from os import listdir, access, X_OK
from os.path import isfile, join
import logging as log
log.basicConfig(level=log.DEBUG)



def run_shelldir(d):
    log.debug("running all in {}".format(d))
    for fname in listdir(d):
        f = join(d,fname)
        if (isfile(f) and access(f, X_OK)):
            print("running {}".format(f))
            subprocess.call([f])
        else:
            print("will not run {}".format(f))


def main():
    d = docopt(__doc__)["SHELLDIR"]
    listen_socket(d)

def listen_socket(d):
    s=socket(AF_INET, SOCK_DGRAM)
    s.bind(('',2342))
    log.debug("begin listen")
    while True:
        pkg,ipport = s.recvfrom(1024)
        try:
            typ = pkg[0]
            if typ == 0x0a:
                log.debug("got hauptschalter")
                action = pkg[1]
                if action == 2:
                    log.debug("pre-shutdown")
                elif action == 1:
                    log.debug("shutdown")
                    run_shelldir(d)
                elif action == 0:
                    print("shutdown successful")
        except Exception as e:
            log.error(e)
            pass

if __name__ == "__main__":
    main()
