#in .zshrc integriert!


!/bin/zsh

# Get the number of lines in .theme_history
num_themes=$(wc -l < $XDG_CONFIG_HOME/.theme_history)

# Generate a random number between 1 and the number of themes
random_num=$((1 + RANDOM % num_themes))

# Get the theme at the random line number
selected_theme=$(sed -n "${random_num}p" < $XDG_CONFIG_HOME/.theme_history)

# Apply the selected theme
echo "Setting terminal theme to: $selected_theme"

command theme.sh $selected_theme

