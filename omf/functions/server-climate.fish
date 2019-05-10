function server-climate --description "Check the server CPU usage."
    switch (hostname)
        case 'katmai'
            parallel -j4 --keep-order \
                'ssh {} "echo \$(hostname)\":\"' \
                '\$(top -b -n2 -d 1 -p 1 ' \
                '| sed -nr \"s/.*, *([0-9.]+)* id.*/\1/p\"' \
                '| awk \'{print 100 - \$1\"%\"}\')"' \
                ::: katmai kenai kobuk sitka  # add more server names here
        case '*'
            printf "I don't know how to read the CPU usage here. Try htop instead."
    end
end
