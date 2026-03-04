#!/bin/bash
set -e  # exit on any error

echo "🔍 Starting full code quality and sanity checks..."

# 1. Update schema annotations (if using annotate gem)
echo "📝 Running annotate..."
if bundle exec annotate --version >/dev/null 2>&1; then
  bundle exec annotate --models --routes --exclude tests,fixtures
else
  echo "⚠️  annotate gem not found, skipping."
fi

# 2. Format all ERB files with htmlbeautifier
echo "✨ Running htmlbeautifier on ERB files..."
find app/views -name "*.html.erb" -exec bundle exec htmlbeautifier {} \;

# 3. Run erb_lint with autocorrect (safe linters only)
echo "🧹 Running erb_lint (autocorrect)…"
bundle exec erblint app/views/**/*.html.erb --autocorrect

# 4. Run rubocop with autocorrect on Ruby files (exclude ERB automatically)
echo "🚀 Running RuboCop (autocorrect) on Ruby files…"
bundle exec rubocop -a  # adjust paths as needed

# 5. Precompile assets (check for asset pipeline errors)
echo "🎨 Precompiling assets…"
bundle exec rails assets:precompile RAILS_ENV=test RAILS_GROUPS=assets

echo "✅ All checks passed! Code is clean, assets compile, and annotations are up‑to‑date."