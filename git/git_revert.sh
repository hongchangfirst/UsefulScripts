# Revert multiple commits but not commit, for this case it's two latest commits.
git revert --no-commit HEAD~2..HEAD

# changes are reverted and is in stage, then commit
git commit


