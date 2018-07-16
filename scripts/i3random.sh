#!/bin/bash
#i3lock -c $(printf \\"%.2x\\" $(($RANDOM % 255)))$(printf \\"%.2x\\" $(($RANDOM % 255)))$(printf \\"%.2x\\" $(($RANDOM % 255)))
i3lock -c $(printf "%.2x" $(($RANDOM % 255)))$(printf "%.2x" $(($RANDOM % 255)))$(printf "%.2x" $(($RANDOM % 255)))
