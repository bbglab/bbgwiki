# Hierarchical Clustering

## Python

```python
import numpy as np
from scipy.cluster import hierarchy
import matplotlib.pyplot as plt

# condensed distance array
ydist = np.array([662., 877., 255., 412., 996., 295., 468., 268., 400., 754., 564., 138., 219., 869., 669.])

# linkage object
Z = hierarchy.linkage(ydist, 'single')

# compute and plot dendrogram
dn = hierarchy.dendrogram(Z)
```

![BBGWiki edit online tutorial](/assets/images/hierarchical_clustering.jpg)

## Reference

- Ferran Muiños
