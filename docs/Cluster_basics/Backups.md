# Backups

As explained in the [Structure section](https://bbglab.github.io/bbgwiki/Cluster_basics/Structure/), there are different partitions with different levels of backups. Basically, there are two options of backup:  

- **Snapshots** : It is the state of the system at a particular point in time. It is usefull for human mistakes, ie. if you delete or edit the wrong file. For HW errors or big catastrophes (e.g. a fire) (unlikely) is not useful, because the backup data is stored in the same disk/location. We can recover the data by ourselves.
- **Standard backup** : Useful for human mistakes and HW/catastrophes. To recover the data from a backup, we need to contact IT and it could take a few days for recovering.

Depending the partition, the safety level is different:

- **`home/`** : Snapshots: 3 per day last 1.5 days, one for each of the last 5 days and one for each of the last 4 weeks. **medium-high** safe.
- **`projects/`** : Standard backups and snapshots. Backup: every day during the last 15 days and every week during the last 12 weeks. Snapshots: 3 per day last 5 days, one for each of the last 15 days and one for each of the last 12 weeks. **high** safe.
- **`datasets/`** : Standard backups. Backup: every Sunday, replaced every week. **medium** safe.
- **`datasafe/`** : Snapshots: 3 per day last 5 days, one for each of the last 15 days and one for each of the last 12 weeks. **medium-high** safe.
- **`nobackup/`**/ **`nobackup2/`** : No backup at all...

## Example of recovering data

Let's say we have deleted or edited by mistake a file in a partition with snapshots (e.g. `/data/bbg/projects/`). If we check the content of the `.snapshot/` folder:

```sh
mgrau@login01:/data/bbg/projects$ ls /data/bbg/projects/.snapshot/
daily_at_23_noSun.2023-06-05_2300  daily_at_23_noSun.2023-06-15_2300        hourly_mon2fri_11_15_19.2023-06-16_1900  hourly_mon2fri_11_15_19.2023-06-21_1900  Sun_at_23.2023-05-14_2300
daily_at_23_noSun.2023-06-06_2300  daily_at_23_noSun.2023-06-16_2300        hourly_mon2fri_11_15_19.2023-06-19_1100  hourly_mon2fri_11_15_19.2023-06-22_1100  Sun_at_23.2023-05-21_2300
daily_at_23_noSun.2023-06-07_2300  daily_at_23_noSun.2023-06-17_2300        hourly_mon2fri_11_15_19.2023-06-19_1500  hourly_mon2fri_11_15_19.2023-06-22_1500  Sun_at_23.2023-05-28_2300
daily_at_23_noSun.2023-06-08_2300  daily_at_23_noSun.2023-06-19_2300        hourly_mon2fri_11_15_19.2023-06-19_1900  Sun_at_23.2023-04-02_2300                Sun_at_23.2023-06-04_2300
daily_at_23_noSun.2023-06-09_2300  daily_at_23_noSun.2023-06-20_2300        hourly_mon2fri_11_15_19.2023-06-20_1100  Sun_at_23.2023-04-09_2300                Sun_at_23.2023-06-11_2300
daily_at_23_noSun.2023-06-10_2300  daily_at_23_noSun.2023-06-21_2300        hourly_mon2fri_11_15_19.2023-06-20_1500  Sun_at_23.2023-04-16_2300                Sun_at_23.2023-06-18_2300
daily_at_23_noSun.2023-06-12_2300  hourly_mon2fri_11_15_19.2023-06-15_1900  hourly_mon2fri_11_15_19.2023-06-20_1900  Sun_at_23.2023-04-23_2300
daily_at_23_noSun.2023-06-13_2300  hourly_mon2fri_11_15_19.2023-06-16_1100  hourly_mon2fri_11_15_19.2023-06-21_1100  Sun_at_23.2023-04-30_2300
daily_at_23_noSun.2023-06-14_2300  hourly_mon2fri_11_15_19.2023-06-16_1500  hourly_mon2fri_11_15_19.2023-06-21_1500  Sun_at_23.2023-05-07_2300
```

We can see a daily snapshot at 23.00h during the last 15 days (`daily_at_23_noSun.2023-06-XX_2300`). Then we have 3 snapshots per day (at 11h,15h and 19h) during the last 5 working-days (`hourly_mon2fri_11_15_19.2023-06-XX_XX00`) and then we have one snapshot weekly (sunday at 23h) during the last 12 weeks (`Sun_at_23.2023-0X-XX_2300`).

Inside every snapshot, we can see the same file structure of `projects`:

```sh
mgrau@login01:/data/bbg/projects$ ls /data/bbg/projects/.snapshot/daily_at_23_noSun.2023-06-05_2300
all_aecc                      clustering_3d          diskusage20200511.txt   healthy_chemo              nanopore              regulatory_regions        small_collaborations_ines
all_aecc_pediatric            cndrivers              diskusage20200619.txt   hotmaps_signatures         neoantigen            repair_states             stjude
alphafold_features            colorectal_apoe        diskusage20200725.txt   immune_biomarkers          new_oncodrivemut      replication_timing        st_jude_life
bgframework                   courses                diskusage20200926.txt   immune_pheno_hartwig       noncoding_regions     reverse_calling           stockholm_ai
bladder_ts                    cptac_analysis         diskusage20201011.txt   intogen                    nonsense_cptac        rhabdoid_tumors           structural_variants
blca_eduardporta              damage_maps            diskusage_20211119.txt  intogen_2017               olivia                sample_specific_features  test_folder_delete
boostdm                       dde                    diskusage.txt           intogen_plus               oncodrive             sample_specific_profiles  tf_mutations
boostdm_ch                    degrons                driver_potential        Liver_Mouse                oncodrive3d           samuels_hmf               translation_fidelity
boostdm_germline_sensitivity  diskusage20200104.txt  exemple_test            meso_exomes                oncodriveclustl       sars_cov_2                ubiquitins
breakpoints                   diskusage20200115.txt  expression_signatures   methyl_predictors          oriol_aml_intogen     scell_tall                worms
build_table.py                diskusage20200201.txt  genomewide_mmr          miguel_nanopore            pagerank_combination  service                   zfp36l1
cgi                           diskusage20200215.txt  genomewide_MMR          mutfootprints              pancreas_meritxell    sherlock
cgi_clinics                   diskusage20200319.txt  genomic_regions         mutfootprints_code_review  pepe_clustering       signature_sensitivity
chemogenomics                 diskusage20200330.txt  hairpins                mutograph                  periodicity           signet
chemotrans                    diskusage20200421.txt  hartwig                 mut_region_profile         pileup_mappability    simuclones
clonalhemato_ukb              diskusage20200427.txt  hartwig_signatures_id   mut_risk                   prominent             sjd_pediatric_tumors
```

We can then copy back the file deleted to the original location.

## Reference

- Miguel Grau
- Jordi Deu-Pons
