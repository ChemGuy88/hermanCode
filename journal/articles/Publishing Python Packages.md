# Publishing Python Packages

## Manual Publishing

**Note that `build` is discontinued** and unavailable for Python versions greater than 3.12. The manual way is to use `twine`. However, all the below steps can be replaced using Continuous Improvement and Continuous Deployment, as implemented by GitHub Actions. 

```shell
# Package code
python -m build
# Check everything you wanted was packaged
unzip dist/thePackageWheelFile -d dist/tempDir
# Remove unzipped file
rm -rf dist/tempDir
# Upload package
twine upload dist/*
# Done!
```

References

- https://packaging.python.org/en/latest/tutorials/packaging-projects/
- https://packaging.python.org/en/latest/guides/using-testpypi/
- 
