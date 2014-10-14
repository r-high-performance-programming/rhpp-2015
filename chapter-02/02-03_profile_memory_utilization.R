# Profile memory using Rprof
Rprof("Rprof-mem.out", memory.profiling=TRUE)
# sampvar() is defined in previous example
y <- sampvar(x)
Rprof(NULL)
summaryRprof("Rprof-mem.out", memory="both")

# Profile using gcinfo()
gcinfo(TRUE)
y <- sampvar(x)
gcinfo(FALSE)
