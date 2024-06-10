return {
  'junegunn/vim-easy-align',
  config = function()
    vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { noremap = false })
    vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { noremap = false })

    -- align on dates
    -- ## Copilot ---
    -- Sure, let's break down the regular expression `^\(\S\+\s\)\?\zs\d\{4}-\d\{2}-\d\{2}`:
    -- - `^` - This matches the start of a line.
    -- - `\(` and `\)` - These are escaped parentheses that group the elements inside them. The group can be used as a single unit.
    -- - `\S\+` - This matches one or more (`\+`) non-whitespace characters (`\S`).
    -- - `\s` - This matches a single whitespace character.
    -- - `\)?` - The `?` makes the preceding group optional. This means the regular expression will match lines that start with one or more non-whitespace characters followed by a space, as well as lines that don't have this pattern.
    -- - `\zs` - This is a Vim-specific sequence that sets the start of the match. Everything before `\zs` is ignored for the purposes of alignment.
    -- - `\d\{4}-\d\{2}-\d\{2}` - This matches a date in the format `YYYY-MM-DD`. `\d\{4}` matches exactly four digits (the year), `\d\{2}` matches exactly two digits (the month and day), and `-` matches the hyphen between them.
    -- So, the regular expression `^\(\S\+\s\)\?\zs\d\{4}-\d\{2}-\d\{2}` matches lines that start with a date or have a date after one or more non-whitespace characters and a space. The `\zs` sets the start of the match to the date, so the alignment will be done based on the position of the date.
    local date_str = [[:%EasyAlign/^\(\S\+\s\)\?\zs\d\{4}-\d\{2}-\d\{2}/]]
    vim.keymap.set('n', '<localleader>ed', date_str .. '<cr>', { noremap = true })

    -- align on projects
    local project_str = [[:%EasyAlign/+/ { 'right_margin': 0 }]]
    vim.keymap.set('n', '<localleader>ep', project_str .. '<cr>', { noremap = true })

    -- align on first word of description, handling x,w,f for completed tasks
    -- ## Copilot ---
    -- Sure, let's break down the regular expression `/\(^[xwf]\s\+\d\{4\}-\d\{2\}-\d\{2\}\s\+\(\d\{4\}-\d\{2\}-\d\{2\}\)\?\)\?\s*\zs[a-z]\C/`:
    -- - `\( ... \)\?`: This is an optional group. The `?` makes the group optional, meaning it can appear 0 or 1 times.
    -- - `^[xwf]`: This matches the start of a line (`^`) followed by either `x`, `w`, or `f`.
    -- - `\s\+`: This matches one or more whitespace characters.
    -- - `\d\{4\}-\d\{2\}-\d\{2\}`: This matches a date in the format `YYYY-MM-DD`. `\d\{4\}` matches exactly 4 digits (for the year), `-` matches a literal hyphen, `\d\{2\}` matches exactly 2 digits (for the month), another `-` matches another literal hyphen, and the final `\d\{2\}` matches exactly 2 digits (for the day).
    -- - `\s\+`: This matches one or more whitespace characters.
    -- - `\(\d\{4\}-\d\{2\}-\d\{2\}\)\?`: This is another optional group that matches a date in the format `YYYY-MM-DD`.
    -- - `\s*`: This matches zero or more whitespace characters.
    -- - `\zs`: This sets the start of the match. Everything before `\zs` is used for matching, but is not included in the match itself.
    -- - `[a-z]`: This matches any lowercase letter.
    -- - `\C`: This forces the pattern to be case-sensitive.
    -- So, this regular expression matches a lowercase letter that comes after an optional group consisting of `x`, `w`, or `f` at the start of a line, followed by a date, some whitespace, and another optional date. The match includes only the lowercase letter, not the entire group. The pattern is case-sensitive.
    local description_str = [[:%EasyAlign/\(^[xwf]\s\+\d\{4\}-\d\{2\}-\d\{2\}\s\+\(\d\{4\}-\d\{2\}-\d\{2\}\)\?\)\?\s*\zs[a-z]\C/ { 'right_margin' : 0 }]]
    vim.keymap.set('n', '<localleader>ew', description_str .. '<cr>', { noremap = true })

    -- reset spacing
    vim.keymap.set('n', '<localleader>e<space>', function()
      vim.api.nvim_command [[:%s/^\s*//g]]
      vim.api.nvim_command [[:%s/\s\+/ /g]]
      vim.api.nvim_command [[:nohl]]
    end, { noremap = true })

    -- easy align on date, description, and project
    vim.keymap.set('n', '<localleader>ee', function()
      -- can't get this to work, so just copy the commands in
      -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<localleader>ew', true, true, true), 'n', true)
      vim.api.nvim_command(date_str)
      vim.api.nvim_command(description_str)
      vim.api.nvim_command(project_str)
    end, { noremap = true })
  end,
}
