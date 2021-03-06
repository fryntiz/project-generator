#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-
##
## @author     Raúl Caro Pastorino
## @copyright  Copyright © 2017 Raúl Caro Pastorino
## @license    https://wwww.gnu.org/licenses/gpl.txt
## @email      tecnico@fryntiz.es
## @web        www.fryntiz.es
## @github     https://github.com/fryntiz
## @gitlab     https://gitlab.com/fryntiz
## @twitter    https://twitter.com/fryntiz
##
##             Guía de estilos aplicada:
## @style      https://github.com/fryntiz/Bash_Style_Guide

############################
##     INSTRUCCIONES      ##
############################
## Script principal que gestiona todo el programa
## $1 Recibe como primer parámetro la ruta donde trabajar
## $2 Recibe como segundo parámetro el tipo de proyecto (Opcional)
## $3 Recibe como tercer parámetro el nombre para el proyecto (Opcional)

############################
##       CONSTANTES       ##
############################
AM="\033[1;33m"  ## Color Amarillo
AZ="\033[1;34m"  ## Color Azul
BL="\033[1;37m"  ## Color Blanco
CY="\033[1;36m"  ## Color Cyan
GR="\033[0;37m"  ## Color Gris
MA="\033[1;35m"  ## Color Magenta
RO="\033[1;31m"  ## Color Rojo
VE="\033[1;32m"  ## Color Verde
CL="\e[0m"       ## Limpiar colores

WORKSCRIPT="$1"  ## Directorio principal del script recibido en la llamada
USER=$(whoami)   ## Usuario que ejecuta el script
VERSION='0.3.0'  ## Versión en desarrollo

############################
##     IMPORTACIONES      ##
############################
source "$WORKSCRIPT/funciones.sh"
source "$WORKSCRIPT/php-yii-basic/generar.sh"
source "$WORKSCRIPT/php-yii-advanced/generar.sh"
source "$WORKSCRIPT/python/generar.sh"
source "$WORKSCRIPT/bash/generar.sh"
source "$WORKSCRIPT/angular/generar.sh"
source "$WORKSCRIPT/node-module/generar.sh"
source "$WORKSCRIPT/blask/generar.sh"
source "$WORKSCRIPT/hexo/generar.sh"
source "$WORKSCRIPT/javascript/generar.sh"
source "$WORKSCRIPT/php-api-slim/generar.sh"

###########################
##       VARIABLES       ##
###########################
nombre=''  ## El nombre del proyecto

###########################
##       FUNCIONES       ##
###########################
## Menú principal
menu_principal() {
    nombreProyecto  ## Pide el nombre del proyecto

    while true; do
        clear
        echo -e "$VE Bienvenido al menú principal, selecciona un proyecto$CL"
        echo ""

        echo -e "$RO 1)$AZ Proyecto JS básico$RO (js|javascript)$CL"
        #echo -e "$RO 2)$AZ Proyecto php básico$RO (php)$CL"
        echo -e "$RO 3)$AZ Proyecto Bash básico$RO (bash)$CL"
        echo -e "$RO 4)$AZ Proyecto Python 3 básico$RO (python|python3)$CL"
        #echo -e "$RO 5)$AZ Proyecto Python 2$RO (python2)$CL"
        #echo -e "$RO 6)$AZ Proyecto Python Django$RO (django)$CL"
        #echo -e "$RO 7)$AZ Proyecto PHP Laravel$RO (laravel)$CL"
        echo -e "$RO 8)$AZ Proyecto PHP YII Básico$RO (yii|yii2)$CL"
        #echo -e "$RO 9)$AZ Proyecto PHP YII Avanzado$RO (yii-adv|yii2-adv)$CL"
        echo -e "$RO 10)$AZ Proyecto JS con Angular$RO (a|ang|angular)$CL"
        echo -e "$RO 11)$AZ Proyecto Módulo NodeJS$RO (n|nod|node)$CL"
        echo -e "$RO 12)$AZ Proyecto Blask (Microblog)$RO (blask)$CL"
        echo -e "$RO 13)$AZ Proyecto Hexo (Microblog)$RO (hexo)$CL"
        echo -e "$RO 14)$AZ Proyecto PHP API con Slim$RO (slim|phpslim|phpapi)
$CL"
        echo -e "$RO 0)$AZ Salir$CL"
        echo ""
        echo -e "$RO Introduce el proyecto"
        read -p '  → ' entrada
        echo -e "$CL"

        case $entrada in
            1) generar_javascript && exit 0;;
            3) generar_bash && exit 0;;
            4) generar_python && exit 0;;
            8) generar_php_yii_basic && exit 0;;
            #9) generar_php_yii_advanced && exit 0;;
            10) generar_angular && exit 0;;
            11) generar_node-module && exit 0;;
            12) generar_blask && exit 0;;
            13) generar_hexo && exit 0;;
            14) generar_php_api_slim && exit 0;;
            0) exit 0;;
            *) clear; echo -e "$RO Opción no válida$CL"; read;;
        esac
    done
}

## Recibe el tipo de proyecto y ejecuta la función correspondiente,
## opcionalmente admite recibir el nombre del proyecto.
## $1 Tipo de proyecto
## $2 Nombre del proyecto (Opcional)
proyectos() {
    ## Comprueba nombre o lo pide
    if [[ -z "$2" ]]; then
        nombreProyecto  ## Pide el nombre de proyecto
    else
        nombre="$2"     ## Asigna el nombre introducido
    fi

    ## Ejecuta el script generador correspondiente o sale con aviso y error
    case "$1" in
        'js' | 'javascript') generar_javascript && exit 0;;
        'slim' | 'phpslim' | 'phpapi') generar_php_api_slim && exit 0;;
        'yii' | 'yii2') generar_php_yii_basic && exit 0;;
        'bash') generar_bash && exit 0;;
        'python' | 'python3') generar_python && exit 0;;
        'a' | 'ang' |'angular') generar_angular && exit 0;;
        'n' | 'nod' |'node') generar_node-module && exit 0;;
        'blask') generar_blask && exit 0;;
        'hexo') generar_hexo && exit 0;;
        *) clear; echo -e "$RO Tipo de proyecto$RO no válido$CL"; exit 1;;
    esac
}

###########################
##       EJECUCIÓN       ##
###########################
if [[ $# = 1 ]]; then
    menu_principal
elif [[ $# = 2 ]]; then
    proyectos "$2"
elif [[ $# = 3 ]]; then
    proyectos "$2" "$3"
else
    clear
    echo -e "$RO Opción no válida$CL"
    exit 1
fi

exit 0
