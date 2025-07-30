# Updating package on pypi

!!! note "Pre-requisite"
    Before updating a python package on pypi for a bug fix or feature or a new release, you should have the following:

    - Up-to-date local repository with all changes pushed to `GitHub` <!-- markdownlint-disable MD046 -->
    - You have updated `Setup.py` with an incrementation of the number in version.
    - You have a README.md which will be your pypi documentationo
    - a LICENSE file

## **1 Step** - Update local package for distribution

Updates the tools necessary for the packages:

```sh
python -m pip install --user --upgrade setuptools wheel build
python -m pip install --user --upgrade twine
python -m pip install -U packaging
```

## **2 Step** - Create a local distribution packages

The following command will make the folder `dist/` with new version of the files.

    python -m build --sdist
    python -m build --wheel
    twine check dist/*

If everything passes the checks then you can go ahead.

## **3 Step** - Upload the distribution to a test server

In order to perform this step you need to have an account in the test.pypi.org registry.

    python -m twine upload --repository testpypi dist/* -u __token__

An API token is required to upload the package. You can generate one in your account settings. Once everything is
all set, you can check the package in the test.pypi server:

    https://test.pypi.org/project/<PACKAGE>/<VERSION>/

### **3.1 Step** - Environment with test installation

Create a local environment to see if the package works:

    conda create --name test_pypi python

Then install the package from the test server (An API token is required to upload the package):

    python -m pip install --index-url https://test.pypi.org/simple/ --no-deps <PACKAGE>

## **4 Step** - Upload the distribution files on pypi

Ready to roll!

    python -m twine upload --repository pypi -u __token__ dist/*

Check the package online:

    https://pypi.org/project/<PACKAGE>/<VERISON>/

## Additional resources

- [Full documentation](https://packaging.python.org/en/latest/tutorials/packaging-projects/)

## References

- Federica Brando
- [Source](https://widdowquinn.github.io/coding/update-pypi-package/)
