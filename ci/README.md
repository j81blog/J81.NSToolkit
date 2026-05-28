# CI scripts

The scripts in this folder are used by the GitHub Actions workflow.

- `Install.ps1`: CI/local dependency setup
- `Tests.ps1`: CI/local Pester entrypoint
- `Publish.ps1`: branch-based module publishing (`dev` -> PSTestGallery, `main` -> PSGallery)
- `Invoke-Process.ps1`: helper for robust external process execution from scripts
