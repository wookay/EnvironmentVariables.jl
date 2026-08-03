# module EnvironmentVariables

# from julia/doc/src/manual/environment-variables.md

Core.eval(Docs, quote

export JULIA_TEST_VERBOSE

"""
### CI Debug Environment Variables

Julia automatically enables verbose debugging options when certain continuous integration (CI) debug environment variables are set. This improves the debugging experience when CI jobs are re-run with debug logging enabled, by automatically:

- Enabling `--trace-eval` (location mode) to show expressions being evaluated
- Setting `JULIA_TEST_VERBOSE=true` to enable verbose test output

This allows developers to get detailed debugging information from CI runs without modifying their scripts or workflow files.
"""
const JULIA_TEST_VERBOSE = EnvKeyString("JULIA_TEST_VERBOSE")

end) # Core.eval

# module EnvironmentVariables
