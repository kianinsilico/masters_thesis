import pandas as pd
import numpy as np
import scanpy as sc
from sys import argv


args = argv[1:]
data_path = args[0]

tpm = pd.read_csv(
    data_path,
    sep="\t",
    index_col=0,
    compression="gzip"
    )

