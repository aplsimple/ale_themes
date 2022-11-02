#! /usr/bin/env tclsh
###########################################################
# Name:    test.tcl
# Author:  Alex Plotnikov  (aplsimple@gmail.com)
# Date:    12/27/2021
# Brief:   Handles testing ale_themes.
# License: MIT.
###########################################################

package require Tk

# ________________________ Packages _________________________ #

# change apave package's location at need:
lappend auto_path "../pave"

set ::testdirname [file normalize [file dirname [info script]]]
catch {cd $::testdirname}
if {[catch {package require apave}]} {
  puts " \
\nThe 'apave' package is required for running this test. \
\n\nThe 'apave' package is available in: \
\nhttps://github.com/aplsimple/pave\n"
  exit
}

# ________________________ Procs _________________________ #

proc Set_Theme {} {
  switch $::theme {
    "azure light" {
      source azure/azure.tcl
      if {[catch {set_theme light}]} {ttk::style theme use azure-light}
    }

    "azure dark" {
      source azure/azure.tcl
      if {[catch {set_theme dark}]} {ttk::style theme use azure-dark}
    }

    "sun-valley light" {
      source sun-valley/sun-valley.tcl
      if {[catch {set_theme light}]} {ttk::style theme use sun-valley-light}
    }

    "sun-valley dark" {
      source sun-valley/sun-valley.tcl
      if {[catch {set_theme dark}]} {ttk::style theme use sun-valley-dark}
    }

    "forest light" {
      catch {source forest/forest-light.tcl}
      ttk::style theme use forest-light
    }

    default {
      catch {source forest/forest-dark.tcl}
      ttk::style theme use forest-dark
    }
  }
}
#_______________________

proc Lock {} {
  if {$::sw} {set st normal} {set st disabled}
  foreach widget {Cbx1 But1 Chb1 Rad1} {
    [pave $widget] configure -state $st
  }
}

# ________________________ Layout test _________________________ #

set v1 [set v2 [set sw 1]]
set c1 [set c2 [set c3 [set c4 0]]]
set en1 [set en2 {}]
set tip "Hit to restart the test and\nset the theme from scratch."
if {[llength $::argv]} {
  lassign $::argv theme en1 en2 v1 c1 c2 c3 v2 c4 sw
} else {
  set theme "azure light"
}
Set_Theme

# This test 1 demonstrates how easily the standard dialog "Search & Replace"
# can be created by means of the pave.

apave::initWM -theme {}

apave::APave create pave
set win .win
pave makeWindow $win.fra "Find and Replace"
pave paveWindow $win.fra {
  {lab0 - - 1 1    {-st e}  {-t "Theme: "}}
  {Cbx0 lab0 L 1 7 {-st wes} {-tvar ::theme -values {"azure light" "azure dark" "sun-valley light" "sun-valley dark" "forest light" "forest dark"} -state readonly -selcombobox ::Set_Theme}}
  {swi1 cbx0 L 1 1    {-st e}  {-t "Lock" -var ::sw -com ::Lock -afteridle ::Lock}}
  {lab1 lab0 T 1 1    {-st e}  {-t "Find: "}}
  {Cbx1 lab1 L 1 9 {-st wes} {-tvar ::en1 -values {"find 1" "find 2" "find 3"}}}
  {lab2 lab1 T 1 1 {-st e}  {-t "Replace: " -style TLabelFS}}
  {cbx2 lab2 L 1 9 {-st wes} {-tvar ::en2 -values {"replace 1" "replace 2" "replace 3"}}}
  {labm lab2 T 1 1 {-st e}  {-t "Match: "}}
  {radA labm L 1 1 {-st es -padx 0}  {-t "Exact" -var ::v1 -value 1}}
  {radB radA L 1 1 {-st ws -padx 5}  {-t "Glob" -var ::v1 -value 2}}
  {radC radB L 1 5 {-st ws -padx 0 -cw 1}  {-t "RE  " -var ::v1 -value 3}}
  {h_2 labm T 1 9  {-st es -rw 1}}
  {seh0  h_2 T 1 9  {-st ews}}
  {Chb1 seh0 T 1 2 {-st w} {-t "Match whole word only" -var ::c1}}
  {chb2 chb1 T 1 2 {-st w} {-t "Match case"  -var ::c2}}
  {chb3 chb2 T 1 2 {-st w} {-t "Replace by blank" -var ::c3}}
  {h_4 chb3 T 1 1}
  {seh1 h_4 T 1 11 {-st ews}}
  {sev1 chb1 L 4 1}
  {fralab3 sev1 L 4 6 {-st nsw -pady 0} {-borderwidth 0}}
  {.lab3 - - - - {pack -anchor w} {-t "Direction:"}}
  {.Rad1 - - - - {pack -anchor w -padx 0} {-t "Up"   -var ::v2 -value 1}}
  {.rad2 - - - - {pack -anchor w -padx 0} {-t "Down" -var ::v2 -value 2}}
  {.chb4 - - - - {pack -anchor sw} {-t "Wrap around" -var ::c4}}
  {sev2 swi1 L 10 1}
  {But1 sev2 L 1 1 {-st wes -pady 2} {-t Find -tip {$::tip} -com "::pave res $win 1"}}
  {But2 but1 T 1 1 {-st we  -pady 0} {-t "All in Text" -tip {$::tip} -com ":::pave res $win 2"}}
  {But3 but2 T 1 1 {-st wen -pady 2} {-t "All in Session" -tip {$::tip} -com "::pave res $win 3"}}
  {h_3 but3 T 2 1 {-st ews}}
  {seh2 h_3 T 1 1 {-st ews}}
  {but4 seh2 T 1 1 {-st wes -pady 4} {-t Replace -tip {$::tip} -com "::pave res $win 4"}}
  {but5 but4 T 1 1 {-st we  -pady 0} {-t "All in Text" -tip {$::tip} -com "::pave res $win 5"}}
  {But6 but5 T 1 1 {-st wen -pady 4} {-t "All in Session" -tip {$::tip} -com "::pave res $win 6"}}
  {lfr seh1 T 1 9 {-st nswe -pady 4} {-t "Labeled frame"}}
  {.lab - - - - {-st nswe -pady 4} {-t "\nLabel inside the frame\n"}}
}

# ________________________ Transpops _________________________ #

  set TRANSPOPS_SRC [file normalize ~/PG/github/transpops/transpops.tcl]
  source $TRANSPOPS_SRC

  set DEMODIR [file normalize ~/PG/github/DEMO/ale_themes]
  if {[file exists [set fname [file normalize [file join $DEMODIR transpops.txt]]]]} {
    ::transpops::run $fname {<Alt-t> <Alt-y>} $win
  }


# ________________________ Run test _________________________ #

set res [pave showModal $win -focus $win.fra.cbx1]

puts " \
  Entry1=$en1 \n \
  Entry2=$en2 \n \
  E/G/R=$v1 \n \
  ______________________________      \n \
  \n \
  CheckBox1=$c1 \n \
  CheckBox2=$c2 \n \
  CheckBox3=$c3 \n \
  ______________________________      \n \
  \n \
  Direction=$v2 \n \
  CheckBox4=$c4 \n \
  ______________________________      \n \
  \n \
  Button chosen=$res \n \
  "
pave destroy
destroy $win
if {$res} {
  exec [info nameofexecutable] [info script] $theme \
    $en1 $en2 $v1 $c1 $c2 $c3 $v2 $c4 $sw &
}
exit

# ________________________ EOF _________________________ #
