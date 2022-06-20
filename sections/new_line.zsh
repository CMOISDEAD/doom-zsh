#
# New Line
#
# Common-used variable for new line separator

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

LINE_SHOW="${LINE_SHOW=true}"
LINE_PREFIX="${LINE_PREFIX=""}"
LINE_SUFFIX="${LINE_SUFFIX=""}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------


doom_new_line() {
  [[ $LINE_SHOW == true ]] || return

  NEWLINE='
  '

  echo -n "$NEWLINE"
}
