# shellcheck disable=SC2148,SC2086
ui_print ""

if [ $ARCH = "arm" ]; then
    # arm
    ARCH_LIB=armeabi-v7a
    alias cmpr='$MODPATH/bin/arm/cmpr'
elif [ $ARCH = "arm64" ]; then
    # arm64
    ARCH_LIB=arm64-v8a
    alias cmpr='$MODPATH/bin/arm64/cmpr'
else
    abort "ERROR: unsupported arch: ${ARCH}"
fi
set_perm_recursive $MODPATH/bin 0 0 0755 0777

su -M -c grep com.google.android.googlequicksearchbox /proc/mounts | while read -r line; do
    ui_print "* Un-mount"
    mp=${line#* }
    mp=${mp%% *}
    su -M -c umount -l "${mp%%\\*}"
done
am force-stop com.google.android.googlequicksearchbox

# Check if Google Quick Search Box is installed
if BASEPATH=$(pm path com.google.android.googlequicksearchbox); then
    BASEPATH=${BASEPATH##*:}
    BASEPATH=${BASEPATH%/*}

    # Check if the installed version is not 1.0.0
    VERSION=$(dumpsys package com.google.android.googlequicksearchbox | grep -m1 versionName)
    VERSION="${VERSION#*=}"
    
    if [ "$VERSION" != "1.0.0" ]; then
        # Uninstall the installed version
        pm uninstall -k --user 0 com.google.android.googlequicksearchbox
        pm uninstall -k --user 0 com.android.hotwordenrollement.okgoogle
    fi
fi

# Step 8: Cleanup
rm -rf $MODPATH/bin $MODPATH/com.google.android.googlequicksearchbox

for s in "uninstall.sh" "service.sh"; do
    sed -i "2 i\NVBASE=${NVBASE}" $MODPATH/$s
done

ui_print "*************************************"
ui_print " "
ui_print " -------killed by Enok-Seth----------"
ui_print " "
ui_print " Removed HotWord Ok Google..."
ui_print " "
ui_print " Removed Quick-Search-Box related app"
ui_print " "
ui_print " -------(github.com/enokseth)--------"
ui_print " "