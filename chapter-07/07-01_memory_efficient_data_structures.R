# Explore object sizes
object.size(logical(1e6))
object.size(integer(1e6))
object.size(numeric(1e6))
object.size(complex(1e6))
object.size(rep.int(NA_character_, 1e6))
object.size(raw(1e6))
object.size(vector("list", 1e6))

# Explore string data size
object.size(rep.int("0123456789", 1e6))
object.size(rep.int(formatC(seq_len(1e3), width = 10), 1e3))
object.size(formatC(seq_len(1e6), width = 10))
