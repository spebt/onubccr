import ROOT as rt
from matplotlib import pyplot as plt
import numpy as np

# fname="YOUR_ROOT_FILE_PATH"
fname = "~/Downloads/SPEBT.root"
inFile = rt.TFile(fname, "READ")
myTree = inFile["Singles"]
myTree.Print()
# singleIDs = []
# print(myTree.GetEntries())
# for entry in myTree:
#     physicalID  = entry.layerID + entry.crystalID*8 + entry.submoduleID*32 + entry.rsectorID*128
#     singleIDs.append(physicalID)
# data=np.asarray(singleIDs)
#
# fig, ax = plt.subplots(figsize=(16, 9))
# counts, bins = np.histogram(data,data.size)
# plt.bar(bins[:-1],counts)
# print(data.shape)
# plt.suptitle("Single Distribution from the Monte Carlo Simulation")
# ax.set_xlabel("Physical Crystal Index")
# ax.set_ylabel("Counts of the Singles")
# fig.savefig("example_root2sysmat.png")
