-- Render publication cards from publications.bib.
-- The homepage contains two empty divs: #publication-list and #other-list.
-- Edit publications.bib; this filter handles presentation automatically.

local function stringify(x)
  if x == nil then return "" end
  return pandoc.utils.stringify(x)
end

local function html_escape(s)
  s = tostring(s or "")
  s = s:gsub("&", "&amp;")
  s = s:gsub("<", "&lt;")
  s = s:gsub(">", "&gt;")
  s = s:gsub('"', "&quot;")
  return s
end

local function inline_html(inlines)
  if inlines == nil then return "" end
  local blocks = { pandoc.Plain(inlines) }
  local html = pandoc.write(pandoc.Pandoc(blocks), "html")
  html = html:gsub("^%s*<p>", ""):gsub("</p>%s*$", "")
  return html
end

local function person_name(person)
  local given = stringify(person.given)
  local family = stringify(person.family)
  if given == "" then return family end
  if family == "" then return given end
  return given .. " " .. family
end

local function coauthors(ref)
  local names = {}
  if ref.author ~= nil then
    for _, person in ipairs(ref.author) do
      local given = stringify(person.given)
      local family = stringify(person.family)
      if not (family == "Turchet" and given:match("^Amos")) then
        table.insert(names, person_name(person))
      end
    end
  end
  if #names == 0 then return "" end
  if #names == 1 then return "with " .. names[1] end
  if #names == 2 then return "with " .. names[1] .. " and " .. names[2] end
  return "with " .. table.concat(names, ", ", 1, #names - 1) .. ", and " .. names[#names]
end

local function group_of(ref)
  local keyword = stringify(ref.keyword):lower()
  if keyword:find("other", 1, true) then return "other" end
  return "publication"
end

local function source_label(ref, url)
  if url:find("arxiv.org", 1, true) then return "arXiv" end
  local t = tostring(ref.type or "")
  if t:find("thesis", 1, true) then return "Thesis" end
  if t == "chapter" or t == "paper-conference" then return "Book" end
  return "Journal"
end

local function render_ref(ref)
  local title = inline_html(ref.title)
  local author_line = coauthors(ref)
  local venue = stringify(ref.note)
  local url = stringify(ref.url)
  local doi = stringify(ref.doi)
  local pdf = stringify(ref.annote)
  local abstract = inline_html(ref.abstract)

  local parts = {}
  table.insert(parts, '<article class="pub-card">')
  table.insert(parts, '<div class="pub-title">' .. title .. '</div>')
  if author_line ~= "" then
    table.insert(parts, '<div class="pub-authors">' .. html_escape(author_line) .. '</div>')
  end
  if venue ~= "" then
    table.insert(parts, '<div class="pub-venue">' .. html_escape(venue) .. '</div>')
  end

  local links = {}
  if url ~= "" then
    table.insert(links, '<a href="' .. html_escape(url) .. '">' .. source_label(ref, url) .. '</a>')
  end
  if doi ~= "" then
    table.insert(links, '<a href="https://doi.org/' .. html_escape(doi) .. '">DOI</a>')
  end
  if pdf ~= "" and pdf ~= url then
    table.insert(links, '<a href="' .. html_escape(pdf) .. '">PDF</a>')
  end
  if #links > 0 then
    table.insert(parts, '<div class="pub-links">' .. table.concat(links, '<span aria-hidden="true">·</span>') .. '</div>')
  end

  if abstract ~= "" then
    table.insert(parts, '<details class="pub-abstract"><summary>Abstract</summary><div>' .. abstract .. '</div></details>')
  end
  table.insert(parts, '</article>')
  return pandoc.RawBlock('html', table.concat(parts, "\n"))
end

function Pandoc(doc)
  local refs = pandoc.utils.references(doc)
  local publications = {}
  local others = {}
  for _, ref in ipairs(refs) do
    if group_of(ref) == "other" then
      table.insert(others, render_ref(ref))
    else
      table.insert(publications, render_ref(ref))
    end
  end

  local function replace_div(el)
    if el.identifier == "publication-list" then
      return publications
    elseif el.identifier == "other-list" then
      return others
    end
  end

  return doc:walk({ Div = replace_div })
end
