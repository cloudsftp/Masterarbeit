#!/bin/bash

help_msg() {
    echo "Usage: $0 (-s | --start) xStart yStart (-e | --end) xEnd yEnd [OPTIONS]"
    echo "Options:"
    echo "      -x xPoint   search for coordinates on line with x coordinate xPoint"
    echo "      -y yPoint   search for coordinates on line with y coordinate yPoint"
    echo "      -l length   search for point length along the line"
    exit 2
}

while [ $# -gt 0 ]; do
    case "$1" in
        -s | --start)
            xStart="$2"
            yStart="$3"
            shift
            shift
            shift
            ;;
        -e | --end)
            xEnd="$2"
            yEnd="$3"
            shift
            shift
            shift
            ;;
        -x)
            xPoint="$2"
            shift
            shift
            ;;
        -y)
            yPoint="$2"
            shift
            shift
            ;;
        -l)
            length="$2"
            shift
            shift
            ;;
        *)
            help_msg
            ;;
    esac
done

[ -z "$xStart" ] && help_msg
[ -z "$yStart" ] && help_msg
[ -z "$xEnd" ] && help_msg
[ -z "$yEnd" ] && help_msg

[ -z "$xPoint" ] && [ -z "$yPoint" ] && [ -z "$length" ] && help_msg

xLength="$(echo "$xEnd - $xStart" | bc)"
yLength="$(echo "$yEnd - $yStart" | bc)"

echo "Line from ($xStart, $yStart) to ($xEnd, $yEnd)"
echo

[ -n "$xPoint" ] && echo "Calculating point with x=$xPoint" && yPoint="$(echo "scale=4; $yStart + ($xPoint - $xStart) * $yLength / $xLength" | bc)"
[ -n "$yPoint" ] && echo "Calculating point with y=$yPoint" && xPoint="$(echo "scale=4; $xStart + ($yPoint - $yStart) * $xLength / $yLength" | bc)"
[ -n "$length" ] && echo "Calculating point with l=$length" && xPoint="$(echo "scale=4; $xStart + $length * $xLength" | bc)" && yPoint="$(echo "scale=4; $yStart + $length * $yLength" | bc)"

echo
echo "Result: ($xPoint, $yPoint)"
