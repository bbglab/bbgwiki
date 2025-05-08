    
# Dynamic path configuration for IRB/BBG clusters

To ensure compatibility when running scripts or notebooks across different clusters (IRB or BBG), you can use the following Python line to dynamically set the working directory based on the machine hostname:

```python
import socket

WORKSPACE = "/data/bbg" if socket.gethostname().startswith("irb") else "/workspace"
```

> [!WARNING]
> This step is highly time- and resource-intensive, requiring a significant amount of free disk space and computational power. It will download and process a large amount of data. Ensure sufficient resources are available before proceeding, as insufficient capacity may result in extended runtimes or processing failures.

## How to Use

### Option 1: directly in a notebook or script

Add the above line at the top of your notebook or Python script:

```python
import socket

WORKSPACE = "/data/bbg" if socket.gethostname().startswith("irb") else "/workspace"

example_path = f"{WORKSPACE}/projects/my_project/"
print(f"Path: {example_path}")
```

### Option 2: Using a `global_variables.py` file
For better reusability, define this variable in a file named global_variables.py:

`global_variables.py`
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