# Steps to Track when Installing the Shell Package

The bash scripts have certain placehold in the form of variables that are meant to be replaced when the package is installed. Below is their inventory.

| Placeholder        | Description                                                                    |
| ------------------ | ------------------------------------------------------------------------------ |
| `$HOME`            | The home directory where `.bashrc` and `.bashprofile` are typically installed. |
| `$HERMAN_CODE_DIR` | The install path of this package.                                              |

Below is where each placeholder is found

- `$HOME`
  - Shell Package/macOS/templates/.bash_profile
  - Shell Package/macOS/templates/.bashrc
- `$HERMAN_CODE_DIR`
  - Shell Package/macOS/templates/scriptForLoop.sh
  - Shell Package/macOS/bashrc.bash