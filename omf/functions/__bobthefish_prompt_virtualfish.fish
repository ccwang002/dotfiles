function __bobthefish_prompt_virtualfish -S -d "Display activated virtual environment (only for virtualfish, virtualenv's activate.fish changes prompt by itself)"
  [ "$theme_display_virtualenv" = 'no' -o -z "$VIRTUAL_ENV" ]; and return
  # set -l version_glyph (__bobthefish_virtualenv_python_version)
  # if [ "$version_glyph" ]
  #   __bobthefish_start_segment $__color_virtualfish
  #   echo -ns $__bobthefish_virtualenv_glyph $version_glyph ' '
  # end
  __bobthefish_start_segment $__color_virtualfish
  echo -ns (basename "$VIRTUAL_ENV") ' '
  set_color normal
end
