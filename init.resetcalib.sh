#!/system/bin/sh
ALS_FACTOR=$(od -An -t d2 -j 0x114 -N 2 /persist/sensors/sns.reg | xargs echo)
PROX_THRESHOLD=$(od -An -t d2 -j 0x104 -N 2 /persist/sensors/sns.reg | xargs echo)
# Set ALS calibration factor to default if needed
if [[ $ALS_FACTOR = "1200" ]]; then
    cp /persist/sensors/sns.reg /persist/sensors/sns.reg.orig
    xxd /persist/sensors/sns.reg.orig | sed 's/\(00000110: .... ....\) ..../\1 9411/' | xxd -r > /persist/sensors/sns.reg
    RECALIBRATED=1
fi
# Overwrite prox threshold if needed
if [[ $PROX_THRESHOLD = "6656" ]]; then
    cp /persist/sensors/sns.reg /persist/sensors/sns.reg.orig
    xxd /persist/sensors/sns.reg.orig | sed 's/\(00000100: .... ....\) ..../\1 0002/' | xxd -r > /persist/sensors/sns.reg
    RECALIBRATED=1
fi
if [[ -n $RECALIBRATED ]]; then
    echo related > /sys/bus/msm_subsys/devices/subsys5/restart_level
    echo restart > /sys/kernel/debug/msm_subsys/slpi
fi
