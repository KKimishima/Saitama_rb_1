# Saitama_rb_1
## vagrantインストール
- vagrant  
vagrant init bento/fedora-26
vagrant up
vagrant ssh

sudo yum update

## rbenvインストール
https://dev.classmethod.jp/server-side/language/build-ruby-environment-by-rbenv/

```
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

rbenv --version
rbenv install --list
rbenv install 2.5.0
```

- ビルド失敗
```
Installing ruby-2.5.0...

BUILD FAILED (Fedora 26 using ruby-build 20180224)

Inspect or clean up the working tree at /tmp/ruby-build.20180317052229.16805
Results logged to /tmp/ruby-build.20180317052229.16805.log

Last 10 log lines:
checking for ruby... false
checking build system type... x86_64-pc-linux-gnu
checking host system type... x86_64-pc-linux-gnu
checking target system type... x86_64-pc-linux-gnu
checking for gcc... no
checking for cc... no
checking for cl.exe... no
configure: error: in `/tmp/ruby-build.20180317052229.16805/ruby-2.5.0':
configure: error: no acceptable C compiler found in $PATH
See `config.log' for more details
```

gcc,ccなどのツールがないのでビルドできない

- Development toolsを一括インストール
yum groupinstall 'Development tools'

- 再度ビルド
rbenv install 2.5.0
長い....

- 再度ビルド失敗
```
/home/vagrant/.rbenv/plugins/ruby-build/bin/ruby-build: 行 1260: ヒアドキュメント用一時ファイルを作成できません: No space left on device
/home/vagrant/.rbenv/plugins/ruby-build/bin/ruby-build: 199 行: pushd: 書き込みエラー: No space left on device
Downloading ruby-2.5.0.tar.bz2...
-> https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.bz2
error: failed to download ruby-2.5.0.tar.bz2

BUILD FAILED (Fedora 26 using ruby-build 20180224)

Inspect or clean up the working tree at /tmp/ruby-build.20180317053528.16993
```

一応削除
sudo rm -rf /tmp/ruby-build.2018031705*

- バージョン変更
```
rbenv install 2.4.3

[vagrant@localhost ~]$ rbenv install 2.4.3
/home/vagrant/.rbenv/plugins/ruby-build/bin/ruby-build: 行 1260: ヒアドキュメント用一時ファイルを作成できません: No space left on device
/home/vagrant/.rbenv/plugins/ruby-build/bin/ruby-build: 199 行: pushd: 書き込みエラー: No space left on device
Downloading ruby-2.4.3.tar.bz2...
-> https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.3.tar.bz2
error: failed to download ruby-2.4.3.tar.bz2

BUILD FAILED (Fedora 26 using ruby-build 20180224)

Inspect or clean up the working tree at /tmp/ruby-build.20180317053657.17214
[vagrant@localhost ~]$ sudo rm -rf /tmp/ruby-build.2018031705*
[vagrant@localhost ~]$ rbenv install 2.4.3
Downloading ruby-2.4.3.tar.bz2...
-> https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.3.tar.bz2
Installing ruby-2.4.3...
c
BUILD FAILED (Fedora 26 using ruby-build 20180224)

Inspect or clean up the working tree at /tmp/ruby-build.20180317053758.17286
Results logged to /tmp/ruby-build.20180317053758.17286.log

Last 10 log lines:
The Ruby openssl extension was not compiled.
The Ruby readline extension was not compiled.
The Ruby zlib extension was not compiled.
ERROR: Ruby install aborted due to missing extensions
Try running `yum install -y openssl-devel readline-devel zlib-devel` to fetch missing dependencies.

Configure options used:
  --prefix=/home/vagrant/.rbenv/versions/2.4.3
  LDFLAGS=-L/home/vagrant/.rbenv/versions/2.4.3/lib
  CPPFLAGS=-I/home/vagrant/.rbenv/versions/2.4.3/include

```

- ファイル削除
"ヒアドキュメント用一時ファイルを作成できません: No space left on device"
一度目と二度目のビルドのゴミがあったので削除

