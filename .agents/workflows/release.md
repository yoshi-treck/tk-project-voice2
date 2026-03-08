---
description: Release changes to main branch
---

This workflow automates the process of saving current changes in the `dev` branch, merging them into `main`, pushing to trigger a Vercel deployment, and then returning to `dev` for further development.

1. **Save (Commit)**: Save current changes in the `dev` branch.
   // turbo
   `git add . && git commit -a -m "release: {{prompt}}"`

2. **Switch**: Checkout the `main` branch.
   // turbo
   `git checkout main`

3. **Merge**: Merge the `dev` branch into `main`.
   // turbo
   `git merge dev`

4. **Push**: Push the `main` branch to the remote repository. This will trigger the Vercel production build.
   // turbo
   `git push origin main`

5. **Return**: Checkout the `dev` branch to continue development.
   // turbo
   `git checkout dev`
