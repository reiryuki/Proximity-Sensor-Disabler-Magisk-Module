# space
ui_print " "

# var
UID=`id -u`
[ ! "$UID" ] && UID=0

# log
if [ "$BOOTMODE" != true ]; then
  FILE=/data/media/"$UID"/$MODID\_recovery.log
  ui_print "- Log will be saved at $FILE"
  exec 2>$FILE
  ui_print " "
fi

# optionals
OPTIONALS=/data/media/"$UID"/optionals.prop
if [ ! -f $OPTIONALS ]; then
  touch $OPTIONALS
fi

# debug
if [ "`grep_prop debug.log $OPTIONALS`" == 1 ]; then
  ui_print "- The install log will contain detailed information"
  set -x
  ui_print " "
fi

# recovery
if [ "$BOOTMODE" != true ]; then
  MODPATH_UPDATE=`echo $MODPATH | sed 's|modules/|modules_update/|g'`
  rm -f $MODPATH/update
  rm -rf $MODPATH_UPDATE
fi

# run
. $MODPATH/function.sh

# info
MODVER=`grep_prop version $MODPATH/module.prop`
MODVERCODE=`grep_prop versionCode $MODPATH/module.prop`
ui_print " ID=$MODID"
ui_print " Version=$MODVER"
ui_print " VersionCode=$MODVERCODE"
if [ "$KSU" == true ]; then
  ui_print " KSUVersion=$KSU_VER"
  ui_print " KSUVersionCode=$KSU_VER_CODE"
  ui_print " KSUKernelVersionCode=$KSU_KERNEL_VER_CODE"
else
  ui_print " MagiskVersion=$MAGISK_VER"
  ui_print " MagiskVersionCode=$MAGISK_VER_CODE"
fi
ui_print " "

# recovery
mount_partitions_in_recovery

# mode
ui_print "- Reading library..."
STRINGS=`strings /*/lib*/*sensor* | grep proximity`
ui_print "$STRINGS"
ui_print " "
if [ "`grep_prop proximity.disabler $OPTIONALS`" == fusion ]; then
  if echo "$STRINGS" | grep -q vendor.sensor.proximity_fusion.enabled; then
    ui_print "- Does not disable proximity sensor"
    ui_print "  but disables proximity fusion sensor only"
    rm -rf $MODPATH/system
    sed -i 's|ro.vendor.sensors.proximity|#ro.vendor.sensors.proximity|g' $MODPATH/system.prop
    sed -i 's|ro.qti.sensors.proximity|#ro.qti.sensors.proximity|g' $MODPATH/system.prop
    ui_print " "
  else
    abort "! This ROM does not support proximity fusion"
  fi
else
  if ! echo "$STRINGS" | grep -Eq 'ro.vendor.sensors.proximity|ro.qti.sensors.proximity'; then
    ui_print "- Not possible to deactivate proximity sensor completely"
    ui_print "  to this ROM but don't worry, this module now removes"
    ui_print "  hardware proximity feature systemlessly, so it's the same"
    ui_print "  like disabling proximity sensor function and it will"
    ui_print "  deactivate all proximity sensor ROM features."
  fi
fi







