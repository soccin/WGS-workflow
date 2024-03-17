# GATK Best Practices (2023-09-13)

The following appears to be the latest version of the Best Practices for Somatic Call with Mutect2

## (How to) Call somatic mutations using GATK4 Mutect2

Avatar Derek Caetano-Anolles
Thursday at 11:52 Updated

This tutorial is applicable to Mutect2 version 4.1.1.0 and higher. Post suggestions/questions in the GATK Community Forum

[](https://gatk.broadinstitute.org/hc/en-us/articles/360035531132)

Additional info

[](https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2)

## Panel Of Normals (PoN)

- [](https://gatk.broadinstitute.org/hc/en-us/articles/360037058172-CreateSomaticPanelOfNormals-BETA-)

`gatk CreateSomaticPanelOfNormals`

```
Required Arguments:

--output,-O <String>          Output vcf  Required.

--variant,-V <GATKPath>       A VCF file containing variants  Required.
```


## Misc

Alternative to index feature file `$GATK IndexFeatureFile -I`; works with vcf (compressed or not) and perhaps beds

