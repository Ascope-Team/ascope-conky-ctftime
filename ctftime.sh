ARCHIVE=$1
RUNNING=$2
UPCOMING=$3

# Debugging
: '
echo $ARCHIVE
echo $RUNNING
echo $UPCOMING
'

if [[ "$ARCHIVE" -ne "false" ]] && [[ "$ARCHIVE" -ne "true" ]]; then
    ARCHIVE=false
fi

if [[ "$RUNNING" -ne "false" ]] && [[ "$RUNNING" -ne "true" ]]; then
    RUNNING=false
fi

if [[ "$UPCOMING" -ne "false" ]] && [[ "$UPCOMING" -ne "true" ]]; then
    UPCOMING=false
fi

# Variables to tweak

N_BEFORE_WEEK=2
N_AFTER_WEEK=3

start=$(date -d "-$N_BEFORE_WEEK weeks" +%s)
finish=$(date -d "+$N_AFTER_WEEK weeks" +%s)

# Debugging
: '
echo $start
echo $finish
'

result="$(curl -s "https://ctftime.org/api/v1/events/?limit=100&start=$start&finish=$finish")"

readarray -t title_array <<< $( echo $result | grep -Po '"title":.*?[^\\]",' | cut -f 1 -d ':' --complement | rev | cut -c3- | rev | cut -c3-)
readarray -t start_array <<< $( echo $result | grep -Po '"start":.*?[^\\]",' | cut -f 1 -d ':' --complement | rev | cut -c3- | rev | cut -c3-)
readarray -t finish_array <<< $( echo $result | grep -Po '"finish":.*?[^\\]",' | cut -f 1 -d ':' --complement | rev | cut -c3- | rev | cut -c3-)
readarray -t url_array <<< $( echo $result | grep -Po '"url":.*?[^\\]",' | cut -f 1 -d ':' --complement | rev | cut -c3- | rev | cut -c3-)
readarray -t weight_array <<< $( echo $result | grep -Po '"weight":.*?[^\\],' | cut -c11- | rev | cut -c2- | rev)

# Debugging
: '
echo "${title_array[*]}"
echo "${start_array[*]}"
echo "${finish_array[*]}"
echo "${url_array[*]}"
echo "${weight_array[*]}"
'

pad=$(printf '%0.1s' "-"{1..60});
 
for ((i=0; i<${#weight_array[@]}; i++));
do
    current_time=$(date +%s)
    start_time=$(date +%s -d "${start_array[i]}")
    finish_time=$(date +%s -d "${finish_array[i]}")

    start_time_reformat=$(date -d "${start_array[i]}" +"%b %a %d %H:%M %p")
    finish_time_reformat=$(date -d "${finish_array[i]}" +"%b %a %d %H:%M %p")

    duration=$( echo $(( ( `date +%s -d "${finish_array[i]}"` - `date +%s -d "${start_array[i]}"` ) / 3600 )) )

    if [[ "$current_time" > "$finish_time" ]]; then
        if [[ "$ARCHIVE" = "true" ]]; then
            printf '%*.*s %s' 0 32 "${title_array[i]} $pad" "$start_time_reformat — $finish_time_reformat "
            printf '%3d\n' $duration
        fi
    elif [[ "$current_time" > "$start_time" ]] && [[ "$current_time" < "$finish_time" ]]; then
        if [[ "$RUNNING" = "true" ]]; then
            printf '%*.*s %s' 0 32 "${title_array[i]} $pad" "$start_time_reformat — $finish_time_reformat "
            printf '%3d\n' $duration
        fi
    else
        if [[ "$UPCOMING" = "true" ]]; then
            printf '%*.*s %s' 0 32 "${title_array[i]} $pad" "$start_time_reformat — $finish_time_reformat "
            printf '%3d\n' $duration
        fi
    fi
done
