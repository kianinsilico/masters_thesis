# Development Diary: Master's Thesis & Internship Project
## Master of Bioinformatics, University of Bologna

**Project Focus:** Single-cell RNA-sequencing (scRNA-seq) analysis of H3K27M-mutant gliomas (Dataset: GSE102130, Smart-seq2 protocol).
**Infrastructure:** Debian machine (`hummingbird`), Conda (`dmg` environment), RStudio.

---

### Phase 1: Environment Architecture & Dependency Resolution
The initial phase focused on setting up a robust, isolated environment for downstream statistical tests, principal component analysis, and heatmap visualizations on scRNA-seq data.

* **Initial Approach:** Attempted compiling Bioconductor packages (`RCurl`, `rlang`, etc.) from source via `BiocManager::install()`.
* **Challenge:** The Conda environment lacked the specific C/C++ compilers (`x86_64-conda-linux-gnu-cc`), resulting in cascading compilation failures.
* **Resolution:** Shifted strategy to rely on Conda's pre-compiled binaries. Executed package installations directly through the terminal to bypass compilation requirements:
    ```bash
    conda install -c conda-forge -c bioconda bioconductor-singlecellexperiment bioconductor-scater bioconductor-scran r-seurat
    ```

### Phase 2: Version Control & Repository Initialization
Establishing tracking for the pipeline logic, drawing on standard practices for custom scripting and pipeline development.

* **Identity Configuration:** Configured local Git identity.
* **Commit Rectification:** Re-attributed early commits to the correct identity using:
    ```bash
    git commit --amend --reset-author --no-edit
    ```
* **Authentication:** Generated an SSH key and linked the local machine to GitHub.
* **Repository setup:** Pushed the `masters_thesis` repository containing a `.gitignore` specifically configured to exclude bulky pipeline artifacts (`.snakemake/`, `anaconda3/`, `*.mtx`).

### Phase 3: Infrastructure Constraints & Docker Pivot
Explored containerization to isolate the pipeline, adapting workflows previously used in coursework.

* **Action:** Created an isolated bridge network (`internship-net`).
* **Challenge:** Attempted to pull the 4GB `jupyter/datascience-notebook` image, but encountered a `no space left on device` error. The shared machine's root partition (`/`) had only 2.9GB available.
* **Resolution:** 1. Cleaned the Docker cache using `sudo docker system prune -a` to protect the shared server state.
    2. Pivoted to exclusively using the Conda environment located on the spacious `/home` partition (142GB available).

### Phase 4: IDE Setup & Package Troubleshooting
Finalizing the R environment for high-performance single-cell analysis.

* **Jupyter vs. RStudio:** Attempted to use Jupyter Lab via Conda but encountered an `argcomplete` dependency conflict. Successfully integrated `IRkernel`, but ultimately favored RStudio for its stability with heavy R graphical operations.
* **Bleeding-Edge Dependencies:** Installed supplementary packages directly from GitHub to access the latest features for Seurat v5.
    * Installed `devtools` and `SeuratData`.
    * **BPCells Challenge:** The `bnprks/BPCells` repository underwent a structural change. Resolved the installation failure by explicitly targeting the R subdirectory:
        ```R
        remotes::install_github("bnprks/BPCells/r")
        ```
* **Namespace Conflicts:** Acknowledged expected masking warnings when loading `dplyr` alongside base R/stats.

### Phase 5: Data Acquisition & Memory Optimization Strategy
Preparing the dataset while respecting the hardware limitations of the shared environment.

* **Data Target:** Downloaded the raw text-based TPM matrix (`GSE102130_proliferative_TPM.txt.gz`) directly from GEO.
* **Optimization Protocol (BPCells):** Instead of loading the massive text matrix directly into RAM, the protocol utilizes `BPCells` to convert the `.txt.gz` file into a compressed, disk-backed binary matrix. 
* **Integration:** Initialized a Seurat v5 object (`Assay5`) pointing to this on-disk matrix, allowing for highly efficient memory usage during upcoming quality control, clustering, and marker identification tasks.
