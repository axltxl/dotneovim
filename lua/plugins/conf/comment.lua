--
-- auto-comment
-- 'numToStr/Comment.nvim',
--
ok , comment = pcall(require, 'comment')
if ok then
  comment.setup({
    mappings = {
      basic = false,
      extra = false,
    },
  })
end
