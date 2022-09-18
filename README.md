# Using CMAKE with **R**

This repo reproduces the example given in the
[Writing R Extensions](https://cran.r-project.org/doc/manuals/r-devel/R-exts.html#Using-cmake).

Branch **main** contains a version where a `configure` file and a `Makevars.in` file is used.
Branch **Makevars-only** contains a version where only a `Makevars` file is used.

The main conclusion from this example is that using
```
$(SHLIB): libhighs.a
```
did not work for me but using
```
all: libhighs.a $(SHLIB) cleanup
```
did work.
