#!/usr/bin/env tclsh
if {[info exists env(QUERY_STRING)]} {
    set tz $env(QUERY_STRING)
    puts "content-type: text/plain\n\n"
} elseif {[info exists $argv]} {
    set tz [lindex $argv 0]
} else {
    set tz :UTC
}
proc rfc3339 {tz} {
    set us [clock microseconds]
    set sec [expr {$us / 1000000}]
    set micro [expr {$us % 1000000}]
    set ts [clock format $sec -format "%Y-%m-%dT%T" -timezone $tz]
    regexp {(...)(..)} [clock format $sec -format "%z"] matched tzh tzm
    return [format "%s.%06s%s:%s" $ts $micro $tzh $tzm]
}

if {[info exists env(GATEWAY_INTERFACE)]} {
  puts "content-type: text/plain\n"
}
puts [rfc3339 $tz]
