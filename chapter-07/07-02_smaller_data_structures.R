# Integer data
object.size(as.numeric(seq_len(1e6)))
object.size(as.integer(seq_len(1e6)))

# Strings vs factors
strings <- rep.int(formatC(seq_len(1e4), width = 1000,
                           format = "d"),
                   100)
factors <- factor(strings)
object.size(strings)
object.size(factors)
