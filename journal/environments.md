# Virtual Environments

# `herman-awstut`

AWS Tutorial environment

```zsh
conda create -n herman-awstut python=3.12
```

# `herman-base`

```zsh
conda create -n herman-base autopep8 bs4 flake8 ipython matplotlib numpy pandas pyarrow python=3.12 pyyaml seaborn selenium sqlalchemy -c conda-forge -c defaults
```

# `herman-ctc`

Herman's iCloud Contacts address book.

```zsh
conda create -n herman-ctc autopep8 bs4 flake8 ipython matplotlib numpy pandas pyarrow pyicloud python=3.10 pyyaml seaborn selenium sqlalchemy -c auto -c conda-forge -c defaults
```


# `herman-covis`

Computer vision

```zsh
conda create -n herman-base autopep8 bs4 flake8 ipython matplotlib numpy opencv pandas pyarrow python=3.12 pyyaml seaborn selenium sqlalchemy -c conda-forge -c defaults
```

# `herman-leetcode`

```zsh
conda create -n herman-leetcode autopep8 bs4 flake8 ipython matplotlib numpy pandas pyarrow python=3.12 pyyaml seaborn selenium sqlalchemy=2.0 sqlalchemy-redshift -c conda-forge -c defaults
```

# `herman-midas`

```zsh
conda create -n herman-midas coinbase-advanced-py gh python=3.12 websocket-client -c conda-forge && \
conda activate herman-midas && \
python -m pip install --user rel
```

Package installation documentation
- [gh](https://github.com/cli/cli#installation)
- [rel](https://pypi.org/project/rel/) (registered event listener)
- [websocket-client](https://websocket-client.readthedocs.io/en/latest/installation.html)

# `herman-javascript`

```zsh
conda create -n herman-javascript autopep8 bs4 flake8 ipython matplotlib nodejs numpy pandas pyarrow python=3.12 pyyaml seaborn selenium sqlalchemy sqlalchemy-redshift -c conda-forge -c defaults
```
