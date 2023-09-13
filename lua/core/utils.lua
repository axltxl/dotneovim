--
-- utilities library
--

local m = {}

function m.desc(ctx, msg)
    return string.format("[%s] - %s", ctx, msg)
end

return m
