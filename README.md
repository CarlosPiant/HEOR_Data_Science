# R/RStudio Tutorial + HEOR — UW Style (Quarto Website)

This repository hosts a University of Washington–styled **Quarto website** that serves as:
- A beginner-friendly **R/RStudio tutorial** (installation, IDE overview, data import, packages, objects, analysis, saving work), and
- An applied **HEOR** walkthrough using a synthetic claims/EHR dataset (no PHI).

## Quick start

1. **Create a GitHub repo** (e.g., `your-org-or-user/your-repo`) and push these files.
2. Ensure your default branch is **`main`**.
3. The included GitHub Action will render the Quarto site and publish it to the **`gh-pages`** branch on every push to `main`.

### Local preview (optional)

- Install [Quarto](https://quarto.org/).
- In a terminal:
  ```bash
  quarto preview
  ```
  The site runs locally with live reload. Press `Ctrl+C` to stop.

## Folder structure

```
.
├─ _quarto.yml                  # Site configuration (navbar, UW theme, formats)
├─ index.qmd                    # Main tutorial + HEOR walkthrough (UW styled)
├─ heor-template.qmd            # Same content as a separate page (optional)
├─ uw-theme.css                 # UW purple/gold HTML theme
├─ uw-pdf-header.tex            # PDF header for UW-colored headings & links
├─ data/
│  └─ claims_synthetic.csv      # Synthetic claims/EHR dataset (no PHI)
└─ .github/
   └─ workflows/
      └─ publish.yml            # GitHub Actions: render & publish to gh-pages
```

## Deploying to GitHub Pages

The provided workflow uses the official **quarto-dev** GitHub Action to:
- render the website, then
- **publish** to the `gh-pages` branch.

Make sure GitHub Pages is set to **Deploy from a branch**:  
**Settings → Pages → Build and deployment → Source: `Deploy from a branch`**  
**Branch:** `gh-pages` (folder: `/`)

> If you prefer, you can also publish manually from your machine:
> ```bash
> quarto publish gh-pages
> ```

## Updating the site

- Edit any `.qmd` file or assets, then push to `main`.  
- The workflow rebuilds & deploys the site automatically.

## Notes

- For **PDF rendering**, ensure a LaTeX distribution is available locally (e.g., TinyTeX). The site itself is deployed as HTML, so PDF is optional.
- Replace the GitHub link in `_quarto.yml` with your repo URL.
- The synthetic dataset is small and de-identified; do **not** upload PHI.
