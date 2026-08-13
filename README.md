# Amos Turchet — Quarto website

This is the Quarto migration of <https://amosturchet.github.io>.

The main site is intentionally simple to maintain:

- `index.qmd` — homepage text, teaching, positions, and useful links.
- `publications.bib` — research bibliography and abstracts.
- `styles.scss` — the small custom visual theme.
- `filters/publications.lua` — turns the BibTeX database into publication cards automatically. You normally do **not** need to edit this file.
- `.github/workflows/publish.yml` — builds and publishes the site to GitHub Pages.

The existing course/event HTML pages, blog, images, and PDFs are retained as static resources, so their URLs keep working. The old Bootstrap homepage is retained as `index-bootstrap.html` for reference during the transition.

## Local editing

Install Quarto, then from the repository directory run:

```bash
quarto preview
```

Quarto will open a local preview and refresh it when you save changes.

To render without starting the preview server:

```bash
quarto render
```

Rendered files go into `_site/`, which is intentionally ignored by Git.

## Updating the homepage

Edit `index.qmd`. Most routine content is ordinary Markdown:

```markdown
#### 2026–2027

- Course name — [Moodle](https://example.org)
- PhD course — [course page](course.html)
```

## Adding a publication

Add a BibTeX entry to `publications.bib`. The homepage will render the entries in the same order they appear in that file.

The publication renderer uses these common fields:

```bibtex
@article{example-key,
  author = {Amos Turchet and First Coauthor and Second Coauthor},
  title = {{Paper title}},
  year = {2026},
  journal = {Journal Name},
  note = {Journal Name 12 (2026), 1--20},
  doi = {10.xxxx/example},
  url = {https://journal.example/article},
  annote = {https://arxiv.org/pdf/xxxx.xxxxx},
  abstract = {Abstract text.},
  keywords = {publication}
}
```

`url` becomes the Journal/arXiv link, `annote` is used as the direct PDF link, and `abstract` becomes the collapsible Abstract section. Use `keywords = {other}` for entries that should appear under the **Other** heading.

For capitalization that BibTeX should preserve, keep the title in double braces as in the example.

## GitHub Pages deployment

The included GitHub Action renders the Quarto project and deploys `_site/` with GitHub Pages whenever you push to `main`. No generated HTML needs to be committed and no `gh-pages` branch is required.

Before the first deployment, open **Settings → Pages** in the GitHub repository and set **Source** to **GitHub Actions**. Then push the Quarto source files to `main`.

After that, the normal update cycle is simply:

```bash
git add .
git commit -m "Update website"
git push
```

GitHub Actions will rebuild and deploy the site automatically.

## Migration strategy

This version deliberately migrates only the main homepage to Quarto. Existing pages such as `group_coh.html`, `abelian.html`, `alggeo25.html`, `uniformity.html`, and the generated `blog/` are still served unchanged. They can be converted to `.qmd` one at a time later without breaking their current URLs.
