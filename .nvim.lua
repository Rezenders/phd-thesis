-- Resolve paths from this trusted config, not Neovim's current directory.
local root = vim.fs.dirname(debug.getinfo(1, "S").source:sub(2))
root = vim.fn.fnamemodify(root, ":p"):gsub("/$", "")

-- VimTeX owns interactive compilation and PDF navigation; Texlab does not build.
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {
  out_dir = "build",
  options = { "-pdf", "-synctex=1", "-file-line-error", "-interaction=nonstopmode" },
}
-- Match the Makefile's TeX/BibTeX search paths. Keep the trailing separator so
-- TeX still searches its standard directories. latexmkrc handles paired PDFs.
for _, key in ipairs({ "TEXINPUTS", "BSTINPUTS" }) do
  local prefix = root .. ":" .. root .. "/styles//:"
  local current = vim.env[key] or ""
  if current:sub(1, #prefix) ~= prefix then
    vim.env[key] = prefix .. current
  end
end

local spell_dir = root .. "/.nvim/spell"
vim.fn.mkdir(spell_dir, "p")
local group = vim.api.nvim_create_augroup("planta-paper", { clear = true })
-- Set before VimTeX initializes a section buffer; leave supplement roots alone.
vim.api.nvim_create_autocmd("BufReadPre", {
  group = group,
  pattern = root .. "/sections/*.tex",
  callback = function(args)
    vim.b[args.buf].vimtex_main = root .. "/main-acm.tex"
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "tex",
  callback = function(args)
    local path = vim.api.nvim_buf_get_name(args.buf)
    if path:sub(1, #root + 1) ~= root .. "/" then return end
    vim.bo[args.buf].spellfile = spell_dir .. "/en.utf-8.add"
    -- LTeX owns spelling here; native spell marks have no LSP code actions.
    vim.opt_local.spell = false
    vim.keymap.set("n", "<localleader>ld", vim.diagnostic.open_float,
      { buffer = args.buf, desc = "LaTeX: diagnostic details" })
  end,
})

-- Configure the project's LSP diagnostic namespaces, not global diagnostics.
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local path = vim.api.nvim_buf_get_name(args.buf)
    if path:sub(1, #root + 1) ~= root .. "/" then return end
    for _, pull in ipairs({ false, true }) do
      local ns = vim.lsp.diagnostic.get_namespace(args.data.client_id, pull)
      vim.diagnostic.config({ virtual_text = false, virtual_lines = false }, ns)
    end
  end,
})

-- Run from the project root regardless of :cd. One job at a time avoids
-- concurrent writes to build/; stop VimTeX's watcher before an explicit build.
local job
local function run_make(target)
  if job then
    vim.notify("A paper task is already running", vim.log.levels.WARN)
    return
  end
  if target == "pdf" and vim.fn.exists("*vimtex#compiler#stop") == 1 then
    vim.fn["vimtex#compiler#stop"]()
  end
  vim.cmd("wall")
  vim.notify("Running make " .. target)
  job = vim.system({ "make", "--no-print-directory", target },
    { cwd = root, text = true }, vim.schedule_wrap(function(result)
      job = nil
      local output = (result.stdout or "") .. "\n" .. (result.stderr or "")
      local items = {}
      for line in output:gmatch("[^\r\n]+") do
        local file, lnum, message = line:match("^(.+):(%d+):%s*(.+)$")
        local warning, lint_file, lint_line, lint_message =
          line:match("^Warning (%d+) in (.-) line (%d+):%s*(.*)$")
        if warning then
          file, lnum, message = lint_file, lint_line, "ChkTeX " .. warning .. ": " .. lint_message
        elseif not file then
          -- lint-diff intentionally reports stable context, not line numbers.
          file, message = line:match("^(.-): (Warning %d+:.*)$")
        end
        if file then
          items[#items + 1] = {
            filename = file:sub(1, 1) == "/" and file or root .. "/" .. file,
            lnum = tonumber(lnum) or 0,
            text = message,
            type = target == "pdf" and "E" or "W",
          }
        end
      end
      -- Preserve output if a tool failed without a recognized location.
      if #items == 0 and result.code ~= 0 then
        for line in output:gmatch("[^\r\n]+") do
          items[#items + 1] = { text = line }
        end
      end
      vim.fn.setqflist({}, " ", { title = "Paper: make " .. target, items = items })
      if #items > 0 then vim.cmd("copen") end
      vim.notify(("make %s exited %d"):format(target, result.code),
        result.code == 0 and vim.log.levels.INFO or vim.log.levels.WARN)
    end))
end
for name, target in pairs({ PaperBuild = "pdf", PaperLint = "lint", PaperLintDiff = "lint-diff" }) do
  vim.api.nvim_create_user_command(name, function() run_make(target) end,
    { desc = "Paper: make " .. target, force = true })
end

-- Project-specific LTeX classification of config/macros.tex and config/preamble.tex.
-- These are grammatical placeholders, not TeX macro expansion. Review this list
-- when adding macros; argument-taking commands need an explicit signature.
local commands = {}
local function register(action, names)
  for name in names:gmatch("%S+") do
    commands["\\" .. name] = action
  end
end

-- Names, uncertainty/scenario labels, and mathematical symbols used as words.
register("dummy", [[
  owltopddl acronym CamaraApproach plansys tomasys pddltomasys
  Uone Utwo Uthree Sone Stwo Sthree Sfour Sfive
  pddlTask pddlDomain pddlInstance pddlObjects pddlInitial pddlGoal pddlState
  pddlPredicates pddlActions pddlDerRules pddlPredicatesC pddlPredicatesR
  pddlActParam Ont SwrlRule N NC NR NI NRobject NRdata NIC NIR ALCI
]])

-- Mathematical operators/identifiers. Math regions are normally handled by
-- LTeX already; these mappings also preserve structure if used in prose.
register("dummy", [[
  qa pddlActName pddlActPre pddlActAdd pddlActDel pddlActionReq pddlQReq
  antecedent consequent FunctionTomasys FunctionDesign Component QAtype QAvalue
  Objective FunctionGrounding solvesF requiredBy isQAtype hasQAestimation hasNFR
  typeF solvesO typeFD hasQAvalue requiresO cStatus fdRealisability
  hasValue qaHasValue qaComparisonOperator qaCritical fdEfficacy fgStatus
  oImprove oStatus oUpdatable Action fdBetterUtility functionGrounding
  requiresC requiresF fActive fdUtility fdSpiralMed fdSpiralLow fdSpiralHigh
  aSearchPipelineOwl fGenerateSearchPath fMaintainMotion fFollowPipeline
  Domain Range varC varFD varFDtwo varFDbetter varF varU varUtwo varUbetter
  varQA varQAvalue fdUnground instanceFD instanceF instanceA
  instanceTrue instanceFalse bestFD validAndBest functionalReq
  algE algEff algDerive algGraph algRoots algS algC algP algNodes algSCC algSCCs
]])

-- Explicit plural nouns rather than singular placeholders.
register("pluralDummy", [[
  FunctionsTomasys FunctionDesigns QAtypes Objectives FunctionGroundings
]])

-- Visible formatting/author annotations: check the argument, not the command.
-- The author-note macros are active in this manuscript, so do not hide them.
register("default", [[
  red{} gustavo{} tobias{} ebj{} carlos{} francisco{}
]])

-- RQ{n} produces a label, not prose; do not grammar-check its numeric argument.
register("dummy", "RQ{}")

-- Hidden content, file paths, and layout-only values do not contribute prose.
register("ignore", [[
  hide{} inputtablebody{}
  greenColor blueColor redColor purpleColor orangeColor
  gridNodeSize gridNodeLine gridNodeSizePlus
  MakeUppercaseUnsupportedInPdfStrings
]])

vim.lsp.config("ltex_plus", {
  settings = {
    ltex = {
      -- The global underline threshold is WARN; LTeX's default is information.
      diagnosticSeverity = "warning",
      latex = {
        commands = commands,
      },
    },
  },
})