```
前
[vagrant@localhost ~]$ df
ファイルシス   1K-ブロック     使用   使用可 使用% マウント位置
devtmpfs            499228        0   499228    0% /dev
tmpfs               507456        0   507456    0% /dev/shm
tmpfs               507456      564   506892    1% /run
tmpfs               507456        0   507456    0% /sys/fs/cgroup
/dev/sda1         41021664  4259300 34648880   11% /
tmpfs               507456   255116   252340   51% /tmp
vagrant          126729216 73481812 53247404   58% /vagrant
tmpfs               101488        0   101488    0% /run/user/1000
```

rm -rf /tmp/*

```
[vagrant@localhost ~]$ df
ファイルシス   1K-ブロック     使用   使用可 使用% マウント位置
devtmpfs            499228        0   499228    0% /dev
tmpfs               507456        0   507456    0% /dev/shm
tmpfs               507456      564   506892    1% /run
tmpfs               507456        0   507456    0% /sys/fs/cgroup
/dev/sda1         41021664  4259292 34648888   11% /
tmpfs               507456        0   507456    0% /tmp
vagrant          126729216 73481812 53247404   58% /vagrant
tmpfs               101488        0   101488    0% /run/user/1000
```

あと、依存パケージのインストール
```
yum install -y openssl-devel readline-devel zlib-devel

- 再ビルド
rbenv install 2.4.3
OK

rbenv global 2.4.3

[vagrant@localhost ~]$ ruby -v
ruby 2.4.3p205 (2017-12-14 revision 61247) [x86_64-linux]
```

## vimインストール　
```
https://qiita.com/silicsmz/items/b5ad3295863bb2b1de76
lua付きでビルド

sudo yum update
sudo yum remove vim-enhanced
sudo yum install lua-devel ncurses-devel

cd /usr/local/src/
git clone https://github.com/vim/vim.git
cd vim/
sudo make distclean

sudo  ./configure --prefix=/usr/local --with-features=huge --enable-multibyte --enable-rubyinterp --enable-luainterp --enable-cscope --enable-fail-if-missing --with-ruby-command=/home/vagrant/.rbenv/shims/ruby

sudo make
sudo make install
```

```
[vagrant@localhost vim]$ vim --version
VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Mar 17 2018 06:06:50)
適用済パッチ: 1-1612
Compiled by vagrant@localhost.localdomain
Huge 版 without GUI.  機能の一覧 有効(+)/無効(-)
+acl               +farsi             +mouse_sgr         -tag_any_white
+arabic            +file_in_path      -mouse_sysmouse    -tcl
+autocmd           +find_in_path      +mouse_urxvt       +termguicolors
-autoservername    +float             +mouse_xterm       +terminal
-balloon_eval      +folding           +multi_byte        +terminfo
+balloon_eval_term -footer            +multi_lang        +termresponse
-browse            +fork()            -mzscheme          +textobjects
++builtin_terms    +gettext           +netbeans_intg     +timers
+byte_offset       -hangul_input      +num64             +title
+channel           +iconv             +packages          -toolbar
+cindent           +insert_expand     +path_extra        +user_commands
-clientserver      +job               -perl              +vertsplit
-clipboard         +jumplist          +persistent_undo   +virtualedit
+cmdline_compl     +keymap            +postscript        +visual
+cmdline_hist      +lambda            +printer           +visualextra
+cmdline_info      +langmap           +profile           +viminfo
+comments          +libcall           -python            +vreplace
+conceal           +linebreak         -python3           +wildignore
+cryptv            +lispindent        +quickfix          +wildmenu
+cscope            +listcmds          +reltime           +windows
+cursorbind        +localmap          +rightleft         +writebackup
+cursorshape       +lua               +ruby              -X11
+dialog_con        +menu              +scrollbind        -xfontset
+diff              +mksession         +signs             -xim
+digraphs          +modify_fname      +smartindent       -xpm
-dnd               +mouse             +startuptime       -xsmp
-ebcdic            -mouseshape        +statusline        -xterm_clipboard
+emacs_tags        +mouse_dec         -sun_workshop      -xterm_save
+eval              -mouse_gpm         +syntax
+ex_extra          -mouse_jsbterm     +tag_binary
+extra_search      +mouse_netterm     +tag_old_static
```

# deinパッケージ管理

```
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -o /tmp/installer.sh
sh /tmp/installer.sh ~/.vim/dein
```

```
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/vagrant/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/vagrant/.vim/dein')
  call dein#begin('/home/vagrant/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/vagrant/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------


Done.
Complete setup dein!
```

## .vimrc設定
deinの設定プラスよく使う設定

```
"setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" vimでヤンクした内容を別のウィンドウにペーストする
set clipboard=unnamed,autoselect

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

""""""""""""""""""""""""""""""
" 自動的に閉じ括弧を入力
""""""""""""""""""""""""""""""
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
""""""""""""""""""""""""""""""

" macでdeleteがうまく動かない設定
set backspace=indent,eol,start

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/vagrant/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/vagrant/.vim/dein')
  call dein#begin('/home/vagrant/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/vagrant/.vim/dein/repos/github.com/Shougo/dein.vim')


  " Add or remove your plugins here:
    call dein#add('Shougo/neocomplete.vim')↲
    call dein#add('Shougo/neocomplcache')↲
    call dein#add('Shougo/neosnippet')↲
    call dein#add('Shougo/neosnippet-snippets')↲
    call dein#add('scrooloose/syntastic')↲
    call dein#add('scrooloose/nerdtree')↲
   call dein#add('vim-syntastic/syntastic')↲
101   call dein#add('Shougo/unite.vim')↲
102   call dein#add('kannokanno/previm')↲
103   call dein#add('tyru/open-browser.vim')↲
104   call dein#add('Yggdroot/indentLine')↲
105   call dein#add('plasticboy/vim-markdown')↲
106   call dein#add('tpope/vim-fugitive')↲
107   call dein#add('kana/vim-submode')↲
108   " いただきもの取り合い突っ込む↲
109   call dein#add('slim-template/vim-slim')↲
110  call dein#add('tomtom/tcomment_vim')↲
111  call dein#add('tpope/vim-endwise')↲
112  call dein#add('tpope/vim-fugitive')↲
113  call dein#add('tpope/vim-rails')↲
114  call dein#add('tpope/vim-rake')↲
115  call dein#add('tpope/vim-surround')↲
116  call dein#add('vim-scripts/AnsiEsc.vim')↲
117  call dein#add('vim-scripts/Auto-Pairs')↲
118  call dein#add('vim-scripts/matchit.zip')↲
119  call dein#add('vim-scripts/Smooth-Scroll')↲
120  call dein#add('vim-scripts/YankRing.vim')↲
121  call dein#add('vim-scripts/visualstar.vim')↲



  " 
  " 無効プラグイン
" うまく動かないため
  call dein#add('justmao945/vim-clang')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" カラースキームの設定
colorscheme apprentice

"プラグインのキーバンド
nnoremap :tree :NERDtreeToggle

syntax on


" オートコンプリート設定
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-h>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" スペニット補完 <C-k> にマッピング
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" 不可視文字表示
set list
set listchars=tab:»-,trail:-,nbsp:%,eol:↲

" set clang options for vim-clang
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++1z -stdlib=libc++ --pedantic-errors'

" Statuslineの設定
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P 

" windows操作系キーバインド
" 参考
" http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" シンクタンク設定
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
" C
let g:syntastic_c_check_header = 1
" C++
let g:syntastic_cpp_check_header = 1
" Java
let g:syntastic_java_javac_config_file_enabled = 1
" javaのクラスパス設定ファイル
"let g:syntastic_java_javac_classpath = '/home/vagrant/repo/learn_java/2.11.inheritance/ex1103/bin'
let g:syntastic_java_javac_config_file = "$HOME/.syntastic_javac_config"

```

## githubのsshキー
```
cd ~/.ssh
ssh-keygen -t rsa

cat ./id_rsa.pubをgithubに登録

git clone git@github.com:KKimishima/ssh_test.git
OK
```

## fizz_buzz追加
```
def fizz_buzz(num)
  n = num.to_i
  if n == 0
    "無効な値でです"
  elsif n % 15 == 0
    "Fizz_Buzz"
  elsif n % 3 == 0
    "Fizz"
  elsif n % 5 == 0
    "Buzz"
  else
    n.to_s
  end
end

puts "fizz_buzzの判別する数値を入力してくだしてください"
print "数値:"
num = gets.to_i
puts "結果_#{fizz_buzz(num)}"
```
