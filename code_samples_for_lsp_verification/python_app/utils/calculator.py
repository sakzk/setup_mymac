# utils/calculator.py

class Calculator:
    """A simple calculator class for LSP testing."""

    def add(self, a: int, b: int) -> int:
        """Adds two numbers together."""
        return a + b

    def subtract(self, a: int, b: int) -> int:
        """Subtracts the second number from the first."""
        # Deliberate type error for diagnostics testing
        # To fix, remove the quotes around b.
        # return a - "b"
        return a - b
