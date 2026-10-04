return {
	{
		"dariuscorvus/tree-sitter-language-injection.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			go = {
				comment = {
					langs = {
						{ name = "sql", match = "^/\\*+( )*{lang}( )*\\*+/" },
					},
					query = [[
((comment) @comment .
  [
    (raw_string_literal
      (raw_string_literal_content) @injection.content)
    (interpreted_string_literal
      (interpreted_string_literal_content) @injection.content)
    (_
      [
        (raw_string_literal
          (raw_string_literal_content) @injection.content)
        (interpreted_string_literal
          (interpreted_string_literal_content) @injection.content)
      ])
  ]
  (#match? @comment "{match}")
  (#set! injection.language "{name}"))
]],
				},
			},
		},
	},
}
