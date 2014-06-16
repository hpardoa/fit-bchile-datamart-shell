#!/bin/sh
################################################################################
## Shell ejecuta Job DataStage                                                ##
## Uso:                                                                       ##
## Ejecuta JOB desde Malla Control-M                                          ##
################################################################################
##============================================================================##
################################################################################
## Parametros:                                                                ##
## $1: Fecha de Respaldo (fecha ) entregada por ControlM en formato "YYYYMMDD"##
## $2: Fecha Procesos entregada por ControlM en formato "YYYY-MM-DD"          ##
## $3: Nombre Sequencer                                                       ##
##                             ##
################################################################################
##============================================================================##
################################################################################
## Solicitado por:                                                            ##
##      Banco Chile                                                           ##
## Elaborado por:                                                             ##
##      FACTORIT                                                              ##
## Fecha de Creacion:                                                         ##
##      2014-06-02                                                            ##
## Version:                                                                   ##
##      1.0   												                  ##
################################################################################
##============================================================================##
# Seteo de Variables
sequencer=$3
archlog=/u/ulog/$sequencer.out
datashome=/IBM/InformationServer/Server/DSEngine/bin
arch_conf_Sev="/u/data/CDW/ConfigSev.txt"
proyecto=FactorIT
## Setea directorio
cd /IBM/InformationServer/Server/DSEngine/
. ./dsenv

echo "Proceso:" $sequencer > $archlog
echo "============================================================" >> $archlog
echo "Proceso Ejecutado el dia `date '+%Y-%m-%d %H:%M:%S'`" >> $archlog
if [ $# -ne 5 ]
then
        echo "PROCESO $sequencer FALLIDO ####  Insuficiente numero de parametros" >> $archlog
        exit 1
fi
echo "Fecha de Proceso Ingresada: " $2 >> $archlog
## Ejecucion
$datashome/dsjob -run -mode NORMAL -wait  -param '$FechaProceso='$2 -param '$FechaArchExtraccion='$1 -jobstatus $proyecto $sequencer
## Status Code de la ejecucion del Sequencer
run_stat=$?
echo "Status Code (run_stat): "$run_stat >> $archlog
$datashome/dsjob -jobinfo $proyecto $sequencer >> $archlog


