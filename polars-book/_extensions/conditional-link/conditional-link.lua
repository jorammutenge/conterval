-- _extensions/conditional-link/conditional-link.lua

-- Counter for generating unique footnote IDs
local footnote_counter = 0

function conditional_link(args, kwargs, meta)
    local text = pandoc.utils.stringify(args[1])
    local url = pandoc.utils.stringify(args[2])

    -- Try to resolve variables from meta if the values look like variable names
    if meta[text] then
        text = pandoc.utils.stringify(meta[text])
    end
    if meta[url] then
        url = pandoc.utils.stringify(meta[url])
    end

    -- Check if we're rendering to PDF/LaTeX
    if quarto.doc.isFormat("pdf") or quarto.doc.isFormat("latex") then
        -- For PDF: create link with footnote containing the URL
        footnote_counter = footnote_counter + 1
        local link = pandoc.Link(text, url)
        local footnote = pandoc.Note({ pandoc.Plain({ pandoc.Str(url) }) })
        return { link, footnote }
    else
        -- For HTML/other formats: just create the link without footnote
        return pandoc.Link(text, url)
    end
end

return {
    ['clink'] = conditional_link
}
