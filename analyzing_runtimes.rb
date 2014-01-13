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

p "factorial: #{factorial(5)}"

# For n == 0:

# 2 * t_fetch + t_>
# t_fetch + t_return

# for n > 0:

# 2 * t_fetch + t_> (because this condition still must be tested)
# 3 * t_fetch + t_call + t_- + t_* + t_return + T(n - 1)

def find_maximum(a, n)
  result = a[0]
  i = 1
  while i < n
    if a[i] > result
      result = a[i]
    end
    i += 1
  end
  return result
end

# Analysis:

# t_[] + 3*t_fetch + t_store
# t_fetch + t_store
# n * (2 * t_fetch + t_<)
  # (n - 1) * (4 * t_fetch + t_[] + t_<)
  # max -> (n - 1) * (3 * t_fetch + t_[] + t_store) average probability of this needing to execute is represented by harmonic series
  # (n - 1) * (t_+ + 2*t_fetch + t_store)

  #t_return + t_fetch  ### Correction: t_return should be t_fetch


def geometric_series(x, n)
  sum = 0
  i = 0
  while i <= n
    prod = 1
    j = 0
    while j < i
      prod *= x
      j += 1
    end
    sum += prod
    i += 1
  end
  puts i
  puts j
  return sum
end

p "geometric series: #{geometric_series(2, 5)}"

# 2
# 2
# (n + 2) * 3
# (n + 1) * 2
# 2 * (n + 1) * 3
# (n + 1) * 4
# (n + 1) * 4
# (n + 1) * 4
# (n + 1) * 4
# 2

def geometric_series_sum(x, n)
  sum = 0
  i = 0
  while i <= n
    sum = sum * x + 1
    i += 1
  end
  return sum
end

# 2
# 2
# (n + 2) * 3
# (n + 1) * 6
# (n + 1) * 4
# 2

