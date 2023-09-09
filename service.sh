#!/system/bin/sh
# shellcheck disable=SC2086
MODDIR=${0%/*}

until [ "$(getprop sys.boot_completed)" = 1 ]; do sleep 1; done
until [ -d "/sdcard/Android" ]; do sleep 1; done
while
    BASEPATH=$(pm path com.google.android.googlequicksearchbox)
    svcl=$?
    [ $svcl = 20 ]
do sleep 2; done
sleep 5

err() {
    [ ! -f $MODDIR/err ] && cp $MODDIR/module.prop $MODDIR/err
    sed -i "s/^des.*/description=⚠️ Le Module na pas encore supprimer G-Voice: '${1}'/g" $MODDIR/module.prop
}

if [ $svcl = 0 ]; then
    BASEPATH=${BASEPATH##*:}
    BASEPATH=${BASEPATH%/*}
    if [ -d $BASEPATH/lib ]; then
        grep com.google.android.googlequicksearchbox /proc/mounts | while read -r line; do
            mp=${line#* }
            mp=${mp%% *}
            umount -l ${mp%%\\*}
        done
        pm disable-user --user 0 com.google.android.googlequicksearchbox
        pm disable-user --user 0 com.android.hotwordenrollement.okgoogle
        ui_print 'Google Voice kill success !'
    else
        ui_print "Uninstallation HotWord "Ok Google" Fine"
    fi
else
    ui_print "Uninstallation "Quick Search Box" Done"
fi

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
