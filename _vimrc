" vim:set ts=8 sts=2 sw=2 tw=0:
" 
" ~/dotfiles/_vimrc
" ハードリンクをはる
" mklink C:\Users\xxxxx\_vimrc C:\Users\xxxxx\dotfiles\_vimrc

"---------------------------------------------------------------------------
" 設定
"
" 検索時大文字と小文字を区別する
set noignorecase
" BOMを表示しない
set nobomb

"---------------------------------------------------------------------------
" ファイルに関する設定
"
" スワップファイルを作成しない
:set noswapfile
" バックアップファイルを作成しない
:set nobackup
" viminfoファイルを作成しない
":set viminfo=

"---------------------------------------------------------------------------
" 画面設定
"
" タブの画面上での幅
" ファイル中の<Tab>文字(キャラクターコード9)を、画面上の見た目で何文字分に展開するかを指定する。
set tabstop=4
" vimが挿入するインデント('cindent')やシフトオペレータ(>>や<<)で挿入/削除されるインデントの幅を、
" 画面上の見た目で何文字分であるか指定します。
set shiftwidth=4
" キーボードで<Tab>キーを押した時に挿入される空白の量。
" 'softtabstop'が0以外の時には、例え'ts'を4に設定していても、<Tab>を1度押しても'softtabstop'分だけ空白が挿入されます。
" 逆に'softtabstop'が0の場合には挿入されるのは'ts'で指定した量になります。
set softtabstop=0
" タブをスペースに展開しない (expandtab:展開する)
"set noexpandtab
set expandtab
" バックスペースでインデントや改行を削除できるようにする
"set backspace=2

"---------------------------------------------------------------------------
" 画面設定(ツールバー)
"
" ツールバーを消したい場合
set guioptions-=T
" メニューバーが消えます 
set guioptions-=m

"---------------------------------------------------------------------------
" 画面設定(ステータスライン)
"
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1	" ぶら下り可能幅
"ステータスラインに文字コードと改行文字を表示する
function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc

 set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']['.&ft.']'}\ %F%=%l,%c%V%8P
if winwidth(0) >= 120
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif
"set statusline=%{GetB()}

"---------------------------------------------------------------------------
" 文字コード
"
" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 設定上書き
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932

" 改行コードの自動認識
set fileformats=unix,dos,mac
" カーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"---------------------------------------------------------------------------
" プラグイン管理
"
" Bundleを使うのにはgitとcurlが必要になる。
" Windowsではmsysgitをインストールし、curl.cmdを作成する。
" http://code.google.com/p/msysgit/downloads/list
" 実行後、C:\Program Files\Git\cmd\curl.cmdを作成。(内容は別途)
" 環境変数PATHを「C:\Program Files\Git\cmd」に通す
"
"---------------------------------------------------------------------------
" Bundleの設定
"
" #Bundle...は使用するプラグインを書く。詳細はguthubのREADMEが詳しい。
" :BundleInstall  # インストール時
" :BundleInstall! # 更新時
set nocompatible
filetype off

"このif文が必要。
if has("win32") || has("win64")
  set rtp+=~/vimfiles/vundle.git/ 
  call vundle#rc('~/vimfiles/bundle/')
else
  set rtp+=~/.vim/vundle.git/ 
  call vundle#rc()
endif

Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
filetype plugin indent on

" 上記Pluginはgithubで管理しないため.gitignoreを作成。
" ~/dotfiles/.gitignore
" ファイルには1行だけ記載
" /vimfiles/bundle/

" vimエディタのdiff機能は「diff」コマンドが実行できる状態でないと使用できません。 

" MRU(ファイル履歴)
" 履歴保存数
":let MRU_Max_Entries=30
" ウィンドウの閉じる設定
":let MRU_Auto_Close=0

" Ctag(タグ作成)
" http://nanasi.jp/articles/others/ctags.html
"nmap <silent> <F4>
"    \ :!ctags-ex -f %:p:h/tags
"    \ --langmap="php:+.inc"
"    \ -h ".php.inc" -R --totals=yes
"    \ --tag-relative=yes --PHP-kinds=+cf-v %:p:h<CR>
"set tags=./tags,tags
" タグファイル作成[!ctags -R]
" ctags -R --langmap=PHP:.php.inc --php-types=c+f+d+v+i

" プラグイン
" YankRing.vim(プラグインをインストールしておくこと)割り当て
" nmap ,y :YRShow<CR>
