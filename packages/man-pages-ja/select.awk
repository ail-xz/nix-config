# script/configure.perl の既定の選択を再現し「パッケージ dir ページ」を出力する
# exclude で指定したパッケージは入れない
BEGIN {
  split(exclude, a, " ")
  for (i in a) excluded[a[i]] = 1
}

# script/pkgs.list: 上にあるほど優先し、N は入れない
FNR == NR {
  if (/^#/ || NF == 0) next
  rank[$1] = ($2 ~ /^Y/ && !($1 in excluded)) ? n : -1
  n++
  next
}

# translation_list: 未翻訳・作業中のページとそれへのリンクは入れない
/^(×|▲|△|●|※)/ || /^$/ { next }

{
  split($0, f, ":")
  pkg = f[2]
  sub(/ /, "_", pkg)
  if (!(pkg in rank)) rank[pkg] = n
  if (rank[pkg] < 0) next
  split(f[6], s, "=>")
  sec = s[1] == "pod" ? 1 : s[1]
  page = f[5] "." sec
  if (!(page in best) || rank[pkg] < rank[best[page]]) {
    best[page] = pkg
    dir[page] = "man" sec
  }
}

END {
  for (page in best) print best[page], dir[page], page
}
