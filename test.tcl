#! /usr/bin/env tclsh
#
# This test needs apave package installed by side it.
# 
# The package is available at:
# https://chiselapp.com/user/aplsimple/repository/pave/download
# 
###############################################################

package require Tk

# change apave package's location at need:
lappend auto_path "../pave"

set ::testdirname [file normalize [file dirname [info script]]]
catch {cd $::testdirname}
package require apave

# set a theme to test

set theme "forest dark"

switch $theme {
  "azure light" {
    source azure/azure.tcl
    set_theme light
  }

  "azure dark" {
    source azure/azure.tcl
    set_theme dark
  }

  "sun-valley light" {
    source sun-valley/sun-valley.tcl
    set_theme light
  }

  "sun-valley dark" {
    source sun-valley/sun-valley.tcl
    set_theme dark
  }

  "forest light" {
    source forest/forest-light.tcl
    ttk::style theme use forest-light
  }

  "forest dark" {
    source forest/forest-dark.tcl
    ttk::style theme use forest-dark
  }
}

# This test 1 demonstrates how easily the standard dialog "Search & Replace"
# can be created by means of the pave.

apave::initWM -theme {}
apave::APave create pave
set win .win
pave makeWindow $win.fra "Find and Replace"
set v1 [set v2 1]
set c1 [set c2 [set c3 [set c4 0]]]
set en1 [set en2 ""]
pave paveWindow $win.fra {
  {lab1 - - 1 1    {-st e}  {-t "Find: "}}
  {Cbx1 lab1 L 1 9 {-st wes} {-tvar ::en1 -values {"to find 1" "to find 2" "to find 3"}}}
  {lab2 lab1 T 1 1 {-st e}  {-t "Replace: " -style TLabelFS}}
  {cbx2 lab2 L 1 9 {-st wes} {-tvar ::en2 -values {"replace 1" "replace 2" "replace 3"}}}
  {labm lab2 T 1 1 {-st e}  {-t "Match: "}}
  {radA labm L 1 1 {-st es -padx 0}  {-t "Exact" -var ::v1 -value 1}}
  {radB radA L 1 1 {-st ws -padx 5}  {-t "Glob" -var ::v1 -value 2}}
  {radC radB L 1 5 {-st ws -padx 0 -cw 1}  {-t "RE  " -var ::v1 -value 3}}
  {h_2 labm T 1 9  {-st es -rw 1}}
  {seh1  h_2 T 1 9  {-st ews}}
  {chb1 seh1 T 1 2 {-st w} {-t "Match whole word only" -var ::c1}}
  {chb2 chb1 T 1 2 {-st w} {-t "Match case"  -var ::c2}}
  {chb3 chb2 T 1 2 {-st w} {-t "Replace by blank" -var ::c3}}
  {sev1 chb1 L 4 1}
  {fralab3 sev1 L 4 6 {-st nsw -pady 0} {-borderwidth 0}}
  {.lab3 - - - - {pack -anchor w} {-t "Direction:"}}
  {.rad1 - - - - {pack -anchor w -padx 0} {-t "Up"   -var ::v2 -value 1}}
  {.rad2 - - - - {pack -anchor w -padx 0} {-t "Down" -var ::v2 -value 2}}
  {.chb4 - - - - {pack -anchor sw} {-t "Wrap around" -var ::c4}}
  {sev2 cbx1 L 9 1}
  {But1 sev2 L 1 1 {-st wes -pady 2} {-t Find -com "::pave res $win 1"}}
  {But2 but1 T 1 1 {-st we  -pady 0} {-t "All in Text" -com ":::pave res $win 2"}}
  {But3 but2 T 1 1 {-st wen -pady 2} {-t "All in Session" -com "::pave res $win 3"}}
  {seh2 but3 T 1 1 {-st ews}}
  {seh3 seh2 T 1 1 {-st ews}}
  {but4 seh3 T 1 1 {-st wes -pady 4} {-t Replace -com "::pave res $win 4"}}
  {but5 but4 T 1 1 {-st we  -pady 0} {-t "All in Text" -com "::pave res $win 5"}}
  {But6 but5 T 1 1 {-st wen -pady 4} {-t "All in Session" -com "::pave res $win 6"}}
}
set res [pave showModal $win -focus $win.fra.cbx1]
puts "
    Entry1=$en1
    Entry2=$en2
    E/G/R=$v1
    CheckBox1=$c1
    CheckBox2=$c2
    CheckBox3=$c3
    CheckBox4=$c4
    Direction=$v2
    Result=$res
    "
pave destroy
destroy $win

exit


