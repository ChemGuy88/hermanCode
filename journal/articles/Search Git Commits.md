# Search Git Commits

## Search commit messages

```shell
git log --grep=<pattern>
```

From [StackOverflow](https://stackoverflow.com/a/3826800/5478086).

## Search files across commits

```shell
git grep <pattern> $(git rev-list --all)
```

From [betterstack.com](https://betterstack.com/community/questions/how-to-grep-committed-code-in-the-git-history/).
