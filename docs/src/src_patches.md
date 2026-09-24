```@raw html
<!-- generated -->
```

# src/ cli/ ENV variables

```@contents
Pages = ["src_patches.md"]
Depth = 2:3
```

```@index
Pages = ["src_patches.md"]
```

## src/

### `1.14.0-DEV.2614 JULIA_OBJCACHE_CAPACITY, JULIA_OBJCACHE, JULIA_OBJCACHE_LOG, JULIA_OBJCACHE_PATH`

**src/objcache.cpp**$~~~~~~~~~~~$ ( julia commit [6aa38364cb](https://github.com/JuliaLang/julia/commit/6aa38364cb) )

  * ```
    JULIA_OBJCACHE_CAPACITY
    ```

  * ```
    JULIA_OBJCACHE
    ```

  * ```
    JULIA_OBJCACHE_LOG
    ```

  * ```
    JULIA_OBJCACHE_PATH
    ```

### `1.14.0-DEV.2582 MMTK_MIN_HSIZE, MMTK_MIN_HSIZE_G, MMTK_MAX_HSIZE, MMTK_MAX_HSIZE_G`

**src/gc-mmtk/gc-mmtk.c**$~~~~~~~~~~~$ ( julia commit [a6cf20fa5d](https://github.com/JuliaLang/julia/commit/a6cf20fa5d) )

  * ```
    MMTK_MIN_HSIZE
    ```

  * ```
    MMTK_MIN_HSIZE_G
    ```

  * ```
    MMTK_MAX_HSIZE
    ```

  * ```
    MMTK_MAX_HSIZE_G
    ```

### `1.14.0-DEV.2425 JULIA_PRECOMPILE_JOBSERVER`

**src/aotcompile.cpp**$~~~~~~~~~~~$ ( julia commit [e319a303a7](https://github.com/JuliaLang/julia/commit/e319a303a7) )

  * ```
    JULIA_PRECOMPILE_JOBSERVER
    ```

### `1.14.0-DEV.2313 JULIA_ASAN_COMPAT, JULIA_USE_RTLD_DEEPBIND`

**src/dlload.c**$~~~~~~~~~~~$ ( julia commit [acaea7226f](https://github.com/JuliaLang/julia/commit/acaea7226f) )

  * ```
    JULIA_ASAN_COMPAT
    ```

  * ```
    JULIA_USE_RTLD_DEEPBIND
    ```

### `1.14.0-DEV.2037 JULIA_DEBUG`

**src/processor.cpp**$~~~~~~~~~~~$ ( julia commit [d5c76d6dcb](https://github.com/JuliaLang/julia/commit/d5c76d6dcb) )

  * ```
    JULIA_DEBUG
    ```

### `1.12.0-DEV.1578 JULIA_HEAP_SIZE_HINT`

**src/gc-stock.c**$~~~~~~~~~~~$ ( julia commit [f336314762](https://github.com/JuliaLang/julia/commit/f336314762) )

  * ```
    JULIA_HEAP_SIZE_HINT
    ```

### `1.11.0-DEV.1076 JULIA_THREAD_SLEEP_THRESHOLD`

**src/scheduler.c**$~~~~~~~~~~~$ ( julia commit [bb2822275b](https://github.com/JuliaLang/julia/commit/bb2822275b) )

  * ```
    JULIA_THREAD_SLEEP_THRESHOLD
    ```

### `1.10.0-DEV.1147 JULIA_NUM_GC_THREADS`

**src/threading.c**$~~~~~~~~~~~$ ( julia commit [abeecee71c](https://github.com/JuliaLang/julia/commit/abeecee71c) )

  * ```
    JULIA_NUM_GC_THREADS
    ```

### `1.10.0-DEV.964 JULIA_WAIT_FOR_TRACY`

**src/jlapi.c**$~~~~~~~~~~~$ ( julia commit [8e0cba5663](https://github.com/JuliaLang/julia/commit/8e0cba5663) )

  * ```
    JULIA_WAIT_FOR_TRACY
    ```

### `1.10.0-DEV.964 JULIA_TIMING_SUBSYSTEMS, JULIA_TIMING_METADATA_PRINT_LIMIT`

**src/timing.c**$~~~~~~~~~~~$ ( julia commit [8e0cba5663](https://github.com/JuliaLang/julia/commit/8e0cba5663) )

  * ```
    JULIA_TIMING_SUBSYSTEMS
    ```

  * ```
    JULIA_TIMING_METADATA_PRINT_LIMIT
    ```

### `1.10.0-DEV.716 JULIA_IMAGE_TIMINGS`

**src/aotcompile.cpp**$~~~~~~~~~~~$ ( julia commit [4e35f416bb](https://github.com/JuliaLang/julia/commit/4e35f416bb) )

  * ```
    JULIA_IMAGE_TIMINGS
    ```

### `1.10.0-DEV.715 JULIA_CPU_THREADS`

**src/aotcompile.cpp**$~~~~~~~~~~~$ ( julia commit [8cf48f2369](https://github.com/JuliaLang/julia/commit/8cf48f2369) )

  * ```
    JULIA_CPU_THREADS
    ```

### `1.10.0-DEV.703 JULIA_IMAGE_THREADS`

**src/aotcompile.cpp**$~~~~~~~~~~~$ ( julia commit [3915101dc6](https://github.com/JuliaLang/julia/commit/3915101dc6) )

  * ```
    JULIA_IMAGE_THREADS
    ```

### `1.8.0-DEV.661 ENABLE_GDBLISTENER`

**src/codegen.cpp**$~~~~~~~~~~~$ ( julia commit [628209c1f2](https://github.com/JuliaLang/julia/commit/628209c1f2) )

  * ```
    ENABLE_GDBLISTENER
    ```

### `1.3.0-alpha.120 JULIA_COPY_STACKS`

**src/task.c**$~~~~~~~~~~~$ ( julia commit [ae4e08c558](https://github.com/JuliaLang/julia/commit/ae4e08c558) )

  * ```
    JULIA_COPY_STACKS
    ```

### `0.7.0-DEV.2999 JULIA_BINDIR`

**src/jlapi.c**$~~~~~~~~~~~$ ( julia commit [6885af8c94](https://github.com/JuliaLang/julia/commit/6885af8c94) )

  * ```
    JULIA_BINDIR
    ```

### `0.4.0-dev+2635 JULIA_NUM_THREADS, JULIA_EXCLUSIVE`

**src/threading.c**$~~~~~~~~~~~$ ( julia commit [5cdc03b31b](https://github.com/JuliaLang/julia/commit/5cdc03b31b) )

  * ```
    JULIA_NUM_THREADS
    ```

  * ```
    JULIA_EXCLUSIVE
    ```

### `0.4.0-dev+2494 JULIA_GC_WAIT_FOR_DEBUGGER`

**src/gc-debug.c**$~~~~~~~~~~~$ ( julia commit [b60e7306d3](https://github.com/JuliaLang/julia/commit/b60e7306d3) )

  * ```
    JULIA_GC_WAIT_FOR_DEBUGGER
    ```

### `0.2.0-rc1+50 ENABLE_JITPROFILING`

**src/codegen.cpp**$~~~~~~~~~~~$ ( julia commit [a13bce29ae](https://github.com/JuliaLang/julia/commit/a13bce29ae) )

  * ```
    ENABLE_JITPROFILING
    ```

## cli/

### `1.14.0-DEV.2836 JULIA_LOAD_CODEGEN_LIB`

**cli/loader_lib.c**$~~~~~~~~~~~$ ( julia commit [efbb50fdff](https://github.com/JuliaLang/julia/commit/efbb50fdff) )

  * ```
    JULIA_LOAD_CODEGEN_LIB
    ```

### `1.9.0-DEV.1779 JULIA_PROBE_LIBSTDCXX`

**cli/loader_lib.c**$~~~~~~~~~~~$ ( julia commit [eb708d62f8](https://github.com/JuliaLang/julia/commit/eb708d62f8) )

  * ```
    JULIA_PROBE_LIBSTDCXX
    ```
