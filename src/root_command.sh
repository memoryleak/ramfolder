_SOURCE_DIR=$(realpath ${args[source]})
_TARGET_DIR=$(realpath ${args[target]})
_SOURCE_DIR_NAME=$(basename $_SOURCE_DIR)


echo "$(blue Mounting ) $(yellow $_TARGET_DIR)"
sudo mount -t tmpfs -o size=${args[--size]}G,nodev,nosuid,nodiratime tmpfs $_TARGET_DIR

_TARGET_DIR_LEN=$(echo "$_TARGET_DIR/$_SOURCE_DIR_NAME" | wc -c)
_TARGET_DIR_LEN=$((_TARGET_DIR_LEN+1))

echo $(yellow "$_TARGET_DIR/$_SOURCE_DIR_NAME")

cp -ra $_SOURCE_DIR $_TARGET_DIR

inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' \
  -e close_write $_TARGET_DIR |
while read -r date time dir file; do
    _MOD_PATH=$(realpath "$dir$file")
    _SRC_PATH="$_SOURCE_DIR/$(echo $_MOD_PATH | cut -c$_TARGET_DIR_LEN-)"
    _TIME_STMAP=${date}-${time}

    echo -en "$_TIME_STMAP: $(yellow $_MOD_PATH) \U1F872 $(magenta $_SRC_PATH) "
    $(cp $_MOD_PATH $_SRC_PATH &> /dev/null) && echo "$(green_bold OK)" || echo "$(red_bold ERROR)"

done
