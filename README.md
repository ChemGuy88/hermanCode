# myatom

See this Stack Overflow [solution](https://stackoverflow.com/questions/30006827/how-to-save-atom-editor-config-and-list-of-packages-installed).

## To save settings

First save the list of installed Atom packages to a file

```
apm list --installed --bare
```

Then push to GitHub

## To load settings

Pull from GitHub, then install Atom packages from the file

```
apm install --packages-file ~/.atom/package.list
```
