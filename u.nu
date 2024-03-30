#!/usr/bin/env nu

const PROJ_ROOT = ('.' | path expand)
const SRC_DIR = ('src' | path expand)
const OUT_DIR = ('target' | path expand)

# ported from justfile
export def main [] {
  build
}

export def build [] {
  build-styles
  build-fonts
  build-snippets
}

export def build-styles [] {
  build-once 'style'
  build-once 'slidy'
  build-once 'print' --additional ([
    (open -r (realpath third-party/paged-snippet.html) | str trim)
    # $"<script src='(realpath third-party/paged.polyfill.js)'></script>"
    $"<script>\n(open third-party/paged.polyfill.js | str trim)\n</script>"
    ] | str join "\n"
  )
}

export def build-fonts [] {
  build-once 'font-sans'
  build-once 'font-serif'
}

export def build-snippets [] {
  build-once 'aside'
  build-once 'glossing'
  build-once 'hiero'
  let cjtypo_add = ([
    # $"<script src='(realpath third-party/cj-typo.js)'></script>"
    $"<script>(open third-party/cj-typo.js | str trim)</script>"
    (open -r (realpath third-party/cjtypo-snippet.html) | str trim)
    ] | str join "\n"
  )
  build-once 'cjtypo-sans' --additional $cjtypo_add
  build-once 'cjtypo-serif' --additional $cjtypo_add
}

def tag-style [
  --additional: string
]: string -> string {
  $in | str trim
  | [$additional "<style>" $in "</style>"]
  | str join "\n"
  | str trim
}

export def build-once [
  src_name: string
  out_name?: string
  --additional: string
  --src-dir (-s): string = $SRC_DIR
  --out-dir (-o): string = $OUT_DIR
] {
  ensure-pwd
  let src = [$src_name 'scss'] | str join '.'
    | [$src_dir $in] | path join

  let out = if ($out_name | is-empty) {
    $src_name | path parse | get stem
    | [$in 'html'] | str join '.'
    | [$out_dir $in] | path join
  } else {
    [$out_name 'html'] | str join '.'
    | [$out_dir $out_name] | path join
  }

  ^sass $src
  | ^cleancss -O2
  # | cleancss --format beautify
  | tag-style --additional $additional
  | save -f $out
}

export def add-commit-push [] {
  ^git add .
  commit-update
  ^git push
}
export alias acp = add-commit-push

export def commit-update [] {
  let today = (date now | format date %F)
  ^git commit -m $'Update ($today)'
}
export alias cu = commit-update

def --env ensure-pwd [] {
  cd $PROJ_ROOT
}

