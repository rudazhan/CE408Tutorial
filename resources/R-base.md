# R Base

The R distribution comes with several base packages.
They are maintained by the R Core Team [in the same Subversion tree with R](https://svn.r-project.org/R/trunk/src/library/).
[R FAQ](https://cran.r-project.org/doc/FAQ/R-FAQ.html#Add_002don-packages-in-R) has an overview of these packages.

Some of these base packages are attached at R initiation:
`base`, `methods`, `datasets`, `utils`, `grDevices`, `graphics`, `stats`.
(Start a new R session and run `grep('package:', search(), value = TRUE)`.)

The `base`, `utils`, `stats` packages are particularly important in mastering R.
This article lists functions in these packages that constitute a good working vocabulary of base R.


## The Base `base`

Package `base` provides the defining functions of R the programming language.
It includes arithmetic, input/output, basic programming support, etc.

Variables:

- `R.version`, version information about the running R session.
- `letters`, `LETTERS`, `month.abb`, `month.name`, `pi`, built-in constants.

R session:

- `options()`, access global R options.
- `q()`, `quit()`, quit an R session.

System functionality:

- `Sys.getenv()`, `Sys.setenv()`, get/set environment variables.
- `getwd()`, `setwd()`, get/set working directory.
- `dir()`, list the files in a directory.
- `dir.create()`, create a path.
- `dirname()`, `basename()`, extract leading directories or filename of a path.
- `file.path()`, `path.expand()`, `normalizePath()`, construct/expand/normalize paths.
- `file.choose()`, `file.exists()`, `file.info()`, `file.create()`, `file.copy()`, `file.remove()`, `file.rename()`, file operations.
- `tempdir()`, `tempfile()`, create names for temporary files.
- `readLines()`, `writeLines()`, text lines I/O via a connection.
- `readRDS()`, `saveRDS()`, I/O interface for a single R object.

Environment operation:

- Read: `ls()` and `objects()`, list names in an environment; `exists()`, check if a name is defined; `get()`, get value with a name.
- Write: `assign()`, bind value to a name; `rm()` and `remove()`, remove objects.
- Meta: `parent.env()`, the enclosure; `environmentName()`, the environment name; `env.profile()` overviews the hash table of an environment, if it uses one.
- Search path: `attach()`, `detach()`, create an environment out of an object and attach to the search path.
- Namespace: `getNamespace()`, namespace environment; `getNamespaceExports()`, exported names; `getNamespaceInfo()`, arbitrary info.
- Function: `environment()`, access the enclosure of a function, defaults to the current environment; `parent.frame()`, the calling environment.
- Virtual: `with()`, create an environment enclosed by the calling environment, evaluate expressions; `list2env()`, convert/add a list to an environment.

Objects:

- `attributes()`, `attr()`, access all attributes or a specific attribute of an object.
- `structure()`, add attributes to an object. (pure function)
- `names()`, access the "names" attribute of an object.
- `setNames()`, set names to an object. (pure function)
- `unname()`, copy an object except its names. (pure function)
- `dim()`, access dimensions of an object.
- `nrow()`, `ncol()`, get the number of rows (first dimension) or columns (second dimension) in a data.frame or array.
- `dimnames()`, `rownames()`, `colnames()`, access dimension names of an object.
- `class()`, access an object's class.
- `inherits()`, test an object's class.
- `unclass()`, return an object without the "class" attribute.
- `summary()`, summarize an object.
- `I()`, prepend object "class" with "AsIs".
- `cat()`, concatenate and print objects.
- `print()`, print objects and return it invisibly; automatically called when you enter a name on the console.
- `invisible()`, return an invisible copy of an object, often used on function return values.
- `format()`, format object for pretty printing.
- `save()`, save R objects in a file.
- `load()`, reload saved datasets. (see `utils::data()`)
- `dput()`, write an object to a file.
- `sink()`,  send output to a file.

Predicate/logical functions:

- `all.equal()`, test if objects are nearly equal.
- `identical()`, test if objects are exactly equal.
- `all()`, `any()`, n-ary logical conjunction/disjunction.
- `which()`, index (matrix) of TRUE values.
- `match()`, positions elements first matched in a table.

Debug:

- `stop()`, `warning()`, `message()`, throw error, warning, or diagnostic message.
- `stopifnot()`, evaluate logical expressions and throw error on first FALSE; useful in regression tests and argument checking in functions.
- `try()`, `tryCatch()`, catch errors or custom handlers and recover.
- `traceback()`, print call stacks of the last uncaught error.
- `browser()`, inspect the current environment interactively: `n`, execute the next command; `s`, step into the next function; `f`, finish the current loop or function; `c`, continue execution normally; `Q`, stop the function and return to the console.

### Data Types

Vector:

- `typeof()`, object base type.
- `length()`, object length.
- `c()`, combine values into a vector; coercion rule applies.
- `seq()`, `seq_len()`, `seq_along()`, generate regular sequences.
- `rep()`, `rep_len()`, replicate elements of vectors and lists.
- `rev()`, reverse elements.
- `order()`, `rank()`, `sort()`, sorting.
- `intersect()`, `union()`, `setdiff()`, `setequal()`, set operations on vectors.
- `duplicated()`, `unique()`, determine/remove duplicated elements.
- `sample()`, sample from a vector.
- `split()`, split a vector into a list of vectors using a factor.
- `expand.grid()`, create product set of one dimensional objects as a data.frame.
- `table()`, compute contingency table (frequency counts).
- `rle()`, run length encoding.

Numeric:

- `abs()`, absolute value.
- `sqrt()`, principal square root.
- `exp()`, `log()`, `log10()`, `log2()`, logarithms and exponentials.
- `cos()`, `sin()`, `tan()`, `acos()`, `asin()`, `atan()`, `atan2()`, trigonometric functions.
- `ceiling()`, `floor()`, `round()`, `signif()`, `trunc()`, rounding of numbers.
- `sign()`, sign function.
- `range()`, extremes.
- `max()`, `min()`, `mean()`, `prod()`, `sum()`, summary functions.
- `pmax()`, `pmin()`, point-wise maxima or minima.
- `cummax()`, `cummin()`, `cumprod()`, `cumsum()`, cumulative functions.
- `diff()`, lagged and iterated differences.
- `choose()`, `factorial()`, special math functions: combination and factorial.

Factor:

- `levels()`, `nlevels()`, show the (number of) "levels" of an object.
- `cut()`, `findInterval()`, discretize a numeric vector by cut points.
- `interaction()`, compute factor interactions (joint levels).

Array/Matrix/data.frame:


- `cbind()`, `rbind()`, combine objects into a matrix/data.frame by column or row.
- `merge()`, merge two data frames.
- `subset()`, subset observations and variables.
- `t()`, transpose a matrix or data.frame.
- `aperm()`, permute an array.
- `diag()`, diagonal matrix.
- `crossprod()`, `tcrossprod()`, matrix crossproduct.
- `eigen()`, `qr()`, `svd()`, matrix decompositions.
- `rcond()`, approximately compute the reciprocal condition number.
- `solve()`, solve a system of equations.
- `sweep()`, apply a summary statistic on an array, default to subtraction.
- `transform()`, transform a data.frame. (like `dplyr::mutate`)

Character:

- `nchar()`, count number of characters.
- `paste()`, `paste0()`, concatenate vectors as character (with zero padding).
- `tolower()`, `toupper()`, `chartr()`, translate characters.
- `substr()`, access substrings of a character vector by position.
- `strsplit()`, split a character vector into a list of substring vectors.
- `grep()`, `agrep()`, index/value of (approximate) string pattern matches.
- `regexpr()`, `gregexpr()`, position and length of (global) string pattern matches.
- `sub()`, `gsub()`, substitute (global) string pattern matches.

List:

- `unlist()`, recursively unpack a list to an atomic vector; coercion rule applies.

Date and date-time classes:

1. **Date**, calendar dates, number of days since 1970-01-01 UTC.
1. **POSIXt**, a virtual class for POSIX date-time.
  1. **POSIXct**, POSIX calendar time, number of seconds since 1970-01-01 UTC.
  1. **POSIXlt**, POSIX local time.
    - list components: 'sec', 'min', 'hour', 'mday' (day of month), 'mon', 'year' (years since 1900), 'wday' (day of week), 'yday' (day of year), 'isdst' (daylight-saving time)
    - attributes: "tzone" (timezone)
1. **difftime**, time difference with a "units" attribute.

Date and date-time functions:

- Coercion functions: `as.Date()`, `as.POSIXct()`, `as.POSIXlt()`.
- Extraction: `weekdays()`, `quarters()`, `months()`, `julian()` (days since some origin).
- Encoding:
  - `strptime()`, parse string to "POSIXlt" objects.
  - `ISOdate()`, `ISOdatetime()`, create "POSIXct" objects from numeric values.
- Formatting:
  - `strftime()`, format "POSIXlt" and "POSIXct" objects to string.
  - `date()`, `Sys.Date()`, `Sys.time()`, print/get current date or date-time.

### Functional Programming

Function as object:

- `formals()`, `body()`, access the formal arguments and body of a function.
- `environment()`, access the enclosure of a function ("closure").

Functions as keywords:

- `function() {}`, define a function.
- `missing()`, test unaltered name.
- `force()`, force evaluation of a formal argument: `function(x) x`.
- `return()`, explicitly return values.
- `on.exit()`, function exit code, useful for undoing side effects.

Functionals:

- `replicate()`, repeatedly evaluate an expression.
- `apply()`, apply a function to margins of a matrix/array.
- `lapply()`, `sapply()` (recommended only for interactive use), `vapply()`, apply a function to a list (and simplify) or a vector.
- `tapply()`, apply a function to vector grouped by types (a combination of `split()` and `sapply()`).
- `Map()`, `mapply()` (unrecommended), iterate a function over multiple input data structures (and simplify).
- `Reduce()`, reduces a vector to a single value by recursively calling a two-argument function.
- `Filter()`, selects only elements that match a predicate.

Function operators:

- `Vectorize()`, parallelize a function with respect to the arguments specified.
- `Negate()`, negate a predicate function.

## Utilities `utils`

- `?` or `help()`, show documentation on a name.
- `??` or `help.search()`, search documentation.
- `apropos()`, `find()`, find objects by (partial) name.
- `RSiteSearch()`, search site http://search.r-project.org for key words or phrases in documentation.
- `example()`, `demo()`, run examples code or demo script.
- `browseVignettes()`, see vignettes of a package.
- `vignette()`, read a specific vignette.
- `citation()`, cite R and R packages in publications.

`install.packages()`, install packages.
`download.file()`, download a file from the Internet.
`Sweave()`, automatic report generation.

`recover()`, browse on a currently active function call.
`capture.output()`, send output to a character string or file.

`str()`, compactly display the structure of an object.
`head()`, `tail()`, truncated view of an object.
`combn()`, generate all combinations from a vector.

(obsolete) `data()`, load data sets; defaults to list the available data sets. [This function was designed to avoid having large data sets in memory when not in use, which has been almost entirely superseded by lazy-loading of data sets.]
`count.fields()`, count the number of fields per line.
`read.csv()`, `write.csv()`, `read.delim()`, `write.delim()`, tabular data I/O.
`read.fwf()`, read fixed width format files.

`methods()`, list all S3 and S4 methods associated with a generic function or class.
`getS3method()`, get a method for an S3 generic.

## Statistical Models `stats`

Mathematical functionals:

- `integrate()`, numerical integration.
- `uniroot()`, find a root of a univariate function within an interval.
- `optimize()`, `optim()`, find the optimal point of a univariate/multivariate function.

Statistics:

- `median()`, `quantile()`, `sd()`, `var()`, `cor()`, summary statistics.
- `runmed()`, `smooth()`, running medians.
- `ftable()`, compute flat contingency table.

Data Prep:

- `complete.cases()`, check observations without missing values (across a sequence).
- `reorder()`, `relevel()`, reorder levels of a factor.
- `contrasts()`, access contrast matrix.

Model Specification/Family:

- `lm()`, `glm()`, (generalized) linear model.
- `nls()`, nonlinear models.
- `loess()`, local fitting.

Fitted models:

- `formula()`, extract model form.
- `coefficients()`, `confint()`, extract fitted model coefficients and confidence intervals.
- `fitted()`, `resid()`, extract model fitted values and residuals.
- `predict()`, make predictions with model.
- `anova()`, `df.residual()`, `deviance()`, `logLik()`, extract analysis of variance table, residual degree of freedom, model deviance, and log-likelihood.
- `vcov()`, compute variance-covariance matrix.

Model diagnostics:

- `influence.measures()`, compute regression influence measures: DFBETAS for each model variable, DFFITS, covariance ratios, Cook's distances and the diagonal elements of the hat matrix. {Belsley, Kuh and Welsch (1980)}, {Cook and Weisberg (1982)}.
- `rstandard()`, compute standardized residuals.
- `hatvalues()`, compute hat values.

Statistical distribution functions:

1. prefixes:
  - `r-`, random number generator;
  - `d-`, density function; `p-`, distribution function; `q-`, quantile function;
1. parametric probabilistic models:
  - from discrete process:  `binom`, `nbinom`, `geom`, `hyper`; `multinom`; `beta`;
  - from continuous process: `unif`; `pois`, `exp`, `gamma`;
  - from asymptotic process: `norm`, `chisq`, `t`, `cauchy`, `f`, `tukey`; `lnorm`; `weibull`;
  - other distributions: `logis`; `wilcox`, `signrank`;
  - `birthday`, birthday paradox;


## Example Datasets `datasets`

- 'airquality', New York Air Quality Measurements.
- 'faithful', Old Faithful Geyser Data.
- 'iris', Edgar Anderson's Iris Data.
- 'mtcars', Motor Trend Car Road Tests.
- 'presidents', Quarterly Approval Ratings of US Presidents.
- 'warpbreaks', The Number of Breaks in Yarn during Weaving.


## Base graphics `graphics`

You might have seen these functions from `graphics`: `plot()`, `lines()`, `hist()`.
They look ugly, you know it.
