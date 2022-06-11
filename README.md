# What's that

It's a batch of Tcl/Tk themes used in [alited](https://aplsimple.github.io/en/tcl/alited) editor.

The batch contains a bit modified themes made by [rdbende](https://github.com/rdbende):

  * azure light and dark
  * forest light and dark
  * sun-valley light and dark

The modifications are mostly about:

  * focusing widgets (with Tab key)
  * colors of widgets
  * colors of menu
  * treeview's behavior
  * corners of widgets

# Usage

The themes are used as follows:

    # azure light:
    source azure/azure.tcl
    set_theme light

    # azure dark:
    source azure/azure.tcl
    set_theme dark

    # sun-valley light:
    source sun-valley/sun-valley.tcl
    set_theme light

    # sun-valley dark:
    source sun-valley/sun-valley.tcl
    set_theme dark

    # forest light:
    source forest/forest-light.tcl
    ttk::style theme use forest-light

    # forest dark:
    source forest/forest-dark.tcl
    ttk::style theme use forest-dark

An example of usage is *test.tcl*. It requires [apave](https://aplsimple.github.io/en/tcl/pave) package.

In [alited](https://aplsimple.github.io/en/tcl/alited) editor, the themes are used along with color schemes (see *ini.tcl* of [alited source](https://github.com/aplsimple/alited)). The color schemes are provided by [apave](https://aplsimple.github.io/en/tcl/pave) package.

# Links

  * Download links:

      * [themes at chiselapp](https://chiselapp.com/user/aplsimple/repository/ale_themes/download)
      * [themes at github](https://github.com/aplsimple/ale_themes)

  * [rdbende](https://github.com/rdbende)

  * [alited](https://aplsimple.github.io/en/tcl/alited)

  * [apave](https://aplsimple.github.io/en/tcl/pave)

# Demos

  * [demo of ale_themes](https://github.com/aplsimple/ale_themes/releases/download/ale_themes-1.0/ale_themes.mp4)

  * [demo of alited v1.2.3](https://github.com/aplsimple/alited/releases/download/6.Themes_alited-1.2.3/6.Themes_alited-1.2.3.mp4)

  * [demo of apave v3.4.6](https://github.com/aplsimple/pave/releases/download/apave-theming.3.4.6/apave-theming.3.4.6.mp4)

Below is a screenshot of localized [alited](https://aplsimple.github.io/en/tcl/alited), with *sun-valley dark theme*:

<img src="https://aplsimple.github.io/en/tcl/alited/files/alited-ru.png" class="media" alt="">
