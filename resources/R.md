# R

This article looks at the syntax (and semantics) of R as a programming language.
The ultimate reference is [R Language Definition](https://cran.r-project.org/doc/manuals/r-release/R-lang.html)

> To understand computations in R, two slogans are helpful:
>   Everything that exists is an object.
>   Everything that happens is a function call.
> — John Chambers

R programming style: interpreted, functional programming, vectorized functions.


## Syntax

Symbols:

- No semicolon `;` needed.
  - R is smart enough to handle line continuation, such as open operator and parenthesis.
  - One potential use of semicolon `;` is to separate two statements on the same line.
- Quotes: String literals are double quoted `"` in default; single quotes `'` are also accepted.

Reserved words:

1. Constants: `NULL`, `NA`, `NA_integer_`, `NA_real_`, `NA_complex_`, `NA_character_`, `NaN`, `Inf`, `TRUE`, `FALSE`.
1. Function definition: `function`, `...`, and `..1,`, `..2`, etc.
1. Control flows: `if`, `else`; `for`, `in`, `while`, `repeat`, `next`, `break`.

Identifiers:

- Syntactic names have pattern `[a-zA-Z][a-zA-Z0-9._]*` and can be used as-is.
  - Identifiers with a leading dot `.` are hidden, but the second character cannot a digit.
- Non-syntactic names shall be quoted in back-ticks (\x60) and take any character.
  - Single or double quotes may also work, as a character constant will often be converted to a name.

### Functions

Function expression: `function() {}`

- Formal arguments are comma separated names, optional assigned with default values or expressions.
- `...` passes on unmatched arguments, often used in S3 generics; `..n`, refers to the n-th unmatched argument.
- `missing()` determines if a formal argument is supplied or not.
- `force()`, force evaluation of a formal argument.
- You can choose to return early by using `return()`.
- `invisible()` objects are not printed by default.

Function names are object names, so they shall not conflict with names bound to other objects.

Functions bound to special names have additional call syntax:

1. **Infix functions** (operators): a syntactic sugar for calling a binary function where function name is put in between the arguments, e.g. `1+5` is implemented as '\`+\`(1, 5)'.
  - Syntactic operators:
    - `~`, `:`, `::`, `:::`, `[`, `[[`, `$`, `@`;
    - `^`, `*`, `/`, `+`, `-`;
    - `>`, `>=`, `<`, `<=`, `==`, `!=`, `!`, `&`, `&&`, `|`, `||`;
    - `<-`, `<<-`, `=`, `->`, `->>`.
  - Special binary operators: Users can call a function as an infix by naming it with enclosing '%'s.
    - `%%`, `%*%`, `%/%`, `%o%`, `%x%`, `%in%`.
    - The pipe operators in `magrittr`, Hadley's fallback operator `%||%`.
1. **Replacement functions** (replacement form of a function): simulates modification of mutable objects, e.g. `class(x) <- "Date"` is implemented as 'x <- \`class<-\`(x, "Date")'.

Numerical operators:

- `+`, `-`, `*`, `/`, arithmetics (component-wise).
- `^` and `**`, power.
- `%%`, `%/%`, modulo and integer division (component-wise).
- `%*%`, matrix multiplication.
- `%o%`, `%x%`, outer and Kronecker product of arrays (`outer()`,`kronecker()`).

Logical operators:

- logic AND: `&` (component-wise) and `&&` (single value).
- logic OR: `|` (component-wise) and `||` (single value).
- logic NOT: `!` (component-wise).
- logic XOR: `xor()`.
- `==`, `!=`, `<`, `>`, `<=`, `>=`, comparisons.
- `%in%`, value matching (`match()`).

Extraction operators:

- subsetting operator: `[`;
- recursive selector: `[[` (name and position), `$` (name only, unquoted, partial matching);
- slot extraction operator: `@` (equivalent to `$`);

Assignment operators:

- Assignment: `<-`, `=` (only for top level code).
- Superassignment: `<<-` (to enclosing environment).
- Rightward assignments: `->`, `->>`.

Other operators:

- `:`, integer sequence operator, factor interaction operator.
- `::` (exported) and `:::` (internal), package namespace access.
- '~', formula separator.
- `$`, RC method call operator.

*WARNING*: All operators can be overridden, but be careful when you use special names for functions.

### Statements

You should never need to perform explicit looping except for: modification in place (stateful), recursive functions (stateful), while loops (simulations).

- Compound statements are be grouped inside curly brackets `{}`.
- Control Flows: (functions as keywords)
  - Conditional: `if() {} else if() {} else {}`, `ifelse()`, `switch()`;
  - Loop: `for(var in sequence) {}`, `while() {}`, `repeat {}`, `break`, `next`;
- Comments: line comment `#`.


## Object Types

Common R object types: vectors, functions, environment, language.

Objects are immutable, implemented as [copy-on-write](https://en.wikipedia.org/wiki/Immutable_object#Copy-on-write), except for environments and (perhaps) some primitive replacement forms.

In R, parsed expressions represent every elementary expression as a function call, including all R syntactic elements such as the assignment operators and subsetting operators.
For example, recursive selector `[[` used as `l[[3]]` will be parsed as '\`[[\`(l, 3)'; the back brackets `]]` are simply syntactical.
`(` evaluates one expression and return visibly.
`{` evaluates a sequence of expressions and returns the value of the last, preserving visibility.

Beyond its components, an object has three properties (metadata): **length** (`length()`), **type** (`typeof()`), and **attributes** (`attributes()`).
Not all types of R objects can have length greater than one, e.g. functions ("builtin", "special", "closure").
Attributes is a named list associating arbitrary metadata to an object.


## Vectors

A **vector** is a one dimensional object consisting of various **components**.
R does not actually have "scalars"; the most elementary object is an atomic vector of length 1.

### Vector types

A vector is **atomic** if all its components are of the same atomic type (homogeneous); otherwise it is **recursive**, with type "list".

1. Atomic vectors have atomic types:
  1. "NULL": `NULL`;
  1. "raw": bytes (hex) `0a`;
  1. "logical": Booleans (`TRUE`, `T`, `FALSE`, `F`), missing value `NA`;
  1. "integer" (4B): `1L`, `NA_integer_`;
  1. "double" (8B): `1`, `Inf`, `NaN`, `NA_real_`;
  1. "complex" (16B): `1i`, `NA_complex_`;
  1. "character": `'a'`, `"a"`, `NA_character_`;
1. Recursive vectors are of type "list".
  1. "expression": a list of calls, "symbol"s, "pairlist"s, etc.

**Atomic types** in R are adopted from C.
A **list** is an ordered collection of objects with arbitrary types.
An **expression** behaves much like a list and shall be thought of as so.

Coercion rule:
NULL < raw < logical < integer < double < complex < character < list < expression.

### Vector attributes

The "names" attribute (`names()`) associate each component of a vector with a name, which is useful for component extraction.

The "dim" attribute (`dim()`) assume dimensions to a vector (including list), with `class()` **matrix** or **array** inferred from the number of dimensions (`length(dim())`).

The "class" attribute (`class()`) is used to build on additional behavior.
Vectors that do not have a class are called **base type** objects.

Vector-based S3 classes in base R ("augmented vectors" in Hadley's words):

1. Atomic vector: "ts".
  1. Integer vectors: "factor".
  1. Double vectors: "Date", "POSIXct", "difftime".
1. List: "POSIXlt", "data.frame".

Time-series **ts** are atomic vectors typically sampled at equal-spaced points in time, with an attribute for start and end times and frequency (`tsp()`).
A **factor** is an integer vector with a levels attribute (`levels()`) which is a character vector.
The levels act as a mapping between its indices and string values, like a compact dictionary.
A **data.frame** is a named list of equal-row vectors with unique row names (`row.names()`); duplicate (column) names are allowed but not recommended.
`data.frame()` converts character vectors to factors in default (`options()$stringAsFactors`).

### Extraction

Subsetting objects:

1. by integer index (positive for selection, negative for exclusion, zero for a zero-length vector): `x[i]`.
  - Multi-dimensional index (matrix, array): `a[i, j, k]`.
  - Index matrix (matrix, array): `m[cbind(i, j)]`.
  - Non-integer indices are truncated: `letters[pi]`.
  - Indexing by factor is equivalent to indexing by its integer codes.
1. by logical value (`TRUE` for selection, `FALSE` for exclusion): `x[c(T, F, T)]`.
1. by character name (if components have names): `x['name']`.
1. Empty index selects all values: `x[]`.
  - Assignment to empty index preserves all properties/metadata of the object.
  - Empty index in one dimension selects ALL values in that dimension (matrix, array): `m[i,]`.
1. A missing value in the index always yields a missing value in the output.

Simplifying while subsetting:

1. Subsetting by any non-empty index will drop all attributes except "names", "dim" and "dimnames".
1. Dimensions of size one will be deleted.
1. The above behavior are controlled by the `drop` argument which defaults to `TRUE`.
1. S3 and S4 classes can override the above standard behavior.
  - Factor and data.frame will preserve their class and related attributes.
  - Factor defaults to `drop = FALSE`, otherwise unused levels will be deleted and components remapped.

Recursively selecting a single component from an object:
(names are dropped.)

1. by integer index: `l[[i]]`.
  - recursion: `l[[i]][[j]]` is equivalent to `l[[c(i, j)]]`.
1. by character name: `l[['name']]` (partial matching option available), `l$name` (partial matching allowed, no computed indices).
  - recursion: `l$a$b` is equivalent to `l[[c('a', 'b')]]`.

Exact matching in recursive selection can be turn off with argument `exact = FALSE`.


## Function

Overview of function semantics:

1. Functions as keywords. (Memorizing function names is an important part of being fluent in R.)
1. Lazy evaluation (aka call by need): Arguments are not evaluated until needed.
1. Lexical scoping.†

† (Dynamic scoping is also used in select functions to save typing during interactive analysis.)

Function types: (`typeof()`)

1. primitive/internal functions:
  1. "special", a internal function that does not evaluate its arguments;
  1. "builtin", a internal function that evaluates its arguments;
1. "closure", a function;

Primitive functions consist of a single `.Primitive()` call to C code.
Internal functions call `.Internal()`.

Because R has no scalars, most built-in functions are vectorized: they operate on vectors of arbitrary length, unless they do argument checking.

The **formal arguments** are a property of the function, whereas the **actual arguments** can vary each time you call the function.

Argument mapping from actual arguments to formal arguments:

- Arguments are matched first by exact name, then by prefix matching (if unambiguous), and finally by position.
- Generally, you only want to use positional matching for the first few arguments that are obvious given the function name.
- Named arguments should always come after unnamed arguments.
- Only use sensible abbreviations in partial matching.

The actual arguments are evaluated in the calling environment; the argument defaults are evaluated in the execution environment.
Lazy evaluation of the actual arguments are implemented via **promises**, a data structure that contains the expression of the actual argument, a pointer to the calling environment, and the resulting value once evaluated.
The expression of a promise can contain formal arguments bound to unevaluated promises, and thus the evaluation of a promise can be recursive.
Promises are used consistently for all formal arguments with or without actual arguments.
You cannot get information about a promise in pure R without evaluating it, but you can use `pryr::promise_info()`.

**Recycling rule**: when operating on vectors of different length, R will expand the shorter vector to the same length as the longer.
This is silent unless the length of the longer is not an integer multiple of the length of the shorter.
The recycling rule is recommended only when the shorter vector has length 1.


## Environment

**Environment** is a data structure consisting of a **frame** which contains name-object bindings, and a pointer to an **enclosing environment** (aka **enclosure**) which is passed on for name search under inheritance.

Frame behaves much like named list: a **binding** associates a name with an object in memory; you may see them by coercing an environment object `as.list()`.
Environments have **reference semantics**: bindings are modified in place.
The data structure of environment defines a **chain of enclosures** for a name:
when a name search fails in an environment and inheritance is enabled, the frame of this environment's enclosure (`parent.env()`) is searched;
this process is repeated until reaching the empty environment.

The global, base and empty environments may be referred to as **system environments**:

- The **empty environment** `emptyenv()` is empty: no frame or enclosing environment.
  It is the only environment with no enclosing environment.
- The **base environment** `baseenv()` is the package environment of the `base` package.
- The **global environment** `globalenv()` or `.GlobalEnv` is the environment of an interactive session, colloquially known as the user's workspace.

Two environments associated with a package:

1. The **package environment** contains bindings to all exported functions of a package and is placed on the search path. (`.packages()` invisibly returns names of attached packages.)
1. The **namespace environment** or **namespace** encloses and binds all functions defined in a package, whose own enclosure is a special **imports environment** which contains bindings to all the functions the package imports.

Most environments are created as a consequence of using functions.
There are four types of environment associated with a function:

1. The **enclosing environment** (`environment()`) of a function is initiated as the environment where the function was created, and may be subsequently changed.
1. A **binding environment** of a function is an environment with a binding to the function.
1. A **calling environment** (`parent.frame()`) of a function is the environment of a caller of a function.
1. An **execution environment** of a function is an ephemeral environment that stores name bindings created during function execution.

To avoid confusion, it is best to never use 'parent' when referring to an environment.

The chain of enclosures for an exported function of a package: (top-down order)

1. Empty environment `emptyenv()`;
1. Search path `search()`: all attached packages and objects; newcomer gets appended.
  1. Base package environment `baseenv()`;
  1. Autoload environment `.AutoloadEnv`: loads package objects when needed.
  1. package environment of other built-in packages (names: 'package:');
  1. other package environments and objects attached (e.g. 'tools:rstudio');
1. Global environment `globalenv()`, `.GlobalEnv`;
1. Base namespace environment `.BaseNamespaceEnv` ('namespace:base');
1. Imports environment: ('imports:pkgname');
1. Namespace environment: ('namespace:pkgname');

![](namespace.png)

Figure: The chain of enclosures illustrated with `stats::sd()`.

Environment as a data structure is useful for three common issues:

1. Avoiding copies of large data. (This use case is substantially reduced by efficient vector reuse since R 3.1.0.)
1. Managing state within a package.
1. Simulate a hashmap: efficiently looking up values from names.


## Formula

In R, statistical models can be specified as a compact symbolic expression `response ~ model`, which evaluates to an object of S3 class "formula".

The `model` consists of numeric variables and factors (dummy variables) connected by:

- `+`, linear combination;
- `:`, interaction;
- `*`, factor crossing (linear combination and interaction);
- `^`, factor crossing to the specified degree;
- `%in%` and `/`, nesting (different orders; A/B == A + A:B);
- `-`, removal (The intercept can be removed with either `- 1` or `+ 0`).
- `|`, conditioning (`Lattice`);

Arithmetic expression is also allowed in `model` and `response`.
`I()` preserves the arithmetic meaning of an operator in case of confusion.
