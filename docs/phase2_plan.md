# Phase 2: Cross-dataset DMG cell-state analysis

## Core deliverable

Cross-dataset cell-state transfer using the completed Filbin Phase 1
replication as the reference anchor.

## Main workflow

1. Inventory the Filbin, Liu 2022, and Fernández 2026 datasets.
2. Build standardized AnnData objects.
3. Validate each dataset independently.
4. Harmonize gene identifiers and build a signature registry.
5. Modernize the Filbin analysis with PCA, UMAP, and Leiden.
6. Transfer Filbin signatures into Liu and Fernández.
7. Transfer Liu and Fernández signatures back into Filbin.
8. Run consensus NMF as a modernization of the Phase 1 NNMF analysis.
9. Investigate OPC-like substructure.
10. Evaluate MES-like programs as a secondary analysis.
11. Perform GO, KEGG, Reactome, and Hallmark enrichment.
12. Build a combined unintegrated AnnData object.
13. Attempt limited Harmony or scVI integration only if the decision gate passes.

## Integration decision gate

Full integration is optional and should be attempted only after the core
cross-dataset analyses are complete and the expression matrices, metadata,
gene overlap, and transferred labels have been validated.
