--
-- TODOs management
--

require('core').safe_require('todo-comments', function(todocomments)
    todocomments.setup {
        -- keywords recognized as todo comments
        keywords = {
            FIXME = {
                icon = "🔥", -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = "✅ ", color = "info" },
            HACK = { icon = "🔥 ", color = "warning" },
            WARN = { icon = "⚠️ ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = "❓", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = "🗒️", color = "hint", alt = { "INFO" } },
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
    }
end)
