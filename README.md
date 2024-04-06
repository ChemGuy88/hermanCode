# mySettings

## 2022/10/24

Separate customizations into `.bashrc` and `.bashprofile`, depending on context. Change based on recommendations from [this article](https://linuxize.com/post/bashrc-vs-bash-profile/).

## 2021/01/17

tox.ini goes in the home directory. The [documentation](https://flake8.pycqa.org/en/latest/user/configuration.html) says it should go in `~/.config/flake8` but actually, after trial and error, I see that on my MBP it goes in `~/`.
