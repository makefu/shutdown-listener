#!/bin/sh
echo "Shutting down Filebitch"
if ssh root@10.42.14.43 -i /root/.ssh/id_rsa "shutdown -h now"; then
    echo "Filebitch Shutdown successful"
else
    echo "Filebitch Shutdown failed"
fi

