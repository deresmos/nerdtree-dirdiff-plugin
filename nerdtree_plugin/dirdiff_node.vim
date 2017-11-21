if exists('g:loaded_nerdtree_dirdiff_node') &&
    \ exists(':DirDiff')
  finish
endif
let g:loaded_nerdtree_dirdiff_node = 1
let g:nerd_tmp_dirpath = ''

" NERDTreeTmpDirPath {{{1
call NERDTreeAddMenuItem({
  \ 'text'     : '(t)mp diff directory',
  \ 'shortcut' : 't',
  \ 'callback' : 'NERDTreeTmpDirPath'})

function! NERDTreeTmpDirPath()
  let l:currentNode = g:NERDTreeFileNode.GetSelected()
  let g:nerd_tmp_dirpath = s:getDirPath(l:currentNode)
  echo '[Tmp dirpath]' g:nerd_tmp_dirpath
endfunction


" NERDTreeDirDiff {{{1
call NERDTreeAddMenuItem({
  \ 'text'     : '(w)DirDiff with TmpDirPath',
  \ 'shortcut' : 'w',
  \ 'callback' : 'NERDTreeDirDiff'})

function! NERDTreeDirDiff()
  if g:nerd_tmp_dirpath ==# ''
    echohl ErrorMsg | echo 'Not tmp dir path!' | echohl None
    return
  endif

  let l:currentNode = g:NERDTreeFileNode.GetSelected()
  let l:current_dirpath = s:getDirPath(l:currentNode)

  wincmd p
  tab split
  execute 'DirDiff' g:nerd_tmp_dirpath l:current_dirpath

  echo 'executed DirDiff'
endfunction
" }}}1

function! s:getDirPath(node) "{{{
  let l:node_path = a:node.path.str()
  if !a:node.path.isDirectory
    let l:node_path = fnamemodify(l:node_path, ':p:h')
  endif

  return l:node_path
endfunction "}}}

