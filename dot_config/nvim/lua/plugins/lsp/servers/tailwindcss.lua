return {
  settings = {
    tailwindCSS = {
      experimental = {
        -- classRegex: tells Tailwind where to look for class strings OUTSIDE of className="...".
        -- Each entry is { outer_pattern, inner_pattern }:
        --   outer_pattern — captures the whole function call (e.g. cva(...))
        --   inner_pattern — extracts individual class strings from inside it
        --
        -- This gives you Tailwind completions + class sorting inside utility libraries.
        classRegex = {
          -- cva() — class-variance-authority: variant-based class composition
          { "cva\\(([^)]*)\\)",  "[\"'`]([^\"'`]*).*?[\"'`]" },

          -- cx() — typically a thin cva/clsx wrapper
          { "cx\\(([^)]*)\\)",   "(?:'|\"|`)([^']*)(?:'|\"|`)" },

          -- clsx() — conditional class merging utility
          { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },

          -- cn() — shadcn/ui's helper (wraps clsx + tailwind-merge)
          { "cn\\(([^)]*)\\)",   "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
}
