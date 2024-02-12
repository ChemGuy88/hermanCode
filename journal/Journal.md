# Journal

## Notes - Anaconda

### Export manually (explicitely) installe dpackages[^1](https://stackoverflow.com/questions/62719108/is-there-a-way-in-conda-to-list-only-explicitly-installed-packages-without-the-p)

```shell
conda env export --from-history
```

Don't confuse it with 

```shell
conda list --explicit
```