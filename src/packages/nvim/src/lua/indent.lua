-- Indentation. Precedence:
--   1. .editorconfig (if it sets indentation)
--   2. detected from the file's existing indentation
--   3. Neovim's built-in filetype style (ftplugin), if it has one
--   4. hard tabs
-- Tabs always display 4 columns wide.

local MAX_LINES = 1000

-- Global defaults = the hard-tab fallback. Buffers start from these, and
-- ftplugins only override them for filetypes with a recommended style.
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.shiftwidth = 0 -- 0 = follow tabstop
vim.o.softtabstop = 0

-- Returns 'tabs', 'spaces', width or nil when undetermined.
local function detect(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, MAX_LINES, false)
  local tab_lines, space_lines = 0, 0
  local deltas = {}
  local prev = 0

  for _, line in ipairs(lines) do
    if line:find('%S') then
      local ws = line:match('^[ \t]*')
      local rest = line:sub(#ws + 1)
      if ws == '' then
        prev = 0
      elseif ws:find('\t') then
        if ws:sub(1, 1) == '\t' then tab_lines = tab_lines + 1 end
        prev = nil
      elseif rest:sub(1, 1) == '*' then
        -- C-style block comment continuation (" * foo"); ignore
      else
        space_lines = space_lines + 1
        local n = #ws
        if prev and n > prev and n - prev <= 8 then
          deltas[n - prev] = (deltas[n - prev] or 0) + 1
        end
        prev = n
      end
    end
  end

  if space_lines > tab_lines then
    local width, best = 4, 0
    for d, count in pairs(deltas) do
      if count > best then width, best = d, count end
    end
    return 'spaces', width
  elseif tab_lines > 0 then
    return 'tabs'
  end
  return nil
end

local function apply(buf)
  if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= '' then return end

  local ec = vim.b[buf].editorconfig or {}
  if not ec.tab_width then
    vim.bo[buf].tabstop = 4 -- some ftplugins set 8 (e.g. zig)
  end
  if ec.indent_style or ec.indent_size then return end

  local style, width = detect(buf)
  if style == 'tabs' then
    vim.bo[buf].expandtab = false
    vim.bo[buf].shiftwidth = 0
    vim.bo[buf].softtabstop = 0
  elseif style == 'spaces' then
    vim.bo[buf].expandtab = true
    vim.bo[buf].shiftwidth = width
    vim.bo[buf].softtabstop = -1 -- backspace removes one shiftwidth
  end
  -- undetermined: leave the ftplugin's settings, or the hard-tab globals
end

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'FileType' }, {
  group = vim.api.nvim_create_augroup('indent', { clear = true }),
  callback = function(args)
    -- defer so we run after ftplugins and editorconfig have applied their settings
    vim.schedule(function() apply(args.buf) end)
  end,
})
