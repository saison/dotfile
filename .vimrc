"-------------------------------------------------------
" .vimrc
"-------------------------------------------------------
set nocompatible                            " Be iMproved
set wildmenu                                " ナビゲーションバー有効
set autoindent                              " 自動インデントの有効
set smartindent                             " 更に賢いらしいインデントの有効
set expandtab                               " ハードタブをソフトタブに変換
set list                                    " タブ・スペース・改行の可視化
set listchars=tab:».,trail:_,eol:↲,nbsp:¥   " タブ・スペース・改行の可視化
autocmd BufWritePre * :%s/\s\+$//e          " 行末のスペースを削除
set tabstop=2                               " インデントのスペース指定
set tw=0                                    " 自動改行オフ
set shiftwidth=2                            " 自動インデントのスペース指定
set whichwrap=b,s,h,l,<,>,[,]               " カーソルを行頭、行末で止まらないようにする
set showmatch                               " 括弧が閉じられたときに対応する括弧をハイライトする
set incsearch                               " インクリメンタルサーチをON
set wrapscan                                " 循環検索ON
set cursorline                              " カレント行のハイライト
set encoding=utf-8                          " デフォルトのエンコード
set fileencoding=utf-8                      " ファイルのデフォルトのエンコード
" if has("gui_running")
" set transparency=15                         " 背景の透過
" endif
set backupdir=~/Documents/vim_backups/      " バックアップファイル保存場所の指定
set directory=~/Documents/vim_backups/      " スワップファイルの保存場所の指定
set autoread                                " ファイル変更があった場合に自動再読み込み
set relativenumber                          " 相対行番
set number                                  " 行番号の表示
"set guifont=Inconsolata:16                 " フォント周り
set guifontwide=Inconsolata:h15
set guifont=Inconsolata:h15
set visualbell t_vb=                        "ビープ音すべてを無効にする
set noerrorbells                            "エラーメッセージの表示時にビープを鳴らさない

"pre括弧類の自動閉じ
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

colorscheme railscasts
syntax on
"let g:molokai_original = 1
"let g:rehash256 = 1
set background=dark
filetype indent plugin on

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif


"----------------------------
" NeoBundle List
"----------------------------
"" Unite
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
NeoBundle 'ujihisa/unite-colorscheme'
nnoremap <silent> ,uc :<C-u>Unite colorscheme -auto-preview<CR>

NeoBundle 'tpope/vim-fugitive'

"Nerdtree
NeoBundle 'scrooloose/nerdtree'
  nmap <silent> <C-e>      :NERDTreeToggle<CR>
  vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
  omap <silent> <C-e>      :NERDTreeToggle<CR>
  imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
  cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

"スニペット用のプラグイン
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle "Shougo/neosnippet-snippets"

NeoBundle 'Shougo/vimproc'

"vimでjsonを見やすくしてくれるとても助かるやつ
NeoBundle 'elzr/vim-json'

"vim-emmet
NeoBundle 'mattn/emmet-vim'

"vim-quickrun
NeoBundle 'thinca/vim-quickrun'

"vim-taskpaper = todo
NeoBundle 'davidoc/taskpaper.vim'

"lightline
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'altercation/vim-colors-solarized'

"指定した行へ飛ぶ
NeoBundle 'Lokaltog/vim-easymotion'
  let g:EasyMotion_mapping_j = '<C-j>'
  let g:EasyMotion_mapping_k = '<C-k>'

"vim用コンソール
NeoBundle 'Shougo/vimshell.vim'

"クリップボードが使える。
NeoBundle 'kana/vim-fakeclip.git'
  set clipboard=unnamed

"HTML5/CSS3のコードシンタックス
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'taichouchou2/html5.vim'

"coffeeScriptのコードシンタックス
NeoBundle 'kchmck/vim-coffee-script'

"ハードタブ・ソフトタブが見やすい
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=4

"vimでwordpressの記事が書ける(完全にド変態)
NeoBundle 'vim-scripts/VimRepress'

"vimに叱られる。
NeoBundle 'modsound/gips-vim.git'''

"-------------------------------------------------
"　なんか動かなかった。。。そのうち頑張る
"-------------------------------------------------
"テキストオブジェクトの拡張
"NeoBundle 'taichouchou2/surround.vim'
"JavaScriptのコードシンタックス
"NeoBundle 'taichouchou2/vim-javascript'
"ブラウザの自動更新
"NeoBundle 'tell-k/vim-browsereload-mac'
"Twitter
"NeoBundle 'basyura/TweetVim'


filetype plugin indent on

"-------------------------------------------------
" neocomplcache設定
"-------------------------------------------------
"辞書ファイル
autocmd BufRead *.php\|*.ctp\|*.tpl :set dictionary=~/.vim/dictionaries/php.dict filetype=php
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'
