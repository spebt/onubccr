# Example Jupyter Notebook to convert the Gate simulation ROOT output to system matrix

 ## 1. Import the packages


```python
import ROOT as rt
from matplotlib import pyplot as plt
import numpy as np
from ast import literal_eval as make_tuple
```

## 2. Get the ROOT file path from user input


```python
fname = input("Path to the ROOT file:")
```

## 3. Read the ROOT file


```python
print("Using ROOT file:",fname)
inFile = rt.TFile(fname, "READ")
```

## 4. Get ROOT TTree name from user input


```python
treeName = input("Name of the TTree:")
```

## 5. Read the ROOT TTree with the given name


```python
myTree = inFile[treeName]
```

## 6. Get the number of detector units from user input


```python
N_det_unit = input("Number of deterctor units:")
```

## 7. Get FOV dimensions from user input


```python
N_fov=make_tuple(input("FOV Dimensions:"))
```

## 8. Fill the detector unit ID (i), source x position and source y position into 3D histogram


```python
hmapAll = rt.TH3F("hmapAll","hampAll",N_det_unit,0,N_det_unit,N_fov[0],-N_fov[0]//2,N_fov[0]//2,N_fov[1],-N_fov[1]//2,N_fov[1]//2)
myTree.Draw("(layerID + crystalID*8 + submoduleID*32 + rsectorID*128):sourcePosY:sourcePosX>>hmapAll","","goff")
```

## 9. Get the total number of emitted particles from user input


```python
ntotal=int(input("Total number of gamma rays:"))
```

## 10. Derive the system matrix from the 3D histogram

_Note: It is going to take longer time to run_


```python
sysmat = np.reshape(np.array(hmapAll),(N_det_unit+2,N_fov[0]+2,N_fov[1]+2))[1:-1,1:-1,1:-1]/ntotal
```

## 11. Reshape the system matrix to 2D matix, with (i,j) indices


```python
sysmat=sysmat.reshape((N_det_unit,np.prod(N_fov)))
```

## 12. Get the detector unit index for plotting


```python
det_id = int(input(f"Detector unit index [0-{N_det_unit}]:"))
```

## 13. Plot the PPDF for the detector unit


```python
fig, ax = plt.subplots(figsize=(10, 9))
imshow_obj = ax.imshow(sysmat[det_id].reshape(N_fov),cmap='turbo',origin='lower')
cbar=plt.colorbar(imshow_obj)
plt.suptitle(f"PPDF of detector unit {det_id}")
ax.set_xlabel("FOV Voxel X (mm)")
ax.set_ylabel("FOV Voxel Y (mm) ")
fig.tight_layout()
```


```python

```
