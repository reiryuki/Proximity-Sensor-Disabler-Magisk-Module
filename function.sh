# function
mount_partitions_in_recovery() {
if [ "$BOOTMODE" != true ]; then
  BLOCK=/dev/block/bootdevice/by-name
  BLOCK2=/dev/block/mapper
  ui_print "- Recommended to mount all partitions first"
  ui_print "  before installing this module"
  ui_print " "
  DIR=/vendor
  if [ -d $DIR ] && ! is_mounted $DIR; then
    mount -o rw -t auto $BLOCK$DIR$SLOT $DIR\
    || mount -o rw -t auto $BLOCK2$DIR$SLOT $DIR\
    || mount -o rw -t auto $BLOCK/cust $DIR\
    || mount -o rw -t auto $BLOCK2/cust $DIR
  fi
  DIR=/product
  if [ -d $DIR ] && ! is_mounted $DIR; then
    mount -o rw -t auto $BLOCK$DIR$SLOT $DIR\
    || mount -o rw -t auto $BLOCK2$DIR$SLOT $DIR
  fi
  DIR=/system_ext
  if [ -d $DIR ] && ! is_mounted $DIR; then
    mount -o rw -t auto $BLOCK$DIR$SLOT $DIR\
    || mount -o rw -t auto $BLOCK2$DIR$SLOT $DIR
  fi
  DIR=/odm
  if [ -d $DIR ] && ! is_mounted $DIR; then
    mount -o rw -t auto $BLOCK$DIR$SLOT $DIR\
    || mount -o rw -t auto $BLOCK2$DIR$SLOT $DIR
  fi
  DIR=/my_product
  if [ -d $DIR ] && ! is_mounted $DIR; then
    mount -o rw -t auto $BLOCK$DIR $DIR\
    || mount -o rw -t auto $BLOCK2$DIR $DIR
  fi
  DIR=/data
  if [ -d $DIR ] && ! is_mounted $DIR; then
    mount -o rw -t auto $BLOCK/userdata $DIR\
    || mount -o rw -t auto $BLOCK2/userdata $DIR
  fi
  DIR=/cache
  if [ -d $DIR ] && ! is_mounted $DIR; then
    mount -o rw -t auto $BLOCK$DIR $DIR\
    || mount -o rw -t auto $BLOCK2$DIR $DIR
  fi
  DIR=/persist
  if [ -d $DIR ] && ! is_mounted $DIR; then
    mount -o rw -t auto $BLOCK$DIR $DIR\
    || mount -o rw -t auto $BLOCK2$DIR $DIR
  fi
  DIR=/metadata
  if [ -d $DIR ] && ! is_mounted $DIR; then
    mount -o rw -t auto $BLOCK$DIR $DIR\
    || mount -o rw -t auto $BLOCK2$DIR $DIR
  fi
  DIR=/cust
  if [ -d $DIR ] && ! is_mounted $DIR; then
    mount -o rw -t auto $BLOCK$DIR $DIR\
    || mount -o rw -t auto $BLOCK2$DIR $DIR
  fi
fi
}


