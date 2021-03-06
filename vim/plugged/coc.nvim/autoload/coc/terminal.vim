let s:is_vim = !has('nvim')
let s:channel_map = {}
let s:is_win = has('win32') || has('win64')

" start terminal, return [bufnr, pid]
function! coc#terminal#start(cmd, cwd, env) abort
  if s:is_vim && !has('terminal')
    throw 'terminal feature not supported by current vim.'
  endif
  let cwd = empty(a:cwd) ? getcwd() : a:cwd
  execute 'belowright 8new +setl\ buftype=nofile'
  setl winfixheight
  setl norelativenumber
  setl nonumber
  setl bufhidden=hide
  if exists('#User#CocTerminalOpen')
    exe 'doautocmd User CocTerminalOpen'
  endif
  let bufnr = bufnr('%')

  function! s:OnExit(status) closure
    if a:status == 0
      execute 'silent! bd! '.bufnr
    endif
  endfunction

  if has('nvim')
    if !empty(a:env)
      for key in keys(a:env)
        execute 'let $'.key." = '".a:env[key]."'"
      endfor
    endif
    let job_id = termopen(a:cmd, {
          \ 'cwd': cwd,
          \ 'pty': 1,
          \ 'on_exit': {job, status -> s:OnExit(status)},
          \ })
    if job_id == 0
      throw 'create terminal job failed'
    endif
    wincmd p
    let s:channel_map[bufnr] = job_id
    return [bufnr, jobpid(job_id)]
  else
    let cmd = s:is_win ? join(a:cmd, ' ') : a:cmd
    let res = term_start(cmd, {
          \ 'cwd': cwd,
          \ 'exit_cb': {job, status -> s:OnExit(status)},
          \ 'curwin': 1,
          \ 'env': a:env,
          \})
    if res == 0
      throw 'create terminal job failed'
    endif
    let job = term_getjob(bufnr)
    let s:channel_map[bufnr] = job_getchannel(job)
    wincmd p
    return [bufnr, job_info(job).process]
  endif
endfunction

function! coc#terminal#send(bufnr, text, add_new_line) abort
  let chan = get(s:channel_map, a:bufnr, v:null)
  if empty(chan) | return| endif
  if has('nvim')
    let lines = split(a:text, '\v\r?\n')
    if a:add_new_line && !empty(lines[len(lines) - 1])
      call add(lines, '')
    endif
    call chansend(chan, lines)
    let winnr = bufwinnr(a:bufnr)
    if winnr != -1
      exe 'noa '.winnr.'wincmd w'
      exe 'noa normal! G'
      exe 'noa '.wincmd p
    endif
  else
    if !a:add_new_line
      call ch_sendraw(chan, a:text)
    else
      call ch_sendraw(chan, a:text.(s:is_win ? "\r\n" : "\n"))
    endif
  endif
endfunction

function! coc#terminal#close(bufnr) abort
  if has('nvim')
    let job_id = get(s:channel_map, a:bufnr, 0)
    if !empty(job_id)
      silent! call chanclose(job_id)
    endif
  endif
  exe 'silent! bd! '.a:bufnr
endfunction
