# piecrumbs.txt

Displays current location in Python classes/methods.

# INTRO

This plugin displays a colored breadcrumbs string under statusline using echo command. I wanted a lightweight plugin for this so I decided to write my own.

Once you move your cursor, it will traverse through the higher level class and methods until it reaches function/class definition with no indentation. It will display the collected info using echo command.

# CONFIGURATION

- `g:piecrumbs_auto` - If enabled, piecrumbs will automatically echo current breadcrumbs once you move your cursor in Normal or Insert modes. Defaults to 1 (enabled.)

- `g:piecrumbs_show_signatures` - If enabled, piecrumbs will display class & method signatures near each breadcrumb. Defaults to 1 (enabled.)

- `g:piecrumbs_glue` - String to use as glue for breadcrumbs. Defaults to ''.

