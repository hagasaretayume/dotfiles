" 個別でいれてたプラグインの管理
"---------------------------------------------------------------------------
" バッファ管理
NeoBundle 'Shougo/unite.vim'

" コピー履歴
NeoBundle 'YankRing.vim'

" ディレクトリをツリー上に見せる(IDE風)
NeoBundle 'scrooloose/nerdtree'

" Nerdtreeから検索する(事前にackが必須)
NeoBundle 'toritori0318/vim-nerdtree-plugin'

" Gitとの連携(事前にgitBashでuser.name、user.emailを設定する)
NeoBundle 'tpope/vim-fugitive'

"" 囲み機能
"NeoBundleFetch 'surround.vim'
"
"" symfony
"NeoBundleFetch 'vim-symfony'
"
""スニペット補完
"NeoBundleFetch 'Shougo/neocomplcache'
"
""ファイル操作
"NeoBundleFetch 'Shougo/vimfiler'
"
"" PHPDocコメント生成
"NeoBundleFetch 'PDV--phpDocumentor-for-Vim'
"
""いろんな言語のリファレンスが引ける
"NeoBundleFetch 'thinca/vim-ref'
"
""Vim 上でプログラムを実行できる
"NeoBundleFetch 'thinca/vim-quickrun'
"
""各ファイルに対してgrep
"NeoBundleFetch 'ack.vim'
"
" HTML生成
" NeoBundle 'mattn/emmet-vim'
"
"" コメントに関する処理
"NeoBundleFetch 'The-NERD-Commenter'

"文字数をステータスラインに表示
"NeoBundleFetch 'fuenor/vim-wordcount'

" シンタックスエラーチェック(事前にローカル環境必要)
" NeoBundle 'scrooloose/syntastic.git'

" コーディング規約 PHP Fixer(事前にローカル環境必要)
" NeoBundle 'stephpy/vim-php-cs-fixer'

" 必要ない：インデントの深さを視覚化：
" NeoBundleFetch 'nathanaelkane/vim-indent-guides'
"
"---------------------------------------------------------------------------
" 個別でいれてたプラグインの設定
"---------------------------------------------------------------------------
" コピー履歴：YankRing.vim
"
" 履歴一覧用のマッピング
nmap ,y :YRShow<CR>
" 履歴数
:let g:yankring_max_history = 30
" 表示数
:let g:yankring_max_display = 30
"---------------------------------------------------------------------------
" ディレクトリをツリー上に見せる
"
" マッピング：ツリーの開閉
nnoremap <f2> :NERDTreeToggle<CR>
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
" 起動時にNERDTreeを表示
autocmd vimenter * NERDTree
" 最後に残ったウィンドウがNERDTREEのみのときはvimを閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeDirArrows=0
let g:NERDTreeMouseMode=0
" 幅の指定(文字数)
let g:NERDTreeWinSize = 60
" 起動時のカレントディレクトリ
cd ~/Documents/workspace/
"---------------------------------------------------------------------------
" Unit.vimの設定
"---------------------------------------------------------------------------
