vim.o.foldcolumn = '4'
vim.o.foldlevel = 99
vim.o.foldlevelstart = -1
vim.o.fillchars = [[eob: ,fold: ,foldopen:┌,foldsep:│,foldclose:▬]]

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)

vim.cmd([[
hi default link UfoPreviewSbar PmenuSbar
hi default link UfoPreviewThumb PmenuThumb
]])


local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ('  %d '):format(endLnum - lnum)
  local sufwidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufwidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, {chunkText, hlGroup})
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth;
  end
  table.insert(newVirtText, {suffix, 'MoreMsg'})
  return newVirtText
end

require('ufo').setup({
  fold_virt_text_handler = handler
})

local bufnr = vim.api.nvim_get_current_buf()
require('ufo').setFoldVirtTextHandler(bufnr, handler)

