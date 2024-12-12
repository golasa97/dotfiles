local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node

-- Function to dynamically set the \end{} environment
local function match_env(args)
    return "\\end{" .. args[1][1] .. "}"
end

-- Helper function to generate tabular content dynamically
local function generate_tabular_content(args)
  local num_cols = tonumber(args[1][1]) or 2  -- Default to 2 columns if no input
  local num_rows = tonumber(args[2][1]) or 2  -- Default to 2 rows if no input

  -- Generate alignment string (e.g., "|c|c|c|")
  local alignment = "|"
  for _ = 1, num_cols do
    alignment = alignment .. "c|"
  end

  -- Generate content nodes for each cell in the table
  local nodes = { t("\\begin{tabular}{" .. alignment .. "}"), t({"", "\t\\hline"}) }
  for row = 1, num_rows do
    table.insert(nodes, t({"", "\t"}))
    for col = 1, num_cols do
      table.insert(nodes, i((row - 1) * num_cols + col, "Cell " .. row .. col)) -- Placeholder for each cell
      if col < num_cols then
        table.insert(nodes, t(" & "))
      end
    end
    table.insert(nodes, t(" \\\\ \\hline"))
  end
  table.insert(nodes, t({"", "\\end{tabular}"}))

  return sn(nil, nodes)
end

-- Conditional content for specific environments
local function env_content(args, _)
    local env_name = args[1][1]

    if env_name == "figure" then
        return sn(nil, {
            t({"", "\t\\centering"}),
            t({"", "\t\\includegraphics[width="}),
            i(1, "0.5"), -- Placeholder for image width
            t("\\textwidth]{"),
            i(2, "filename"),             -- Placeholder for image filename
            t("}"),
            t({"", "\t\\caption{"}),
            i(3, "Caption text"),         -- Placeholder for caption text
            t("}"),
            t({"", "\t\\label{fig:"}),
            i(4, "label"),            -- Placeholder for label
            t("}"),
        })

    elseif env_name == "table" then




        -- table environment with embedded tabular and caption/label
        return sn(nil, {
            t({"", "\t\\centering"}),
            t({"", "\t% Specify the number of columns and rows below:"}),
            t({"", "\tColumns: "}),
            i(1, "3"),                   -- Default number of columns
            t({"", "\tRows: "}),
            i(2, "2"),                   -- Default number of rows
            d(3, generate_tabular_content, {1, 2}), -- Dynamically generate table based on columns and rows
            t({"", ""}),
            t({"", "\t\\caption{"}),
            i(4, "Table caption"),        -- Placeholder for table caption
            t("}"),
            t({"", "\t\\label{tab:"}),
            i(5, "label"),            -- Placeholder for table label
            t("}"),
        })

    elseif env_name == "equation" then
        return sn(nil, {
            t({"", "\t\\label{eq:"}),
            i(1, "label"),
            t({"}"}),
            t({"", "\t"}),
            i(2, "equation")
        })


    elseif env_name == "verbatim" then
        return sn(nil, {
            t({"", "\t"}),
            i(1, "Your verbatim text here"), -- Placeholder for verbatim text
        })

    elseif env_name == "abstract" then
        return sn(nil, {
            t({"", "\t"}),
            i(1, "Your abstract here"),
        })

    else
        -- Default empty node if not a specific environment
        return sn(nil, { t("") })
    end
end


ls.add_snippets("tex", {

    s("begin", {
        t("\\begin{"),
        i(1, "environment"),  -- This is where you type the environment name (e.g., figure, equation)
        t("}"),
        t({"", "\t"}),  -- Optional: adds a tab space or newline after beginning the environment
        i(2),           -- Content inside the environment
        t({"", ""}),
        d(3, function(args)
            -- Dynamically set the \end{} based on what’s typed in the first insert node
            return sn(nil, {
                t(match_env(args))
            })
        end, {1}),
    }),
    -- Snippet for enumerate
    s("enum", {
        t({ "\\begin{enumerate}", "    \\item " }),
        i(1), -- Placeholder for the first item
        t({ "", "\\end{enumerate}" }),
    }),

    -- Snippet for itemize
    s("itemz", {
        t({ "\\begin{itemize}", "    \\item " }),
        i(1), -- Placeholder for the first item
        t({ "", "\\end{itemize}" }),
    }),

    -- Snippet for adding \item
    s("item", {
        t("\\item "),
        i(1), -- Placeholder for the item's content
    }),
})
