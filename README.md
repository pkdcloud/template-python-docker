# Python Docker Template

This project provides a template for creating, formatting, linting, testing, sast scanning and publishing Python applications using Docker.

## Tools Used

- Format: [black](https://pypi.org/project/black/)
- Lint: [flake8](https://pypi.org/project/flake8/)
- Test: [pytest](https://pypi.org/project/pytest/)
- SAST: [bandit](https://pypi.org/project/bandit/)
  
## Prerequisites

- Docker
- Docker Compose or Compose V2 plugin for docker
- Make

## Getting Started

1. Clone this repository
2. Customize the `Dockerfile` and `compose.yml` as needed for your project
3. Use the provided Makefile commands to manage your project

## Makefile Commands

Here are the available commands you can use with `make`:

```
make lint      Run linter
make format    Run formatter
make test      Run tests
make publish   Publish the application
make shell     Open a shell in a specific service (prompts for service name)
make clean     Remove all Docker resources related to this project
make check     Run format, lint, and test in sequence
make help      Display this help message
```

### Using the Commands

To use any of these commands, simply run `make` followed by the command name. For example:

```bash
make lint
```

This will run the linter on your code.

### The `shell` Command

The `shell` command is interactive. When you run `make shell`, you'll be prompted to enter the name of the service you want to open a shell in. For example:

```bash
$ make shell
Enter service name: app
Opening shell in app
# You're now in a shell inside the 'app' service
```

### The `check` Command

The `check` command runs `format`, `lint`, and `test` in sequence. This is useful for quickly checking your code before committing or deploying.

```bash
make check
```

## Docker Cache and Building

By default, Docker uses caching to speed up build times. However, there may be times when you want to disable caching to ensure a clean build.

### Overriding Docker Cache

You can override the Docker cache in two ways:

1. **Using Make Command**

   Use the `USE_DOCKER_CACHE=false` flag with your make command:

   ```bash
   make lint USE_DOCKER_CACHE=false
   ```

2. **Using Environment Variables**

   Set the `USE_DOCKER_CACHE` environment variable before running make:

   ```bash
   export USE_DOCKER_CACHE=false
   make lint
   ```

### Why Override Cache?

You might want to disable caching in these scenarios:

1. When you've made changes to your Dockerfile or any files copied into the image during the build process.
2. When debugging build issues.
3. When you want to ensure a completely clean build, e.g., for production releases.

### Examples

1. Running tests without cache:
   ```bash
   make test USE_DOCKER_CACHE=false
   ```

2. Formatting code with a fresh build:
   ```bash
   make format USE_DOCKER_CACHE=false
   ```

3. Setting the environment variable and then running multiple commands:
   ```bash
   export USE_DOCKER_CACHE=false
   make lint
   make test
   make publish
   ```

Remember to set `USE_DOCKER_CACHE` back to `true` (or unset the environment variable) when you want to re-enable caching:

```bash
export USE_DOCKER_CACHE=true
```

or

```bash
unset USE_DOCKER_CACHE
```

## Cleaning Up

To remove all Docker resources related to this project, including images, volumes, and orphaned containers, run:

```bash
make clean
```

## Testing

The project includes a comprehensive test suite to ensure that the code behaves as expected under a variety of conditions. Even though some functions might be simple, the tests are designed to cover multiple scenarios to guarantee robustness.

### Test Scenarios

The test suite includes the following checks:

1. **Basic Output Check**: Ensures that the function prints the expected output.
2. **No Side Effects**: Verifies that calling the function multiple times does not alter its behavior.
3. **Return Value Check**: Confirms that the function does not return any unexpected values.
4. **Stdin Interaction**: Ensures that the function does not inadvertently read from stdin unless intended.
5. **Redirection of Stdout**: Tests how the function behaves when stdout is redirected.
6. **Exception Handling**: Verifies that the function does not raise any unexpected exceptions.
7. **Environment Variables**: Checks how the function behaves with specific environment variables set.
8. **Execution in Different Directories**: Ensures that the function works correctly when called from a different directory.

### Why Such Thorough Testing?

Thorough testing is important for several reasons:

- **Future-Proofing**: If the function is extended or modified in the future, the tests ensure that it continues to behave correctly.
- **Edge Case Coverage**: Testing various scenarios helps catch edge cases that might not be immediately obvious.
- **Reliability**: The tests provide confidence that the code is reliable and will behave as expected in different environments and under different conditions.

You can run the tests using the following command:

```bash
make test
```

## Contributing

(Add your contribution guidelines here)

## License

(Add your license information here)