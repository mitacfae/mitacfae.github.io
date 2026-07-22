#!/bin/bash

BUS=0x1
EEPROM_ADDR=0xa0
READ_COUNT=0x0
EEPROM_OFFSET_HIGH=0x23
EEPROM_OFFSET_LOW=0x00
DATA=""
POH_SIZE=256

for ((i=0;i<32;i++))
	do
		DATA="${DATA} 0x00"
	done

## oem master write command only can support 50 bytes write data , so we send 32 x 8times to clean the poh full data

OFFSET=("0x00" "0x20" "0x40" "0x60" "0x80" "0xa0" "0xc0" "0xe0")
for EEPROM_OFFSET_LOW in "${OFFSET[@]}"; 
do
	ipmitool -I lanplus -H $3 -U $1 -P $2 raw 0x2e 0x09 0xfd 0x19 0x00 $BUS $EEPROM_ADDR $READ_COUNT $EEPROM_OFFSET_HIGH $EEPROM_OFFSET_LOW $DATA

done


##reboot bmc to reload the poh
echo "########### Warnnign  BMC rebooting ##############"
ipmitool -I lanplus -H $3 -U $1 -P $2 mc reset cold

