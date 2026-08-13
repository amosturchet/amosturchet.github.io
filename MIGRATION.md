# Cut-over checklist

This package is designed to replace the source files in the existing `amosturchet.github.io` repository while keeping the repository itself and its Git history.

## Recommended safe transition

1. In your existing local repository, make sure the current Bootstrap site is committed.
2. Create a migration branch:

   ```bash
   git switch -c quarto-migration
   ```

3. Replace the working-tree files with the contents of this package **without deleting your existing `.git/` directory**.
4. Install Quarto and preview the result:

   ```bash
   quarto preview
   ```

5. Check the homepage, CV, blog, and the older course/event pages you still use.
6. Commit the migration branch and push it if you want a backup/review point.
7. In GitHub, open **Settings → Pages** and change **Source** to **GitHub Actions**.
8. Merge the migration branch into `main` and push. The included workflow will build `_site/` and deploy it automatically.

## What changed

- `index.html` is no longer hand-maintained. Its source is now `index.qmd`.
- Publications and abstracts are in `publications.bib` and rendered automatically by `filters/publications.lua`.
- Styling is in `styles.scss` and uses Quarto/Bootstrap rather than the old Start Bootstrap Resume source pipeline.
- The old homepage is available as `index-bootstrap.html` for comparison.
- Existing standalone HTML pages, PDFs, images, and the generated blog remain static resources, so links such as `group_coh.html`, `abelian.html`, `uniformity.html`, and `alggeo25.html` remain valid.
- The old `other/node_modules` build tree and copied Git history are intentionally not included in this package.

## Routine maintenance after migration

For most updates, edit only:

- `index.qmd` for biography, teaching, positions, and links;
- `publications.bib` for papers;
- `styles.scss` only when you want to change the visual design.

Then commit and push. GitHub Pages deployment is automatic.
