#
# zvm-plugin
#

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
source $HOME/.oh-my-zsh/custom/themes/doom/sections/helpers/exists.zsh

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------
VI_MODE_SHOW="${VI_MODE_SHOW=true}"
VI_MODE_PREFIX="${VI_MODE_PREFIX="--"}"
VI_MODE_SUFFIX="${VI_MODE_SUFFIX="--"}"
VI_MODE_INSERT="${VI_MODE_INSERT="INSERT"}"
VI_MODE_NORMAL="${VI_MODE_NORMAL="NORMAL"}"
VI_MODE_VISUAL="${VI_MODE_VISUAL="VISUAL"}"
VI_MODE_VISUAL_LINE="${VI_MODE_VISUAL_LINE="VISUAL-L"}"
VI_MODE_REPLACE="${VI_MODE_REPLACE="REPLACE"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_vi_mode() {
  [[ $VI_MODE_SHOW == true ]] || return

  if bindkey | grep "vi-quoted-insert" > /dev/null 2>&1; then # check if vi-mode enabled
    local mode_indicator="${VI_MODE_INSERT}"

    case "$ZVM_MODE" in
      $ZVM_MODE_INSERT)
      mode_indicator="${VI_MODE_INSERT}"
      ;;
      $ZVM_MODE_NORMAL)
      mode_indicator="${VI_MODE_NORMAL}"
      ;;
      $ZVM_MODE_VISUAL)
      mode_indicator="${VI_MODE_VISUAL}"
      ;;
      $ZVM_MODE_VISUAL_LINE)
        mode_indicator="${VI_MODE_VISUAL_LINE}"
      ;;
      $ZVM_MODE_REPLACE)
        mode_indicator="${VI_MODE_REPLACE}"
      ;;
    esac

    echo \
      "%F{76}" \
      "$VI_MODE_PREFIX" \
      "$mode_indicator" \
      "$VI_MODE_SUFFIX%f"
  fi
}
