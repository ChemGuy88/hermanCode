# SSH without Profile

<!-- Created Sun Apr 13 18:49:36 2025 -->

Sometimes you mess up your *.bash_rc* or *.z_profile* files and it locks you out. A solution is to SSH without invoking the configuration files.

## BASH

```bash
ssh -t user@host bash --norc --noprofile
```

[Reference](https://serverfault.com/a/668310/806462)

## Z Shell

```zsh
ssh -t user@host zsh -f
# equivalent to
ssh -t user@host zsh --no-rcs
```

[Reference](https://unix.stackexchange.com/a/90304/399435)
