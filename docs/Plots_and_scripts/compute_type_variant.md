# Compute type of variant

## Function to compute the type of variant starting from the REF and ALT columns

Function used in PROMINENT and in the outputs of the deepUMIcaller pipeline by consensus, to determine the variant type. (Designed for variants from VarDict and Ensembl-like format).

```python
def vartype(x, letters = ['A', 'T', 'C', 'G'], len_SV_lim = 100):
    if ">" in (x["REF"] + x["ALT"]) or "<" in (x["REF"] + x["ALT"]):
        return "SV"

    elif len(x["REF"]) > (len_SV_lim+1) or len(x["ALT"]) > (len_SV_lim+1) :
        return "SV"
    
    elif x["REF"] in letters and x["ALT"] in letters:
        return "SNV"
    
    elif len(x["REF"]) == len(x["ALT"]):
        return "MNV"
    
    elif x["REF"] == "-" or ( len(x["REF"]) == 1 and x["ALT"].startswith(x["REF"]) ):
        return "INSERTION"
    
    elif x["ALT"] == "-" or ( len(x["ALT"]) == 1 and x["REF"].startswith(x["ALT"]) ):
        return "DELETION"
    
    return "COMPLEX"
```

Open to suggestions to accommodate how other callers may report the variants.

## Reference

- Ferriol Calvet
- Paula Gomis
