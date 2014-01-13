# Analyzing runtime of program on : http://www.brpreiss.com/books/opus8/html/page38.html



# t_fetch, t_store, t_call
# t_store
# t_store
# (n + 1) * (2*t_fetch + t_<=)
# n * (2*t_fetch + t_store + t_+)
# n * (2*t_fetch + t_store + t_+)
# t_fetch + t_return

# Time to compute horner's rule

# t_call + 3*t_fetch **** (INCORRECT, d"ef horner(a,n,x)"" is not doing any operationcs)
# 3*t_fetch + t_[] + t_store
# 2*t_fetch + t_- + t_store

# (n + 1) * ( 2 * t_fetch + t_> )
# (n) * (2*t_fetch + t_* + 3*t_fetch + t_[] + t_+ + t_store)
# (n) * (2*t_fetch + t_- + t_store)
# t_return + t_fetch


# Analyze performance of a factorial

def factorial(n)
  if n == 0  # t_fetch + t_fetch + t_>
    return 1 # t_return + t_fetch
  else
    return n * factorial(n - 1)  # n * (t_return + t_fetch + t_* + t_call + t_fetch + t_- + t_fetch)
  end
end

# For n == 0:

# 2 * t_fetch + t_>
# t_fetch + t_return

# for n > 0:

# 2 * t_fetch + t_> (because this condition still must be tested)
# 3 * t_fetch + t_call + t_- + t_* + t_return + T(n - 1)



