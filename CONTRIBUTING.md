# Contributing to TcTool

Thank you for your interest in contributing to TcTool! This document provides guidelines and information for contributors.

## Code of Conduct

Please be respectful and constructive in all interactions. We welcome contributors of all experience levels.

## How to Contribute

### Reporting Bugs

1. Check existing issues to avoid duplicates
2. Use the bug report template
3. Include:
   - Python version
   - Operating system
   - Steps to reproduce
   - Expected vs actual behavior
   - Sample files if applicable

### Suggesting Features

1. Check existing issues/discussions
2. Describe the use case clearly
3. Explain why this would benefit other users

### Pull Requests

1. Fork the repository
2. Create a feature branch from `main`
3. Make your changes
4. Add/update tests as needed
5. Ensure all tests pass
6. Update documentation if needed
7. Submit a pull request

## Development Setup

### Prerequisites

- Python 3.10 or higher
- Git

### Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/tctool.git
cd tctool

# Create virtual environment
python -m venv .venv

# Activate (Windows)
.venv\Scripts\activate

# Activate (Unix/macOS)
source .venv/bin/activate

# Install in development mode with dev dependencies
pip install -e ".[dev]"

# Install pre-commit hooks
pre-commit install
```

### Running Tests

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=tctool --cov-report=html

# Run specific test categories
pytest -m unit          # Unit tests only
pytest -m integration   # Integration tests only
pytest -m e2e          # End-to-end tests only

# Run specific test file
pytest tests/unit/test_st_formatter.py

# Run with verbose output
pytest -v
```

### Code Quality

```bash
# Run linter
ruff check .

# Run formatter check
ruff format --check .

# Run type checker
mypy src/tctool

# Auto-fix linting issues
ruff check --fix .

# Auto-format code
ruff format .

# Run all pre-commit hooks
pre-commit run --all-files
```

## Code Style

### General Guidelines

- Follow PEP 8 style guide
- Use type hints for all public functions
- Write docstrings for modules, classes, and public functions
- Keep functions focused and small
- Prefer composition over inheritance

### Naming Conventions

- Classes: `PascalCase`
- Functions/methods: `snake_case`
- Constants: `UPPER_SNAKE_CASE`
- Private attributes: `_leading_underscore`
- Type variables: `T`, `TKey`, `TValue`

### Documentation

- Use Google-style docstrings
- Include examples in docstrings for complex functions
- Update README.md for user-facing changes
- Update CHANGELOG.md for all notable changes

### Example Docstring

```python
def convert_file(input_path: Path, output_path: Path) -> bool:
    """Convert a single ST file to TwinCAT XML.

    Args:
        input_path: Path to the input .st file.
        output_path: Path for the output .TcPOU file.

    Returns:
        True if conversion succeeded, False otherwise.

    Raises:
        ValueError: If input file is not a valid ST file.
        FileNotFoundError: If input file does not exist.

    Example:
        >>> convert_file(Path("FB_Motor.st"), Path("output/FB_Motor.TcPOU"))
        True
    """
```

## Project Structure

```
tctool/
├── src/tctool/           # Main package
│   ├── core/             # Shared components
│   ├── converters/       # Format converters
│   └── formatters/       # Code formatters/linters
├── tests/
│   ├── unit/             # Unit tests
│   ├── integration/      # Integration tests
│   ├── e2e/              # End-to-end tests
│   └── fixtures/         # Test fixtures
├── .github/workflows/    # CI/CD pipelines
└── docs/                 # Documentation (future)
```

## Testing Guidelines

### Test Categories

- **Unit tests**: Test individual functions/classes in isolation
- **Integration tests**: Test module interactions
- **E2E tests**: Test CLI commands and full workflows

### Test File Naming

- Unit: `tests/unit/test_<module>.py`
- Integration: `tests/integration/test_<feature>.py`
- E2E: `tests/e2e/test_<command>_cli.py`

### Writing Tests

```python
import pytest
from tctool.formatters.st_formatter import STFormatter

class TestSTFormatter:
    """Tests for STFormatter class."""

    def test_format_empty_content(self):
        """Format should handle empty content."""
        formatter = STFormatter()
        result = formatter.format("")
        assert result == ""

    @pytest.mark.parametrize("input_text,expected", [
        ("IF x THEN\ny := 1;\nEND_IF", "IF x THEN\n    y := 1;\nEND_IF"),
        # More test cases...
    ])
    def test_format_if_blocks(self, input_text: str, expected: str):
        """Format should properly indent IF blocks."""
        formatter = STFormatter()
        assert formatter.format(input_text) == expected
```

## Release Process

1. Update version in `pyproject.toml`
2. Update `CHANGELOG.md`
3. Create a git tag: `git tag v0.1.0`
4. Push tag: `git push origin v0.1.0`
5. GitHub Actions will automatically publish to PyPI

## Getting Help

- Open an issue for bugs or feature requests
- Start a discussion for questions or ideas
- Tag maintainers for urgent issues

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
