#!/bin/sh

acpi -b | awk '{print $4;}'
