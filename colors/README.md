# costumize vivid

LS_COLORS="$(vivid generate $ZDOTDIR/vivid/color-schema.yml)"

echo 'export LS_COLORS="$(vivid generate color-schema.yml)"' >> .zshrc

```sh
for theme in $(vivid themes); do
    echo "Theme: $theme"
    LS_COLORS=$(vivid generate $theme)
    command ls -Al
    echoDatei in eine Markdown-Tabelle mit Spal
done
``` ￼￼￼
EZA_COLORS="uu=38;5;121"
EZA_COLORS="uu=38;5;248" # eza user -> grey

# vivid

vivid is a generator for the LS_COLORS environment variable that controls the colorized output of ls, tree, fd, bfs, dust and many other tools.

It uses a YAML configuration format for the filetype-database and the color themes. In contrast to dircolors, the database and the themes are organized in different files. This allows users to choose and customize color themes independent from the collection of file extensions. Instead of using cryptic ANSI escape codes, colors can be specified in the RRGGBB format and will be translated to either truecolor (24-bit) ANSI codes or 8-bit codes for older terminal emulators.
