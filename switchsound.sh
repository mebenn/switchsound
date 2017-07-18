#!/usr/bin/env bash
help()
{
    cat<<EOF
    Usage: $0 <options> 

    Switch audio cards.
    Get a list of all cards with -l, then switch using -s <sinkl_number>
    n is the sink number of the desired card 

    OPTIONS
    -h help, this text
    -l List of all available cards
    -s <0..9> selects a sink, get a list with the -l option
EOF
}

main ()
{
        #
        # Options
        #
        while getopts "hls:" opt; do
	        case $opt in        
			h)
				help
				exit 0
				;;
			l)
				cmdl_list=True
				;;
			s)
				cmdl_sink=$OPTARG
				;;
			\?)
				echo "Don't know this option"
				exit 0
				;;
		esac
	done

	# If no options, then exit
	if [ $# -eq 0 ]; then
                echo "ERROR: no options, leaving"
                echo "       try using -h to get some help" 
		exit 1
	fi



        if [[ "$cmdl_list" == "True"  ]]; then
                pactl list short sinks
                exit 0
        fi
        if [ ! -z "$cmdl_sink"   ]; then
                pacmd set-default-sink $cmdl_sink
        fi
        
}

# Execute this script
main $@

