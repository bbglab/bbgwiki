
# Dynamic path configuration

To ensure compatibility when running scripts or notebooks across different clusters (IRB or BBG), you can use the following Python line to dynamically set the working directory based on the machine hostname:

```python
import socket

WORKSPACE = "/data/bbg" if socket.gethostname().startswith("irb") else "/workspace"
```

!!! warning
    This line assumes the script is being executed on a working node, where the hostname reflects the actual compute environment. It will not work if you are on the login node, which you shouldn't be using for computation in any case.

## How to Use

### Option 1: directly in a notebook or script

Add the above line at the top of your Jupyter notebook or Python script:

```python
import socket

WORKSPACE = "/data/bbg" if socket.gethostname().startswith("irb") else "/workspace"

example_path = f"{WORKSPACE}/projects/my_project/"
print(f"Path: {example_path}")
```

### Option 2: Using a file including global variables

For better reusability, define this variable in a separate Python file (e.g., `global_variables.py`):

```python
import socket

WORKSPACE = "/data/bbg" if socket.gethostname().startswith("irb") else "/workspace"
```

Then, import it in your notebook or script:

```python
from global_variables import WORKSPACE

example_path = f"{WORKSPACE}/projects/my_project/"
print(f"Path: {example_path}")
```

This way, you only need to define the path logic once and can reuse it throughout your codebase.

!!! info
    Keeping shared variables—like paths, pipeline run names, or directory names—in a single Python file that can be
    imported from other scripts or notebooks is a good practice. It helps avoid inconsistencies and reduces the risk of
    forgetting to update paths or values across multiple files.

## Reference

- Stefano Pellegrini
