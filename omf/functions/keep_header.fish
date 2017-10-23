function keep_header --description "Print the first n lines directly to stdout and pass the rest lines to the given command"
    # Adapted from https://unix.stackexchange.com/a/11859
    # Failed
    if test (count $argv) -le 1
        printf "Not enough arguments. Pass n for #lines as the header and the command to run."
        return 1
    end
    set -l n $argv[1]
    # For the first n lines of stdin, read them and output them immediately
    if test $n -ge 1
        for i in (seq $n)
            read -l header
            printf $header
        end
    end
    # Then invoke the actual program, which will continue to read the rest of the stdin
    eval $argv[2..-1]
end
